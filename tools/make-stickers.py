"""Turns the checkerboard-background sticker JPGs into clean transparent PNGs.

The sticker art is printed on a white die-cut ring over a fake-transparency
checkerboard. A flood fill walks inward from the image border and clears every
dark pixel it can reach. The white ring is brighter than WALL, so the fill stops
there and the black ink inside the sticker is never touched.

    python -m pip install pillow
    python tools/make-stickers.py

Edit JOBS to point at new source files and their target sizes.
"""

from collections import deque
import os

from PIL import Image

# (source, output name, max edge in px)
JOBS = [
    (r"C:\Users\Dwa\Documents\52c113261b11744f4723bd107c4c40d7.jpg", "brain.png", 620),
    (r"C:\Users\Dwa\Documents\2077ac8070f36f8c94105a9d2d35d115.jpg", "laptop.png", 560),
    (r"C:\Users\Dwa\Documents\cdd7c4861b626d3fc4176ecded311a75.jpg", "wifi.png", 480),
]

OUT_DIR = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "assets")
WALL = 200      # luminance at or above this stops the flood (the white die-cut ring)
PALETTE = 96    # halftone survives a small palette; keeps the files light


def key_out_background(img: Image.Image) -> Image.Image:
    img = img.convert("RGB")
    w, h = img.size
    px = img.load()
    seen = bytearray(w * h)
    alpha = Image.new("L", (w, h), 255)
    ap = alpha.load()

    q = deque()
    for x in range(w):
        q.append((x, 0))
        q.append((x, h - 1))
    for y in range(h):
        q.append((0, y))
        q.append((w - 1, y))

    while q:
        x, y = q.popleft()
        idx = y * w + x
        if seen[idx]:
            continue
        seen[idx] = 1
        r, g, b = px[x, y]
        if (r * 299 + g * 587 + b * 114) // 1000 >= WALL:
            continue
        ap[x, y] = 0
        if x > 0:
            q.append((x - 1, y))
        if x + 1 < w:
            q.append((x + 1, y))
        if y > 0:
            q.append((x, y - 1))
        if y + 1 < h:
            q.append((x, y + 1))

    out = img.convert("RGBA")
    out.putalpha(alpha)
    return out


def trim(img: Image.Image, pad: int = 6) -> Image.Image:
    bbox = img.getbbox()
    if not bbox:
        return img
    left, top, right, bottom = bbox
    return img.crop((
        max(0, left - pad),
        max(0, top - pad),
        min(img.width, right + pad),
        min(img.height, bottom + pad),
    ))


def main() -> None:
    os.makedirs(OUT_DIR, exist_ok=True)
    for src, name, size in JOBS:
        cut = trim(key_out_background(Image.open(src)))
        cut.thumbnail((size, size), Image.LANCZOS)
        cut = cut.quantize(colors=PALETTE, method=Image.FASTOCTREE)
        path = os.path.join(OUT_DIR, name)
        cut.save(path, "PNG", optimize=True)
        print(f"{name}: {cut.size[0]}x{cut.size[1]}  {os.path.getsize(path) // 1024} KB")


if __name__ == "__main__":
    main()

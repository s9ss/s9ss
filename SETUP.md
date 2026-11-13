# s9ss profile

Dark profile README. Wifi sticker, name plate, badge row, three sections, a quote, a contribution chart.

```
github-profile/
├── README.md
├── tools/
│   ├── make-contribution.ps1   regenerates the chart
│   └── make-stickers.py        re-keys the sticker PNGs
└── assets/
    ├── wifi.png           sticker, transparent
    ├── brain.png          sticker, transparent
    ├── laptop.png         sticker, transparent
    ├── banner.svg         name plate
    ├── rule.svg           section divider
    └── contribution.svg   generated chart
```

The three stickers are the original halftone art with the fake-transparency checkerboard keyed out, so they sit clean on the dark page.

## layout

| block | source |
| :-- | :-- |
| wifi | `assets/wifi.png`, centered, above the plate |
| name | `assets/banner.svg` — SAUD AL-MUTAIRI + accent rule |
| stars / collab / followers | shields.io, dark (`0B0E13` / `1C2430`) |
| Know About Me | prose + `brain.png` floated right |
| Top Projects | bullet list + `laptop.png` floated right |
| Connect | GitHub + mail buttons |
| quote | markdown blockquote |
| Contribution | `assets/contribution.svg` |

## palette

```
panel   #0B0E13 to #141B24
ink     #E6EDF3
muted   #68788A
accent  #5B9DFF
```

## stickers

Source JPGs have a checkerboard painted in where transparency should be. `tools/make-stickers.py` flood-fills from the image border over dark pixels and stops at the white die-cut ring, so the black ink inside survives. Output is quantized to 96 colours — halftone holds, file stays under 60 KB.

```
python -m pip install pillow
python tools/make-stickers.py
```

Edit the `JOBS` list at the top to point at new source files and their target sizes.

## editing

- Name: one `<text>` in `banner.svg`. Change the string, then match the accent rule length under it.
- `rule.svg` is a faded line plus one accent diamond; it stretches to any width.
- README art sizes: wifi `104`, brain `200`, laptop `170`.

## links

- Mail badge points at `saud1221@proton.me`.
- LinkedIn and resume badges were removed.

## refreshing the chart

```
powershell -ExecutionPolicy Bypass -File tools/make-contribution.ps1
```

Reads the public contribution calendar for `s9ss`, groups the last twelve months, rewrites `assets/contribution.svg`. No token required.

## cache gotcha

`github.com/<owner>/<repo>/raw/...` answers with a 302 to `raw.githubusercontent.com`, and the query string is dropped on the way. That host caches by path for a few minutes, so a fresh push can keep serving the old bytes for up to about five minutes no matter what you append to the URL. The image paths therefore carry no version query — it would only be decoration. Wait it out, or check the file in the blob view instead of the profile page.

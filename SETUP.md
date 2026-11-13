# setup — s9ss profile, 10 minutes

The whole build lives in `github-profile/`. Copy it into a repo named exactly `s9ss`.

## 1. create the special repo

GitHub only reads a profile README from a repo whose name matches your handle.

- Repo name: **`s9ss`** (must equal your username exactly)
- Visibility: **Public**
- Check **Add a README file** — you'll overwrite it anyway

## 2. drop the files in

Repo root ends up like this:

```
s9ss/
├── README.md
├── assets/
│   ├── banner.svg
│   ├── divider.svg
│   └── footer.svg
└── .github/
    └── workflows/
        └── snake.yml
```

Easiest path — from your machine:

```bash
git clone https://github.com/s9ss/s9ss.git
cd s9ss
# copy README.md, assets/, .github/ from github-profile/ into this folder
git add .
git commit -m "profile: animated rebuild"
git push
```

The README renders the moment it hits `main`.

## 3. let the snake workflow write

`snake.yml` regenerates the bottom snake SVG every 12 hours and pushes it to an `output` branch.

- Repo → **Settings → Actions → General**
- **Workflow permissions** → select **Read and write permissions**
- Save
- Repo → **Actions** → **generate contribution snake** → **Run workflow**

First run takes ~60s. Until it finishes the snake image 404s — that's expected, it's the only thing on the page that needs the run.

## 4. personalise the placeholders

Search `README.md` for these and swap:

| Placeholder | Where |
| :-- | :-- |
| `you@example.com` | contact row, bottom |
| `https://linkedin.com/in/your-handle` | contact row |
| `https://x.com/your-handle` | contact row |
| `Saud AL-Mutairi` | `banner.svg` — the `<text>` near y=160 |
| `CS Student · SQL AI Engineer · Riyadh` | `banner.svg` — `<text>` near y=206 |
| stack badges | delete/keep rows under `~ stack` |

Banner text is plain SVG `<text>` — edit the string, keep `text-anchor="middle"` and it stays centred.

## 5. what each piece is

| Piece | What it does |
| :-- | :-- |
| `banner.svg` | animated name plate — drifting glow blobs, gradient sweep on the letters, blinking caret |
| `divider.svg` | hairline with a dot that sweeps across every 5s |
| `footer.svg` | looping dual wave with build credit |
| typing SVG | hosted service, types the tagline on load |
| stats / streak / langs / trophies | hosted cards, themed `0D1117` + `39D353` to match the banner |
| activity graph | hosted, area-filled contribution curve |
| `snake.yml` | builds the contribution-grid snake into the `output` branch |

## 6. first-week wins, optional

- Pin 3–6 repos — empty pin grid is the loudest thing on a fresh profile
- Make at least one repo public so `~ stats` isn't a wall of zeros
- The contribution graph fills from commits, not from this README; a daily tiny commit beats a weekly big one

## notes

- Theme is locked to GitHub dark (`0D1117` bg, `39D353` green). On light mode the hosted cards stay dark — that's intentional, one consistent look.
- If `github-readme-stats` rate-limits, deploy your own copy on Vercel and swap the domain. Same for the trophy and activity-graph instances.
- The animated SVGs are self-hosted on purpose: no third-party availability risk, and every animation keeps working even if a badges service dies.

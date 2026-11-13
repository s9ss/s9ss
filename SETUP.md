# s9ss profile

Dark, ink-on-paper profile README. Banner, badge row, three sections, a quote, a contribution graph.

```
github-profile/
├── README.md
└── assets/
    ├── banner.svg   brush wordmark + ink portrait on a white disc
    ├── rule.svg     section divider
    ├── brain.svg    Know About Me art
    └── flame.svg    Top Projects art
```

`session.svg` and `footer.svg` are from the previous layout and are no longer referenced. Delete them if you don't want them back.

## layout

| block | source |
| :-- | :-- |
| banner | `assets/banner.svg`, full width |
| stars / repos / followers | shields.io, dark (`0B0E13` / `1C2430`) |
| Know About Me | prose + `brain.svg` floated right |
| Top Projects | bullet list + `flame.svg` floated right |
| Connect | shields.io buttons, one per link |
| quote | markdown blockquote |
| Contribution | `github-readme-activity-graph` for `s9ss` |

## palette

```
panel   #0B0E13 to #141B24
ink     #E6EDF3
muted   #68788A
accent  #5B9DFF
paper   #F2F5F9   (the disc behind the portrait)
```

The accent only appears in the divider notch and the activity graph line. The portrait is black on paper, so it keeps the ink look on a dark page.

## editing

- Fonts are system stacks. SVG inside an `<img>` cannot load webfonts, so the wordmark is Georgia italic and everything else falls back to Segoe UI / Inter.
- Wordmark: one `<text>` in `banner.svg`. Change `Synax!` to your handle and the underline path length with it.
- Portrait: pure shapes inside `<g clip-path="url(#disc)">` — hair path, face ellipse, fringe, eyes, brows, mouth, three highlight strokes. Edit coordinates, keep the order (hair → face → fringe → features).
- `rule.svg` is a faded line plus one accent diamond; it stretches to any width.
- `README.md` art sizes: brain `190`, flame `140`. Both sit right of the text via `<img align="right">`, with `<br clear="right" />` after the block.

## links to fill

- `linkedin.com/in/saud` — replace with your real profile slug
- `mailto:hello@example.com` — replace with your address
- `assets/resume.pdf` — drop the PDF in, or delete that badge

## cache gotcha

`raw.githubusercontent` caches for a few minutes and ignores query strings, so a fresh push can keep serving old bytes for up to about five. The image paths carry `?v=1`. Bump that number on every edit so GitHub's own proxy re-resolves the file.

# s9ss profile

Two hand drawn SVGs and a short README. No badges, no stats cards, no typing GIF.

```
s9ss/
├── README.md
└── assets/
    ├── session.svg    header: a late night terminal log
    └── footer.svg     typographic footer
```

## what moves

| file | motion |
| :-- | :-- |
| `session.svg` | nine log lines print in one at a time, the caret breathes on a 1.9s sine |
| `footer.svg` | accent caret breathes, a soft line travels the rule every 8s |

Pure SVG with CSS keyframes. Nothing is fetched at runtime, so nothing can go down. Both files also stop moving entirely under `prefers-reduced-motion: reduce`.

## palette

```
panel   #0B0E13 to #141B24
ink     #E6EDF3
muted   #68788A
accent  #5B9DFF
```

One accent, used for prompts, the caret and the footer caret. Nowhere else.

## editing

- Fonts are system stacks. SVG inside an `<img>` cannot load webfonts. Headings fall back to Inter, SF Pro, Segoe UI. Body is JetBrains Mono, SF Mono, Consolas.
- All text is plain `<text>`. Edit the string, keep `text-anchor` and the coordinates.
- Log lines are `g` groups classed `.l1` through `.l9`. Each carries its own `animation-delay`. Add one by copying a group and giving it the next delay step (about 160ms).
- The caret sits at a fixed x. Move it when you change the length of the line it follows.

## cache gotcha

`raw.githubusercontent` caches for a few minutes and ignores query strings, so a fresh push can keep serving old bytes for up to about five. The image paths carry `?v=6`. Bump that number on every edit so GitHub's own proxy re-resolves the file.

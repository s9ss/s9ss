# s9ss profile

Two SVG artifacts and a README of SQL. No badge wall, no stats cards, no typing GIF.

```
s9ss/
├── README.md
└── assets/
    ├── session.svg    ← the header: a live database session
    └── footer.svg     ← typographic footer
```

## what moves

| file | motion |
| :-- | :-- |
| `session.svg` | query types in character by character (mask + CSS `steps()`), table rows cascade in on a stagger, accent scan-bar sweeps the rows forever, cursor blinks |
| `footer.svg` | caret blinks, accent dot travels the baseline every 7s |

Both are pure SVG with CSS keyframes. No scripts, no external requests, no service that can go down. They render as `<img>` on GitHub, so only inline CSS and SMIL survive — everything here is inside that envelope.

## palette

```
paper   #F4F0E6
ink     #14110F
muted   #7A7065
accent  #C2410C
```

One accent, used only for the prompt, the cursor, the scan bar and the row count.

## editing

- Fonts are system stacks on purpose. SVG inside `<img>` cannot load webfonts. Serif is `Iowan Old Style / Palatino / Georgia`; mono is `JetBrains Mono / SF Mono / Consolas`. If a viewer lacks all of them, the fallback still reads correctly.
- Text is plain `<text>` — edit the string, keep `text-anchor` and coordinates and it stays put.
- The typewriter mask width (`520px`) is tuned to the current query string. Longer query → bump the `@keyframes type` end width and the mask rect width together, or the tail gets clipped.
- Row stagger lives in `.row-1` … `.row-4` `animation-delay`. Add a row: duplicate the group, add `.row-N` with the next delay, shift the `y` values.

## repo setup

The profile README only loads from a public repo named exactly `s9ss`. That's it — no Actions, no secrets, nothing to keep alive.

# Project banners

Source files for the four project banners used in the profile README
(`assets/projects/*.jpg`). Each banner is plain HTML/CSS rendered to a
1280×480 JPEG by `render.sh`, so text stays crisp and updates are a one-line
change instead of re-exporting from a design tool.

## Files

| File | Output |
| --- | --- |
| `markdown-converter.html` | `../projects/markdown-converter-banner.jpg` |
| `bumdesma-absensi.html` | `../projects/bumdesma-absensi-banner.jpg` |
| `wgym.html` | `../projects/wgym-banner.jpg` |
| `jarvis.html` | `../projects/jarvis-rust.jpg` |
| `base.css` | shared HUD layout, frame, typography, preview panel |
| `images/` | source assets (app screenshot, dashboard, logo, artwork) |

## Rendering

Requirements: Chrome or Chromium, plus `ffmpeg`.

```bash
cd assets/banners

./render.sh              # all four banners
./render.sh wgym         # just one
QUALITY=2 ./render.sh     # better JPEG quality (default 3, lower is better)
CHROME=/path/to/chrome ./render.sh
```

Then commit the updated JPEGs in `assets/projects/`.

## Editing a banner

- **Text, chips, repo URL** — edit the HTML file directly. `PROJECT 0X // TYPE`
  is the eyebrow line, `h1` holds the title, `h1 span` the subtitle.
- **Colors** — every banner sets its palette in an inline `:root` block at the
  top of the HTML. `--a1`/`--a2` are the radial glow colors, `--grid` the grid
  tint, `--accent-ink`/`--accent-line` the eyebrow, `--h1-end` the title
  gradient, `--span-1`/`--span-2` the subtitle gradient, and
  `--panel-glow`/`--panel-border` the preview panel.
- **Layout and spacing** — change `base.css` once; all four banners follow.
- **Preview image** — use `class="shot"` for a full screenshot (whole UI
  visible), `class="cover"` for full-bleed artwork, or the `.stage` + `.ring`
  markup for a centered app icon. Drop the new file in `images/` and point the
  `src` at it.

## Notes

- `images/markdown-converter.png` is a screenshot of the live demo
  (<https://markdown-converter-web.dhitopratama2005.workers.dev/>) with sample
  Markdown typed in; recapture it if the UI changes.
- `images/absensi-dashboard.png` comes from
  `bumdesma-absensi/frontend/screenshots/dashboard.png`, cropped to remove the
  browser chrome.
- `images/wgym-logo.jpg` is the W-GYM app icon with its outer padding cropped.
- `images/jarvis-panel.jpg` is a crop of the JARVIS artwork used in the README
  sticker (logo + face), sized for the preview panel.
- Fonts (Orbitron, Rajdhani) load from Google Fonts; the script waits for them
  via `--virtual-time-budget`.

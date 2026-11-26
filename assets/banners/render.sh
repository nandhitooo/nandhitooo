#!/usr/bin/env bash
# Render the four project banners (1280x480) into ../projects/*.jpg
#
# Requirements: Chrome/Chromium and ffmpeg.
# Usage:
#   ./render.sh              # render every banner
#   ./render.sh wgym         # render only one (name without .html)
#   CHROME=/path/to/chrome ./render.sh
#
# Override the JPEG quality with QUALITY=2..31 (lower = better, default 3).

set -euo pipefail
cd "$(dirname "$0")"

CHROME="${CHROME:-$(command -v google-chrome-stable || command -v google-chrome || command -v chromium || command -v chromium-browser || true)}"
if [ -z "$CHROME" ]; then
  echo "error: Chrome/Chromium not found. Set CHROME=/path/to/chrome" >&2
  exit 1
fi
command -v ffmpeg >/dev/null || { echo "error: ffmpeg not found" >&2; exit 1; }

OUT_DIR="../projects"
QUALITY="${QUALITY:-3}"
mkdir -p "$OUT_DIR"

# banner-name:output-file
BANNERS=(
  "markdown-converter:markdown-converter-banner.jpg"
  "bumdesma-absensi:bumdesma-absensi-banner.jpg"
  "wgym:wgym-banner.jpg"
  "jarvis:jarvis-rust.jpg"
)

only="${1:-}"

for entry in "${BANNERS[@]}"; do
  name="${entry%%:*}"
  out="${entry##*:}"
  if [ -n "$only" ] && [ "$only" != "$name" ]; then
    continue
  fi

  tmp="$(mktemp --suffix=.png)"
  "$CHROME" \
    --headless=new --no-sandbox --disable-gpu --hide-scrollbars \
    --allow-file-access-from-files --force-device-scale-factor=1 \
    --window-size=1280,480 --virtual-time-budget=7000 \
    --screenshot="$tmp" "file://$PWD/$name.html" >/dev/null 2>&1

  ffmpeg -loglevel error -y -i "$tmp" -q:v "$QUALITY" "$OUT_DIR/$out"
  rm -f "$tmp"
  echo "rendered $OUT_DIR/$out"
done

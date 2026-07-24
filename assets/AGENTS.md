# Instructions for `assets`

- These files are browser UI used through BYOND controls, not a standalone modern web
  application. Maintain compatibility with the embedded BYOND client browser.
- Search `RT.dmf` and DM calls to `browse`, `output`, `winset`, `winget`, and `winshow`
  for every affected window/control name.
- Keep changes dependency-free unless explicitly approved. Do not introduce a build
  pipeline or framework for a small UI fix.
- Escape user-generated content and respect existing size/sanitization limits.
- Test inside the actual BYOND client; desktop browser success alone is insufficient.

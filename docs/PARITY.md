# Evidence for a later port

A leading platform provides a behavioral reference, not an obligation to copy its pixels.
The destination should use native navigation, permissions, typography, accessibility, and layouts.

## A small port packet

For a useful completed feature, adapt [templates/PORT.md](templates/PORT.md) into a note under
`docs/evidence/<feature>/`. Capture enough for another agent to reproduce the behavior:

- Source target, source commit (or explicitly uncommitted state), app build/configuration,
  OS, device class, viewport/density, theme, text scale, and locale where relevant.
- Setup with synthetic data; the steps to reach representative success, empty, and failure states.
- The shared core operations and rule outcomes, plus important gestures and lifecycle behavior.
- A few actual app screenshots, each labeled with state and capture context. Replace stale images
  rather than accumulating near-duplicates. Include a tablet/desktop view only if selected.
- Intentional platform differences, known gaps, human review status, and the next port step.

Screenshots cannot explain permissions, offline behavior, data persistence, keyboard focus,
accessibility, or background execution alone. Use short notes for behavior that an image cannot show.
Design mockups may be useful but must be labeled as mockups, separate from runtime evidence.

## Capture and review

Use a brief `adb`/simulator capture or ask the user for inspection when manual work is easier.
Avoid lengthy GUI automation. A lower-cost inspection model/subagent may do authorized visual
inspection when available; do not require one for contributors. Never change or seed a real user's data to obtain a screenshot.

If capture or inspection is unavailable, record the missing evidence and exact steps for a human.
Do not invent screenshots or call a feature visually accepted. A deferred port can still have a
useful packet with explicit gaps.

When the second platform implements the feature, run the same behavioral scenarios, document
native differences, and record validation separately. Matching the first platform's screenshot
does not prove the core rules, lifecycle, or persistence work.

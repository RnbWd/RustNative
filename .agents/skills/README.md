# Repository workflows

These skills are small instruction files, not platform SDKs or installed third-party packages.
They use this repository's docs and official references. They do not grant extra permissions.

| Skill | Use |
| --- | --- |
| [native-feature](native-feature/SKILL.md) | Deliver a small feature in the selected mode; coordinate only when requested |
| [native-android](native-android/SKILL.md) | Kotlin/Compose work and the Android side of the Rust boundary |
| [native-apple](native-apple/SKILL.md) | Swift/SwiftUI work and the selected Apple side of the Rust boundary |

Agents with repository skill discovery can use `.agents/skills/`; Claude Code finds the same
files through the `.claude/skills` symlink and reads `AGENTS.md` through `CLAUDE.md`. Edit only
`.agents/skills/`; on Windows, enable Git symlinks. If the current tool does not discover
them, ask it to read the relevant `SKILL.md` directly. No global installation is needed.
Other agents can start from [root AGENTS.md](../../AGENTS.md) and use the same workflow manually.

Each skill routes to maintained project documents rather than copying a vendor manual. Check
current official APIs and the app's selected versions during implementation. Add specialized
skills only when real features require them; do not preload media, sync, billing, or store tooling.

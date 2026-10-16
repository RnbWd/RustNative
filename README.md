# RustNative

Build native apps with a shared Rust core and AI agents that understand each platform.

RustNative is an open source **starter and working method**: Kotlin + Jetpack Compose on
Android, Swift + SwiftUI on Apple, and Mozilla's [UniFFI](https://mozilla.github.io/uniffi-rs/latest/)
to generate bindings to shared Rust logic. Each app uses the platform's UI and device APIs.

**Current status: starter docs and tooling.** There is no runnable app, Cargo workspace, native
project, or generated binding. Native build/run/install scripts are explicit placeholders.
The default is **Android only**; iOS, iPadOS, and macOS can be activated later.

## Why this exists

Small apps should have a small, understandable codebase. Share the rules that benefit from
one implementation; let native code own screens, navigation, accessibility, and device services.
Agents work from the same product behavior and Rust API contract, with clear ownership when
platform work happens in parallel.

This approach trades a shared UI framework for two native UI implementations and a Rust
integration. It aims to reduce application complexity, but makes no fixed claim about code size,
binary size, or development speed. Measure those in the app you actually build.

## Start a project

1. Use GitHub's **Use this template** after the repository is published and marked as a template,
   or copy this directory into a new repository without its `.git` directory.
2. Fill in [docs/PROJECT.md](docs/PROJECT.md): app purpose, active targets, and delivery mode.
   Keep `android-only` for a first Android app.
3. Describe the first small feature in [docs/PRODUCT.md](docs/PRODUCT.md). Choose app/package
   identifiers before creating native projects; there is no template identifier to rename.
4. Give an agent the prompt below. It should read [AGENTS.md](AGENTS.md), activate only the
   selected targets, and build one working slice through the native UI and Rust boundary.

```text
Use this RustNative starter for my app: [describe the app and its first useful feature].
Work in android-only mode. Read AGENTS.md and docs/PROJECT.md first.
Create the smallest native Android app and shared Rust core that deliver that feature.
Verify a real UniFFI call and typed error in a release build before expanding the architecture.
Keep Apple inactive and record enough behavior and screenshots to support a later port.
```

The starter needs Bash and Python 3.9+ for its own checks; it installs no native toolchain.
These commands work now:

```sh
./scripts/test.sh template
./scripts/bootstrap.sh android
./scripts/clean.sh
```

Bootstrap prints a checklist; clean previews repo build output. Device listing uses installed
Android/Xcode tools. Native task placeholders print what remains to implement and exit 2.
The [OrganizerMD dashboard](organizermd.json) groups build, test, run, install, device, and tools
actions, with explicit exclusions for build trees. See [scripts/README.md](scripts/README.md)
and [docs/ORGANIZERMD.md](docs/ORGANIZERMD.md) for the commands and device-selection rules.

When an app is scaffolded, add its exact install/build/run commands here and wire the scripts
and dashboard together. Follow the activation checklist in [docs/TOOLCHAIN.md](docs/TOOLCHAIN.md).

## Choose how to work

| Mode | Active work | Inactive platform |
| --- | --- | --- |
| `android-only` (default) | Android + Rust | Apple stays dormant; retain useful port notes |
| `apple-only` | Selected Apple targets + Rust | Android stays dormant; retain useful port notes |
| `dual` | Android + selected Apple targets + Rust | Verify each active target separately |

Start with one agent. For dual work, choose either two platform chats with an assigned
integration owner, or a coordinator with one Android and one Apple subagent. The workflow
defines ownership, contract changes, and handoffs in [docs/WORKFLOW.md](docs/WORKFLOW.md).
It does not require parallel agents for single-platform work.

If one platform leads, capture its behavior and a few representative screenshots using
[docs/PARITY.md](docs/PARITY.md). A port should preserve product behavior and use the
destination platform's conventions. Matching pixels is optional.

## Repository map

```text
AGENTS.md                 instructions for any coding agent
CLAUDE.md                 imports AGENTS.md for Claude Code
ARCHITECTURE.md           boundaries, data flow, and design defaults
core/                     reserved for shared Rust; instructions only
android/                  reserved for Kotlin/Compose; instructions only
apple/                    reserved for Swift/SwiftUI; instructions only
.agents/skills/           reusable feature, Android, and Apple workflows
.claude/skills            symlink to .agents/skills for Claude Code
scripts/                  template checks, inventory, cleanup, setup and native-task stubs
organizermd.json          shared dashboard actions and document-scan exclusions
docs/PROJECT.md           active targets and app-specific decisions
docs/PRODUCT.md           behavior and feature status
docs/CORE-API.md          the small shared API contract
docs/TOOLCHAIN.md         activation, version decisions, actual commands
docs/ORGANIZERMD.md       dashboard maintenance and device-selection rules
docs/WORKFLOW.md          solo, two-chat, and coordinator workflows
docs/PARITY.md            evidence and later ports
docs/DECISIONS.md         rationale, tradeoffs, and researched sources
docs/templates/           feature, port, and interruption notes
docs/evidence/            selected screenshots and their context
docs/handoffs/            temporary notes for unfinished work
```

The three local [skills](.agents/skills/README.md) are optional workflow aids. An agent that
doesn't support skills can follow the same files directly. No paid plugin or particular agent
vendor is required, and there is no automatic dependency or skill installation.

## Defaults worth keeping

- Rust owns shared product rules; native adapters own platform services and UI state.
- Generate a narrow typed API from Rust; keep generated artifacts out of source control.
- Add persistence, networking, sync, and a server only when the app needs them.
- Verify selected targets only. A build, a launch, and human acceptance are different evidence.
- Prefer focused tests and small changes; ask a human for lengthy or subjective device checks.

The [architecture](ARCHITECTURE.md) and [decision notes](docs/DECISIONS.md) explain the costs
and when a simpler native-only implementation could be a better fit.

## Contributing and license

See [CONTRIBUTING.md](CONTRIBUTING.md). Code and documentation are [MIT licensed](LICENSE).
RustNative is an independent project and is not affiliated with Mozilla, Google, or Apple.

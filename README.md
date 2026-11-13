# RustNative

Build original personal apps for the web, Android, iPhone, iPad, or Mac.

RustNative is an open source **starter and working method**. Choose a primary platform and
build one useful feature there. Use conventional web technologies in the browser, Kotlin and
Jetpack Compose on Android, and SwiftUI on Apple with AppKit for macOS behavior where needed.
Use Rust for portable rules when reuse pays off, with [UniFFI](https://mozilla.github.io/uniffi-rs/latest/)
as the default bridge for native apps that call Rust.

**Current status: starter docs and tooling.** Project selection is open. Native build, run,
and install scripts are explicit placeholders.

## Why this exists

Small apps should have a small, understandable codebase. Share the rules that benefit from
one implementation; let each platform own screens, navigation, accessibility, and device services.
Use a small behavioral reference when porting. A direct native port gives the UI its own
implementation and may add a Rust integration. Measure whether that trade pays off for the app.

## Start a project

1. Use GitHub's **Use this template** after the repository is published and marked as a template,
   or copy this directory into a new repository without its `.git` directory.
2. Fill in [docs/PROJECT.md](docs/PROJECT.md) with the app purpose, one primary target, and the
   active target list.
3. Describe the first small feature in [docs/PRODUCT.md](docs/PRODUCT.md). Decide whether it
   needs storage, a server, or shared Rust based on the feature.
4. Give an agent the prompt below. It should read [AGENTS.md](AGENTS.md) and build one useful
   slice on the selected platform.

```text
Use this RustNative starter for my app: [describe the app and its first useful feature].
My primary target is [target] and my active targets are [list].
Read AGENTS.md and docs/PROJECT.md, then build one useful feature on the primary target.
Use the selected platform's conventions. Add Rust or a backend only if the feature needs it.
Verify the main interaction and a relevant failure case. Document the actual build/run commands
and track evidence for each affected active target.
```

The starter needs Bash and Python 3.9+ for its own checks; it installs no native toolchain.
These commands work now:

```sh
./scripts/test.sh template
./scripts/bootstrap.sh
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

Android-only, web-only, Apple-only, and mixed projects use the same selection and feature
workflow. Run `./scripts/bootstrap.sh` for the common checklist or pass an explicit target for
platform setup. Start with one agent even when several targets are active. See
[docs/WORKFLOW.md](docs/WORKFLOW.md) for optional coordination and handoffs.

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

- When Rust is used, it owns portable product rules. Each platform owns its services and UI state.
- Generate a narrow typed API from Rust; keep generated artifacts out of source control.
- Add persistence, networking, sync, and a server only when the app needs them.
- Verify selected targets only. A build, a launch, and human acceptance are different evidence.
- Prefer focused tests and small changes; ask a human for lengthy or subjective device checks.

The [architecture](ARCHITECTURE.md) and [decision notes](docs/DECISIONS.md) explain the costs
and when sharing a Rust core is worth the extra integration.

For a deeper review, start with the [ChatGPT research prompt](docs/prompts/chatgpt-research.md),
then give its report and the [Fable/Astra review prompt](docs/prompts/architecture-skills-review.md)
to a coding agent with the checkout.

## Contributing and license

See [CONTRIBUTING.md](CONTRIBUTING.md). Code and documentation are [MIT licensed](LICENSE).
RustNative is an independent project and is not affiliated with Mozilla, Google, or Apple.

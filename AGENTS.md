# Agent instructions

RustNative is a reusable native-app starter. Read [README.md](README.md),
[docs/PROJECT.md](docs/PROJECT.md), and [ARCHITECTURE.md](ARCHITECTURE.md) first.
Read platform instructions only for the area you change.

## Scope and working style

- Current phase: starter docs/tooling, no app. Do not scaffold an app until asked to build one.
- Default mode: `android-only`, one agent. The user's current request takes precedence over
  saved settings; update `docs/PROJECT.md` when the selection changes.
- Work on a few concrete tasks at a time. Make architectural decisions, keep dependencies
  modest, and leave an understandable result. Avoid speculative layers and large design docs.
- Keep this starter domain-neutral. App-specific requirements belong in a derived project's
  product docs. Do not import another app's identifiers, credentials, UI, or deployment policy.

## Boundaries

1. Shared product rules belong in `core/`. Native code owns UI state, navigation, accessibility,
   lifecycle, permissions, secure storage, and device APIs. See the architecture ownership table.
2. Describe a changed public core contract in `docs/CORE-API.md` before consumers implement it.
   Rust source defines the generated API; the document records semantics and status.
3. Never edit generated bindings or binaries. Regenerate them from the same source and pinned
   UniFFI version as the core. Keep generator/runtime versions aligned and checksums enabled.
4. Keep blocking Rust work off the UI thread. Define core lifetime, concurrency, and cancellation
   semantics before introducing a stateful object or asynchronous boundary.
5. Choose one owner for each durable dataset. Do not mirror business rules or maintain two
   competing databases. Native-only settings and temporary UI state may stay native.
6. Verify new dependency/tool versions with official sources. Record the selection and actual
   validation in `docs/TOOLCHAIN.md`; do not copy another app's toolchain blindly.
7. Keep secrets, signing keys, local device identifiers, user data, and generated builds out of
   Git. Prefer synthetic data for tests and screenshots. Never clear a real app's data to test it.

## Platform selection and coordination

- Inactive platforms need no scaffold, SDK, binding generation, build, or UI implementation.
  Record a port impact when shared behavior changes; mark inactive-platform validation deferred.
- One agent is the normal starting point. Use parallel platform agents only when the user
  chooses that workflow; follow [docs/WORKFLOW.md](docs/WORKFLOW.md).
- Assign an integration owner for `core/`, API contracts, shared docs, dependency versions, and
  generated build plumbing. Platform workers own `android/` or `apple/` and their feature evidence.
- Parallel workers are not alone in the codebase: preserve other work and accommodate shared
  changes. If separate checkouts are used, agree on a contract revision and integration base.
- Start separate chats or message other chats only when requested. A workflow description
  alone is not authorization to create chats or send messages.

## Verification and cost

- Test important rules, persistence, public boundaries, and regressions. Prefer focused tests;
  avoid suites that duplicate implementation details or cover speculative architecture.
- Documentation-only changes need link, structure, and instruction checks; no native builds.
- Run `./scripts/test.sh template` when scripts or `organizermd.json` change. Native task stubs
  must exit clearly as unfinished; do not treat them as successful app verification.
- For code changes, run the checks for affected active targets. Broaden only for a concrete
  reason. After an FFI change, regenerate and compile each active consumer.
- Exercise release integration early: debug builds can hide packaging and shrinking problems.
- Do not automate work that is substantially easier for a human. For extensive GUI flows,
  subjective visual checks, or simple manual measurements, ask for human inspection or use a
  lower-cost inspection model/subagent when available and authorized. Such a helper may research
  or inspect; it writes code only if the user explicitly asks, and its code must be reviewed.
- Prefer one short device check. Stop only emulators/simulators and helper processes you
  started, including after failures; preserve sessions the user is inspecting.
- Report checks as passed, failed, or not run, with reasons. Never turn build-only evidence
  into a claim of device acceptance or mark an inactive platform complete.

## Finish or hand off

Update only the docs affected by the change: product behavior, API, toolchain, or port evidence.
When an app exists, README must explain how to install and run it with real commands.
Maintain scripts and `organizermd.json` together when commands or targets change. Follow
[docs/ORGANIZERMD.md](docs/ORGANIZERMD.md): exclude new build/cache trees, preserve app-managed
settings, and use explicit/local preferences or a device chooser instead of hardcoded machine IDs.
Keep a short [handoff](docs/handoffs/README.md) for unfinished work or an interruption, and
delete it when resolved. Retain lasting port evidence separately in `docs/evidence/`.
Summarize the result, focused validation, and remaining gaps. This template requires no
automatic commit, push, deployment, all-platform rebuild, or release.

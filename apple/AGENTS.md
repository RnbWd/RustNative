# Apple instructions

Read root [AGENTS.md](../AGENTS.md) first. Work here only for selected Apple targets.

- Use idiomatic Swift/SwiftUI state and native navigation/accessibility. Keep shared product
  rules in Rust and Apple lifecycle/device behavior in native code.
- Keep observable UI changes on the appropriate UI actor. Isolate the core behind a small
  adapter; a Swift actor can serialize access but does not make heavy synchronous FFI safe
  for a cooperative executor. Select a suitable worker strategy when the work can block.
- Define core-object lifetime, Sendable/isolation expectations, and cancellation behavior.
  Do not invent unsafe concurrency annotations to silence warnings without a sound invariant.
- Generate Swift bindings and C headers/module maps with the pinned UniFFI toolchain.
  Never hand-edit them or mix device and simulator libraries with the same CPU architecture.
- Follow [TOOLCHAIN.md](../docs/TOOLCHAIN.md) for packaging and signing. Keep provisioning and
  credentials outside Git. Distinguish unsigned build output from installable device builds.
- Share SwiftUI code across selected Apple targets when useful, but verify iPhone, iPad, and
  macOS behavior separately where supported. Do not enable background modes without a feature.
- For parallel work, own `apple/` and assigned Apple evidence paths. Request shared contract
  changes from the integration owner; preserve others' edits. Solo work can span the full slice.
- Retain relevant port evidence and native differences. Ask for subjective device inspection
  when a brief human check is cheaper than a long automation flow.

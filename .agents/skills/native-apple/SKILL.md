---
name: native-apple
description: "Implement and verify selected iOS, iPadOS, or macOS targets in RustNative. Use for SwiftUI, AppKit, lifecycle, device behavior, packaging, debugging, or optional Rust integration."
---

# Apple native work

Read [Apple instructions](../../../apple/AGENTS.md), [project selection](../../../docs/PROJECT.md),
and the feature behavior. At first activation use the [toolchain checklist](../../../docs/TOOLCHAIN.md).
Prefer SwiftUI state and scenes. Keep AppKit interop focused on the macOS behavior that needs it.

## Required checks for affected behavior

- Discover the actual scheme and destination with Xcode or `xcodebuild`. Build, confirm the app
  launched, and run the [feature scenario](../../../docs/PARITY.md#verify-one-scenario) for each
  affected target. Use physical hardware for hardware-dependent behavior. Record device gaps.
- For UI changes, check VoiceOver labels and focus, supported text sizes, and relevant input
  such as touch on iPhone, keyboard on iPad, or keyboard and window focus on Mac. Exercise
  background/resume, scene recreation, or window restoration when the change affects them.
- For persistence changes, verify data after relaunch and migrations against synthetic older data
  when applicable. For permission changes, check grant, denial, and recovery, along with the
  relevant usage descriptions or entitlements.
- For release or packaging changes, inspect the actual bundle, architecture, signing, and
  entitlements. Verify a release launch where feasible and check notarization when the chosen
  distribution path requires it. If using UniFFI, verify matching device/simulator libraries,
  generated bindings, a real release call, and a typed error. See [Apple packaging](../../../docs/TOOLCHAIN.md#apple-details).

For failures, record the scheme, destination, reproduction steps, and first relevant error.
Use Xcode or the system log for scoped diagnostics, and LLDB when a breakpoint or stack
trace would help. Keep signing material local and use isolated test data.

Use broader destination matrices, Instruments, and lengthy visual checks when warranted.
See OpenAI's [iOS debugging](https://github.com/openai/plugins/tree/main/plugins/build-ios-apps/skills/ios-debugger-agent)
and [macOS build and debug](https://github.com/openai/plugins/tree/main/plugins/build-macos-apps/skills/build-run-debug)
workflows for reference.

---
name: native-apple
description: "Implement or integrate the Apple side of a RustNative app using Swift, SwiftUI, and UniFFI. Use for selected iOS, iPadOS, or macOS targets, native device behavior, and Rust framework integration."
---

# Apple native work

Read [Apple instructions](../../../apple/AGENTS.md), [project selection](../../../docs/PROJECT.md),
and the feature/core contract. Work only on selected Apple targets. At first activation use
[TOOLCHAIN.md](../../../docs/TOOLCHAIN.md); Android-only work requires no Apple builds.

Keep SwiftUI state, scene lifecycle, navigation, and Apple services native. Put portable
rules in Rust. Isolate generated bindings behind a small adapter and define object lifetime,
concurrency, and late-result handling. Keep expensive synchronous Rust calls off UI/cooperative
executors that must stay responsive; an actor is not a dedicated blocking worker.

Generate matching Swift bindings, headers/module maps, and target libraries with the pinned
UniFFI version. Device and simulator destinations need distinct builds even on arm64.
Prove a real call and typed error on the selected target before expanding the UI.

Check current feature APIs against the chosen deployment targets. Use
[SwiftUI model data](https://developer.apple.com/documentation/swiftui/model-data),
[UniFFI Xcode integration](https://mozilla.github.io/uniffi-rs/latest/swift/xcode.html), and
[XCFramework guidance](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle)
as relevant. Do not patch generated code or add unsupported concurrency assertions.

Run focused builds/checks for selected targets. Treat macOS, iPhone, and iPad evidence separately.
Use the leading platform's [port packet](../../../docs/PARITY.md), adapting to Apple conventions.
Ask for human visual/device acceptance when it is cheaper, and record signing or runtime gaps
explicitly. Keep credentials and provisioning out of the repository.

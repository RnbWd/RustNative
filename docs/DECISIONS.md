# Design decisions

Research checked against the primary sources below on **2026-10-16**. These are starter
decisions; no Rust/native integration has been built or benchmarked in this repository.

## Platform selection

Choose a primary platform and active targets per project. Start with the platform's own UI
tooling. Add Rust, WASM, a service, or a port when a feature benefits from it.

## Rust core + Mozilla UniFFI

**Selected for direct native Rust integration.** Rust is a good fit for portable domain rules and focused headless tests.
UniFFI generates Kotlin and Swift bindings from a Rust-defined interface. It does not package
or ship the library for us; native build integration remains our responsibility.
Source: [UniFFI guide](https://mozilla.github.io/uniffi-rs/latest/).

This fits apps with meaningful shared rules, parsing, algorithms, or data invariants. The costs
are an extra toolchain, an FFI boundary, and separately maintained native UIs. A small app
that mostly wraps platform APIs can stay in its platform language. When sharing pays off,
prove one small Rust integration.

Android's UniFFI Kotlin backend uses JNA, including its Android AAR. That is a dependency and
packaging cost, not "zero runtime overhead." Generated object lifetime also needs deliberate
management. Sources: [Gradle integration](https://mozilla.github.io/uniffi-rs/latest/kotlin/gradle.html),
[Kotlin lifetimes](https://mozilla.github.io/uniffi-rs/latest/kotlin/lifetimes.html).

Rust lists Android and Apple targets, but target support does not guarantee our app's behavior
on every OS, ABI, or device. Select and verify actual targets.
Source: [rustc platform support](https://doc.rust-lang.org/rustc/platform-support.html).

## Native shells with a small shared boundary

Compose and SwiftUI keep platform services and native tooling close to the UI. AppKit covers
macOS behavior when needed. If the app uses Rust, keep its boundary focused on portable rules.
Use each ecosystem's normal state/lifecycle tools without imposing a second UI framework.
References: [Android architecture recommendations](https://developer.android.com/topic/architecture/recommendations),
[SwiftUI model data](https://developer.apple.com/documentation/swiftui/model-data).

Start with synchronous calls off UI executors where needed. Async and callbacks are supported
by UniFFI, but need lifetime/cancellation decisions; they are not prohibited when useful.
Source: [UniFFI async support](https://mozilla.github.io/uniffi-rs/latest/futures.html).

## Starter defaults

Keep clear ownership across platform code and any shared core.
Keep everything else general:

- Select platforms independently. Do not require all-platform builds for an Android-only change.
- Treat native adapters as application logic; keep only portable product rules centralized.
- Add SQLite, sync, HTTP effects, media services, or a server only for a real feature.
- Keep current product status outside root agent instructions; use short temporary handoffs.
- Use reproducible IDE templates or project generators; no universal rule that only a human
  may create a project. Ask for manual work when it is cheaper and clearer.
- Do not inherit production endpoints, credentials, device defaults, auto-deploys, or unrelated
  language restrictions. Build and release policy belongs to the app that needs it.

## Size and integration discipline

**Measure instead of promising a multiplier.** Compare release artifacts with the same features,
assets, ABIs, and distribution format. Count application source separately from generated code,
and track dependency/build complexity alongside bytes. This starter has no size measurements.

Android native dependencies need compatible ELF alignment and package alignment for 16 KB
devices. This applies to the Rust `.so` and prebuilt libraries such as JNA; check the actual
release artifact and runtime, not only tool versions.
Source: [Android page-size guidance](https://developer.android.com/guide/practices/page-sizes).

Apple device and simulator libraries must be packaged for their distinct destinations.
Source: [Apple XCFramework guidance](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle).

## Skills and future choices

Ship three small repository-local skills for feature delivery and the two native boundaries.
Keep version-sensitive details in official references and the app's toolchain record. No
third-party skill pack is required or installed; add one only when it solves a demonstrated
problem and its instructions, dependencies, and license have been reviewed.

Do not add a framework-selection catalog to every new app. Reopen a decision only for a real
constraint: a platform-heavy single-target app can stay native-only; another shared-core system
may be appropriate if Rust integration becomes the main maintenance cost. A shared renderer
would be a different product tradeoff from this starter's direct native UI approach.

For Rust changes, prefer borrowing when the caller can retain ownership, return typed errors at
fallible boundaries, and scope lint checks to the affected crate and features. See
[Apollo's Rust Best Practices](https://github.com/apollographql/skills/tree/main/skills/rust-best-practices).

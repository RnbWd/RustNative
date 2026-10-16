---
name: native-android
description: "Implement or integrate the Android side of a RustNative app using Kotlin, Jetpack Compose, and UniFFI. Use for Android UI, lifecycle/device APIs, and release binding integration when Android is active."
---

# Android native work

Read [Android instructions](../../../android/AGENTS.md), [project selection](../../../docs/PROJECT.md),
and the feature/core contract. If Android is inactive, record port impact rather than creating
or building a project. At first activation use [TOOLCHAIN.md](../../../docs/TOOLCHAIN.md).

Keep Compose presentation state and Android services native. Put portable rules in Rust.
Use a small adapter around generated Kotlin bindings, explicit core lifetime, and lifecycle-aware
observable state. Dispatch blocking Rust calls away from Main; cancellation of a caller does
not guarantee a synchronous core mutation stops.

Use the pinned UniFFI generator and compatible JNA Android AAR. Verify real release loading
after R8, the selected ABI/API, and 16 KB compatibility of all native libraries and packaging.
Do not solve a load or shrinker failure by editing generated bindings or disabling checksums.

Check current platform guidance for the feature against the selected minimum/target SDKs.
Start with [Android architecture recommendations](https://developer.android.com/topic/architecture/recommendations),
[UniFFI Gradle integration](https://mozilla.github.io/uniffi-rs/latest/kotlin/gradle.html), and
[Android page sizes](https://developer.android.com/guide/practices/page-sizes) as relevant.

Run focused checks for the actual change. Use synthetic device data and brief runtime checks.
For lengthy or subjective GUI inspection, use a human or an authorized low-cost inspection
agent. Record actual screenshots/behavior through [PARITY.md](../../../docs/PARITY.md),
clean up only sessions you started, and report any unverified behavior.

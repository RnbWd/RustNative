---
name: native-android
description: "Implement and verify an active Android target in RustNative with Kotlin and Jetpack Compose. Use for Android UI, device behavior, packaging, debugging, or optional Rust integration."
---

# Android native work

Read [Android instructions](../../../android/AGENTS.md), [project selection](../../../docs/PROJECT.md),
and the feature behavior. At first activation use the [toolchain checklist](../../../docs/TOOLCHAIN.md).
Use Compose for UI, with lifecycle-aware state and Android APIs for platform effects.

## Required checks for affected behavior

- Build the affected Gradle variant, confirm the API level and destination, and run the
  [feature scenario](../../../docs/PARITY.md#verify-one-scenario). Use Compose semantics for
  control discovery and test tags for controls without a useful unique semantic selector.
- For UI changes, check TalkBack labels and focus, text scaling, touch targets, and relevant
  system bar or keyboard insets. Exercise rotation, background/resume, or process recreation
  when the change affects lifecycle or state restoration.
- If persistence changes, verify data after relaunch and exercise migration with synthetic
  older data when a prior schema exists. For permission changes, check least privilege,
  grant, denial, and revocation. Verify hardware-dependent behavior on a selected Android 16
  device. Record an explicit gap if hardware is unavailable.
- For release or packaging changes, inspect the actual APK or AAB and smoke-test the
  installable release variant with the configured shrinking. Check ABI and 16 KB alignment
  if native libraries are packaged. If using UniFFI, verify the matching JNA AAR, generated
  bindings, real release load, and typed error. See [Android packaging](../../../docs/TOOLCHAIN.md#android-details).

Use focused `adb logcat` output or Android Studio to diagnose failures. Record the variant,
device/OS, reproduction steps, and first relevant error. Keep test data isolated and preserve
existing device sessions.

Run broader device matrices, screenshot suites, R8 analysis, or profiling when the change
calls for them. See Google's [Compose testing setup](https://github.com/android/skills/blob/main/testing/testing-setup/SKILL.md),
[permission guidance](https://github.com/android/skills/blob/main/security/android-permissions-security/SKILL.md),
and [edge-to-edge checks](https://github.com/android/skills/blob/main/system/edge-to-edge/SKILL.md).

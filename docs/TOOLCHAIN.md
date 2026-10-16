# Toolchain and activation

**Current status:** template tooling uses Bash/Python 3.9+; it installs no dependencies. No tool
versions or commands have been validated for an app. Research supports the architecture, not a particular
version matrix. Select a compatible stable set at activation and record the successful build.

## Record real selections

Replace `not selected` with exact versions, official source links, verification date, and
the checks actually run. Config files and committed lockfiles become authoritative.

| Component | Version / selection | Relevant targets |
| --- | --- | --- |
| Rust toolchain and required targets | Not selected | Shared core |
| UniFFI library + workspace bindgen | Not selected; same exact resolved version | Shared boundary |
| Android Studio / JDK | Not selected | Android |
| Gradle wrapper / Android Gradle Plugin / Kotlin / Compose | Not selected as a compatible set | Android |
| Android SDK / minimum API / NDK / cargo-ndk / JNA AAR | Not selected | Android |
| Xcode / Swift / deployment targets / Swift package tools | Not selected | Selected Apple targets |

Do not hardcode versions from this research date into future projects. Verify current upstream
compatibility and store requirements when activating or upgrading. Review relevant licenses.

## Activate one platform

1. Select identifiers, minimum OS, and architectures in [PROJECT.md](PROJECT.md). Start with
   the user's actual device/simulator needs; arm64 is a useful first target, not a universal limit.
2. Use the native IDE's template or a maintained, reproducible project generator. Existing
   project files can be edited normally. Avoid hand-invented project formats and lengthy GUI automation;
   ask for a short human IDE step when that is substantially easier.
3. Create the smallest Rust crate and pinned UniFFI generator. For Android, build a `cdylib`;
   for Apple, package appropriate static libraries and generated headers/module map for consumption
   through a Swift package or XCFramework. Add crate types only for the consumers actually needed.
4. Establish a deterministic chain: Rust source → target library → matching binding generation →
   native compile/package. A compatible host library may supply bindgen metadata; it must never be
   packaged as the device binary. Put generated outputs under ignored build directories, and make
   native build tasks depend on generation or provide one documented wrapper that enforces the order.
5. Prove a real call and typed error in a release app on a selected device/emulator. Record
   artifact, configuration, OS/ABI, outcome, and anything not verified. Use an isolated app identity
   or test data when another app installation exists.
6. Document exact setup, build, run, and focused check commands in README and the platform README.
   Wire [the script entry points](../scripts/README.md) and update `organizermd.json` in the same
   change, including custom build-output exclusions. Verify from a clean checkout without stale artifacts.

### Android details

Use [cargo-ndk](https://github.com/bbqsrc/cargo-ndk) with the selected NDK, API level, and ABIs.
The Rust library's minimum API must be compatible with the app's `minSdk`. Include the
[JNA Android AAR required by UniFFI Kotlin bindings](https://mozilla.github.io/uniffi-rs/latest/kotlin/gradle.html).
Preserve required JNA/generated bindings during R8 shrinking; verify a release load, not just compilation.

Verify **every packaged native library**, including JNA, for the selected ABI and
[16 KB page-size compatibility](https://developer.android.com/guide/practices/page-sizes).
Check ELF alignment and APK/AAB packaging; a modern NDK alone does not validate prebuilt dependencies.
Exercise a 16 KB runtime when distributing to relevant devices. Record untested compatibility explicitly.

### Apple details

Apple builds require a macOS host and the appropriate Xcode SDKs. Select device and simulator
slices separately; the same CPU architecture does not make those libraries interchangeable.
Use [UniFFI's Xcode integration guidance](https://mozilla.github.io/uniffi-rs/latest/swift/xcode.html)
and Apple's [XCFramework guidance](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle).
Keep signing identities and provisioning local. An unsigned build is not install-ready device evidence.

## Reproducibility and verification

Commit app lockfiles, native project configuration, and the Gradle wrapper when created.
Pin Rust and tooling deliberately. Keep generated bindings, native binaries, and signing material
out of Git. A clean checkout must be able to rebuild them for the selected targets.

Once a Cargo workspace exists, its normal focused checks include `cargo test`,
`cargo fmt --check`, and `cargo clippy --workspace --all-targets -- -D warnings`.
Choose package/test scope appropriately. Native commands depend on the actual project and scheme;
there are no runnable Cargo commands until a crate exists.
The [script stubs](../scripts/README.md) document future native tasks and exit 2 until implemented;
`./scripts/test.sh template` checks shell syntax, OrganizerMD references, and cleanup boundaries.

Add CI when executable work exists: core checks plus builds for active targets. Apple CI can
wait while Apple is inactive. Store upload, deployment, and device acceptance are separate actions.

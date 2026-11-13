# Toolchain and activation

**Current status:** template tooling uses Bash/Python 3.9+ and installs no dependencies. There
are no app manifests or lockfiles to update. Choose compatible stable versions at activation and
record the successful build. Keep local inventory separate from actual app requirements.

## Record real selections

Replace `not selected` with exact versions, official source links, verification date, and
the checks actually run. Config files and committed lockfiles become authoritative.

| Component | Version / selection | Relevant targets |
| --- | --- | --- |
| Browser tooling and support baseline | Not selected | Web |
| Rust toolchain and required targets | Not selected | Shared core, if used |
| UniFFI library + workspace bindgen | Not selected; same exact resolved version | Shared boundary |
| Android Studio / JDK | Not selected | Android |
| Gradle wrapper / Android Gradle Plugin / Kotlin / Compose | Not selected as a compatible set | Android |
| Android SDK / minimum API / NDK / cargo-ndk / JNA AAR | API 36 baseline; remaining tooling selected at activation | Android |
| Xcode / Swift / deployment targets / Swift package tools | Not selected | Selected Apple targets |

Do not hardcode versions from this research date into future projects. Verify current upstream
compatibility and store requirements when activating or upgrading. Review relevant licenses.

## Activate web

Run `./scripts/bootstrap.sh web` for the web checklist. Choose browser coverage and tooling for the
first feature. Start with ordinary browser code if it suffices. If using Rust/WASM, verify the
portable crate for the browser target and exercise the real boundary in a browser. If a feature
needs a server, document why and verify that deployment separately. Record actual local build
and run commands in README and wire them into OrganizerMD.

## Activate a native platform

1. Select identifiers, minimum OS, and architectures in [PROJECT.md](PROJECT.md). Start with
   the user's actual device/simulator needs; arm64 is a useful first target, not a universal limit.
2. Use the native IDE's template or a maintained, reproducible project generator. Existing
   project files can be edited normally. Avoid hand-invented project formats and lengthy GUI automation;
   ask for a short human IDE step when that is substantially easier.
3. Build and run one useful feature on the selected target. Record the destination, artifact,
   configuration, outcome, and any gaps using [PARITY.md](PARITY.md).
4. Document the actual setup, build, run, and check commands in README and the platform README.
   Wire the [scripts](../scripts/README.md) and OrganizerMD together. Verify from a clean checkout.

### Optional native Rust integration

1. Add a small crate when portable rules justify it. For a native consumer using UniFFI, select
   matching library and generator versions. Build an Android `cdylib` or package Apple libraries,
   generated headers, and module maps for the selected destinations.
2. Build in a reproducible order: Rust library → matching bindings → native compile and package.
   Keep generated output ignored. A host library can provide binding metadata. Package only
   libraries built for the app's destination.
3. Exercise a real call and a typed error in the release configuration on the selected
   destination. Record the result and any device or signing gap.

### Android details

Use [Android 16 (API 36)](https://developer.android.com/about/versions/16/setup-sdk) for this
starter's Android baseline. Use `minSdk = 36`, `targetSdk = 36`, and `compileSdk = 36` when
activating it. The minimum sets the installation floor; it does not block future Android versions.
Test Android 16 on the selected device/ABI. Revisit the SDK level if a feature requires a minor
SDK release or distribution requirements change.

Google's [compatibility table](https://developer.android.com/build/releases/about-agp#api-level-support)
lists Android Studio Meerkat 2024.3.1 Patch 1 and AGP 8.9.1 as the API 36 minimums. Choose a
supported stable Studio/JDK/Gradle/AGP/Kotlin/Compose set together rather than pinning those
minimums. Install `platforms;android-36` via SDK Manager when Android is activated.

Check that the installed SDK includes the API 36 platform. Build Tools 36.0.0 and newer
platforms are separate packages.

When using Rust, use [cargo-ndk](https://github.com/bbqsrc/cargo-ndk) with the selected NDK,
API level, and ABIs.
The Rust library's minimum API must be compatible with the app's `minSdk`. For UniFFI, include the
[JNA Android AAR required by UniFFI Kotlin bindings](https://mozilla.github.io/uniffi-rs/latest/kotlin/gradle.html).
Preserve required JNA/generated bindings during R8 shrinking; verify a release load, not just compilation.

If the app packages native libraries, verify each library for the selected ABI and
[16 KB page-size compatibility](https://developer.android.com/guide/practices/page-sizes).
Check ELF alignment and APK/AAB packaging; a modern NDK alone does not validate prebuilt dependencies.
Exercise a 16 KB runtime when distributing to relevant devices. Record untested compatibility explicitly.

### Apple details

Apple builds require a macOS host and the appropriate Xcode SDKs. For Rust libraries, select device and
simulator slices separately. Use [UniFFI's Xcode integration guidance](https://mozilla.github.io/uniffi-rs/latest/swift/xcode.html)
and Apple's [XCFramework guidance](https://developer.apple.com/documentation/xcode/creating-a-multi-platform-binary-framework-bundle).
Keep signing identities and provisioning local. An unsigned build is not install-ready device evidence.

## Reproducibility and verification

Commit app lockfiles, native project configuration, and the Gradle wrapper when created.
Record selected versions for the tooling the project uses. Keep generated bindings, native binaries, and signing material
out of Git. A clean checkout must be able to rebuild them for the selected targets.

Once a Cargo workspace exists, its normal focused checks include `cargo test`,
`cargo fmt --check`, and `cargo clippy` for the affected crate and features.
Choose package/test scope appropriately. Native commands depend on the actual project and scheme;
there are no runnable Cargo commands until a crate exists.
The [script stubs](../scripts/README.md) document future native tasks and exit 2 until implemented;
`./scripts/test.sh template` checks shell syntax, OrganizerMD references, and cleanup boundaries.

Add CI when executable work exists: core checks plus builds for active targets. Apple CI can
wait while Apple is inactive. Store upload, deployment, and device acceptance are separate actions.

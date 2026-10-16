# Android instructions

Read root [AGENTS.md](../AGENTS.md) first. Work here only when Android is active.

- Use idiomatic Kotlin/Compose, observable UI state, and lifecycle-aware work. Shared domain
  rules stay in Rust; UI state and Android API integration belong here.
- Call the generated API through a small native adapter. Keep blocking work off the main thread;
  define lifecycle ownership and cancellation rather than launching unmanaged scopes.
- Permissions, notifications, background work, media, and system UI use Android APIs. Add each
  capability only for an actual product requirement and its selected minimum OS.
- Select the generated package and native library names at activation. Never patch generated
  Kotlin. Keep build generation reproducible and UniFFI/JNA compatibility checks enabled.
- Verify release loading with shrinking enabled, packaged ABIs, and native-library alignment.
  Follow the [toolchain checks](../docs/TOOLCHAIN.md); compilation alone is not runtime evidence.
- Use synthetic data and explicit device selection. Preserve real app data, installed signatures,
  and user-owned emulator sessions. Clean up only the emulator/processes you started.
- For parallel work, own `android/` and assigned Android evidence paths. Ask the integration owner
  for shared-core/contract changes; preserve other workers' edits. Solo work can span the full slice.
- Document behavior and deferred port impact with [PARITY.md](../docs/PARITY.md). Human acceptance
  remains pending until a person actually reviews it.

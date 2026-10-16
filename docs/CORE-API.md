# Shared core contract

**Status:** no exported API exists. This file records intended semantics once a feature needs
Rust. Do not create a generic app engine, placeholder database, or sample product model now.

Rust exports are the source of signatures and generated bindings. This document is the
human-readable contract between the integration owner and native implementers. Keep it small.

## When adding the first API

Record the following next to each public operation or closely related group:

- Purpose, input/output records, IDs, units, and invariants.
- Typed domain errors and which layer turns them into user-facing messages.
- Whether it is pure, reads/writes storage, or returns work for native code to execute.
- Core instance lifetime, caller/executor requirements, and supported concurrent calls.
- Cancellation and late-result behavior for operations that can outlive a screen.
- Data/contract revision and the consequences for each active or deferred consumer.
- Implementation status and the focused rule or boundary checks that protect it.

## Changing the contract

The integration owner updates semantics first, then Rust, then regenerates bindings and
compiles active native consumers. Add a migration only for actual persisted data or released
protocols. Generated FFI bindings and a binary ship together; they are not a stable ABI for
independently mixing releases. Keep UniFFI compatibility checks enabled.

When platform work is parallel, agree on a named revision in the feature note before workers
implement it. A signature change returns to the integration owner; native workers should not
invent a second rule, edit generated code, or treat a mock as a completed integration.

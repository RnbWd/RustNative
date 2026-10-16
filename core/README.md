# Shared Rust core — not scaffolded

This directory reserves the home of portable product rules. There is no Cargo crate or API yet.
Create one when implementing the first app feature, following [the architecture](../ARCHITECTURE.md)
and [activation checklist](../docs/TOOLCHAIN.md).

Start with one crate and a small UniFFI facade. Pure rules should work without a device, UI,
network connection, or implicit wall clock. Accept inputs and return structured outcomes/errors.
Keep persistence optional until a feature requires it; if the core owns it, use app-private paths
supplied by native code and own transactions/migrations in one place.

The integration owner maintains [the API contract](../docs/CORE-API.md), exported Rust types,
and binding generation. Pin the generator and library together. Generated code and target
libraries belong in ignored build output, never as handwritten sources here.

Focused rule and boundary tests belong alongside the real implementation. Do not create an
example business domain, server, or speculative test suite to fill this directory.

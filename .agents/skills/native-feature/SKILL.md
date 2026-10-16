---
name: native-feature
description: "Deliver a feature in a RustNative project using its selected platform mode, shared Rust contract, and native shells. Use for feature implementation or a later port; parallel work requires the user's selected coordination workflow."
---

# Native feature delivery

Read [root instructions](../../../AGENTS.md), [project selection](../../../docs/PROJECT.md),
and the relevant part of [product behavior](../../../docs/PRODUCT.md). In the docs/tooling
starter, scaffold an app only when the user asks to implement one.

Define one useful outcome and its active targets. A small change can stay in product notes;
use the [feature template](../../../docs/templates/FEATURE.md) when a shared contract or
parallel implementation needs a durable reference.

If the core API changes, record its semantics in [CORE-API.md](../../../docs/CORE-API.md),
implement the Rust rule with a focused check, and regenerate bindings before native consumers
adapt. For first-time activation, prove the bridge using [TOOLCHAIN.md](../../../docs/TOOLCHAIN.md).
Do not add storage, networking, a runtime, or a server without a feature need.
When implementing developer commands, wire the [script entry points](../../../scripts/README.md)
and maintain [OrganizerMD](../../../docs/ORGANIZERMD.md) in the same change.

Use the appropriate local platform skill for native work. Keep single-platform work solo by
default. If the user selects two chats or coordinator/subagents, follow
[WORKFLOW.md](../../../docs/WORKFLOW.md): explicit path ownership, one shared integration
owner, an agreed API revision, and no concurrent edits to shared generated output.

Verify only affected active targets and important behavior. Report build/runtime/human review
separately. Keep inactive targets deferred, with a small [port packet](../../../docs/PARITY.md)
when the feature is useful to reproduce. Missing evidence is an explicit gap, never invented.

For interrupted work, leave a short [handoff](../../../docs/handoffs/README.md). Delete it when
resolved and keep lasting decisions in the product, API, or evidence notes.

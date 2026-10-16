# Working alone or across platforms

Read [PROJECT.md](PROJECT.md) for active targets and coordination. Work in small feature slices.
Agree on observable behavior in [PRODUCT.md](PRODUCT.md), and update [CORE-API.md](CORE-API.md)
only when the public Rust boundary changes. Do not require a design document for every edit.

## Solo (default)

One agent owns the Rust/native slice end to end. Implement and verify the selected targets.
For `android-only` or `apple-only`, keep the other platform dormant. When there is useful behavior
to port, retain a small [port packet](PARITY.md). Missing deferred work does not block delivery.

If dual implementation is small, one agent can do both sequentially. Parallelism is a choice,
not a requirement or a reason to generate speculative tasks.

## Two platform chats

Use this when the user explicitly wants long-lived, separate Apple and Android chats.
Assign one integration owner: either one of those chats or a coordinator chosen by the user.
Creating or messaging chats requires the user's instruction; do not start them automatically.

Before simultaneous edits, agree on:

| Owner | Responsibility |
| --- | --- |
| Integration owner | Rust, shared API, shared docs, dependency versions, build-generation plumbing, integration |
| Android worker | `android/`, Android checks, Android feature status/evidence |
| Apple worker | `apple/`, selected Apple target checks, Apple feature status/evidence |

Keep shared files with the integration owner. Give each worker a separate feature/evidence file
when both need to record progress. Workers report requested shared changes instead of editing
the other's area. Preserve concurrent work; never revert unrelated edits to make a build pass.

If chats share a checkout, avoid simultaneous generation into shared output paths. The integration
owner produces shared artifacts first. If they use separate checkouts/worktrees, record the common
base and API revision, consume the integration owner's contract commit, and regenerate locally.
Separate checkouts are useful for isolation, not mandatory for every small project.

## Coordinator and two subagents

Use this when the user selects coordinated parallel implementation and the tool supports it.
The parent owns integration. Spawn at most one Android and one Apple worker for a slice,
only if both have concrete independent work. In a single-platform mode, normally stay solo.

Each assignment includes the feature and API revision, owned paths, active targets, acceptance
criteria, and reporting location. Tell workers they are not alone in the codebase and must
preserve and accommodate others' edits. Keep `core/` and shared documents with the parent.
Choose agent models according to the user's cost preferences; a subscription is not assumed.

## Contract changes during parallel work

1. The owner names the agreed contract revision in the feature note and implements the core.
2. Workers consume that contract. A UI mock can unblock layout, but is labeled temporary.
3. A worker needing a changed API reports the required semantics to the owner.
4. The owner updates Rust/contract, regenerates, and communicates the revision before consumers adapt.
5. Integrate one revision, remove temporary mocks, and compile each active consumer against it.

Coordination does not authorize sending messages outside the chosen workflow or publishing changes.
If chat messaging is unavailable, leave a short handoff the user can pass between chats.

## Completion and interruption

Report the behavior delivered and focused checks, distinguishing build, runtime, and human
acceptance. For dual mode, record each selected target; a blocked Apple check cannot become
"both verified" because Android passed. For inactive targets, record the port impact and defer checks.

Before an interruption, write a short note using [templates/HANDOFF.md](templates/HANDOFF.md).
Include the current contract, files, checks, blocker, and next concrete step. Delete the note once
resolved. Keep lasting decisions and port evidence in their proper docs, not in permanent task diaries.

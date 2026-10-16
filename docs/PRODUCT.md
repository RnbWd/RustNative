# Product behavior

**Starter status:** no app features, screens, visual identity, or sample business domain are
defined. A new project chooses its own purpose. Do not inherit another app's design or behavior.

When adopting this starter, replace this note with:

- The user, their problem, and the first useful action the app should support.
- A small list of current features, intended behavior, and explicit non-goals.
- Screens/navigation and meaningful empty, loading, success, and error states.
- Accessibility and offline expectations relevant to those features.
- Any deliberate platform differences and links to implementation evidence.

Use [templates/FEATURE.md](templates/FEATURE.md) for a feature that needs a shared contract,
parallel implementation, or a later port. Tiny local changes can use a short paragraph here.
Create feature notes under `docs/features/` only when needed.

## Status vocabulary

Use concrete states: `planned`, `implemented`, `build verified`, `runtime verified`,
`human accepted`, `deferred`, or `blocked`. Record each active target separately.
An inactive target starts `deferred`. No feature currently has implementation or verification.

Keep screenshots and reproduction context according to [PARITY.md](PARITY.md). Link to the
current evidence rather than growing a chronological UI diary in this document.

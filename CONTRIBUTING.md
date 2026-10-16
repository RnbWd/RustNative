# Contributing

Keep RustNative useful for small, unrelated apps. Favor changes that clarify a real workflow
or remove repeated integration mistakes. App features belong in projects created from the template.

Read [AGENTS.md](AGENTS.md). Keep a contribution focused and explain its concrete benefit.
Run `./scripts/test.sh template` for script/config changes. For documentation changes, check local links,
file paths, and consistency with the active project
status. Validate a changed skill's frontmatter and referenced files with your agent's available
skill validator, or inspect them directly. There is no app build or native test suite yet.

For a proposed dependency, include the need, official source, license, and maintenance/build
cost. Do not add a toolchain, generated native project, or CI matrix just to demonstrate a concept.
When runnable code is introduced, add its actual setup and focused verification commands.

Changes to the starter's operating rules should work in `android-only`, `apple-only`, and `dual`
modes and without any particular agent subscription or plugin. Use sample data in screenshots;
never submit credentials, signing files, or screenshots of private user content.

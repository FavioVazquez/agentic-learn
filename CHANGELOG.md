# Changelog

All notable changes to `agentic-learning` are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/): `MAJOR.MINOR` — bump MINOR for new actions or behavioral changes, MAJOR for breaking changes.

---

## [1.1] — 2026-03-03

### Added
- `explain` action: reads the project (code, docs, examples, tests) and produces a structured comprehension log. Appends to `docs/project-knowledge.md` in the user's project. Accepts an optional focus area (`@agentic-learning explain <area>`).
- `CONTRIBUTING.md`: full contributor guide covering file responsibilities, how to add actions, writing style for `SKILL.md`, and the productive struggle constraint.
- `CHANGELOG.md`: this file.
- `CODE_OF_CONDUCT.md`: Contributor Covenant v2.1.
- `TESTING.md`: behavior verification checklist for all 9 actions.
- `EXAMPLES.md`: added `explain` action walkthroughs (two scenarios) and updated chaining section.

### Fixed
- `install.sh`: `explain` action was missing from usage output.
- `SKILL.md` frontmatter `description`: updated to include `explain` in the list of invocable actions.

---

## [1.0] — 2026-03-02

### Added
- Initial release with 8 actions: `learn`, `quiz`, `reflect`, `space`, `brainstorm`, `explain-first`, `struggle`, `either-or`.
- `SKILL.md`: full agent instructions for all 8 actions, compatible with Windsurf Cascade and the AgentSkills spec.
- `references/learning-science.md`: neuroscience research behind the four learning techniques (retrieval, spacing, generation, reflection) with primary sources.
- `references/struggle-ladder.md`: 4-level hint escalation system for the `struggle` action, including extended hints and "harder" mode.
- `references/either-or-format.md`: decision journal template with 3 full worked examples (technology choice, process choice, agent override).
- `README.md`: install instructions (npx, curl, git clone), actions table, usage examples, files written to project.
- `EXAMPLES.md`: full realistic dialogue walkthroughs for all 8 actions plus a session chaining example.
- `install.sh`: bash installer with `--global`, `--uninstall` flags; falls back from git to curl.
- `LICENSE`: MIT.
- `.gitignore`: excludes `npx skills` install artifacts (`.agents/`, `.windsurf/`, `skills-lock.json`).

# Changelog

All notable changes to `agentic-learning` are documented here.

Format follows [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).
Versioning follows [Semantic Versioning](https://semver.org/): `MAJOR.MINOR` — bump MINOR for new actions or behavioral changes, MAJOR for breaking changes.

---

## [1.3] — 2026-03-03

### Added
- `references/learning-science.md`: Technique 8 (Oracy) and Technique 9 (Formative Feedback) — fully grounded in Mannion & McAllister (oracy as metacognitive diagnostic), Hattie & Timperley four feedback levels, and Dweck's growth mindset caveat. Both techniques include "how the agent applies it" sections mapped to specific actions.
- `references/learning-science.md`: Dweck (2006) added to primary sources with annotation. Hattie & Timperley citation expanded with four feedback levels annotation.

### Changed
- `SKILL.md — learn`: step 4 rewritten with explicit formative feedback instructions (wrong/right/partial branches, each anchored to learning goal). Replaces generic "give genuine feedback."
- `SKILL.md — quiz`: step 4 rewritten with formative feedback at the concept level; feedback must connect back to why the concept matters in context.
- `SKILL.md — space`: action now reads existing `docs/revisit.md` before scheduling. Cross-references past entries: skips duplicates, reschedules forward if a concept was shaky again. Closes the personalised learning path gap from Lakhani's CENTURY model.
- `SKILL.md — explain-first`: added oracy framing paragraph ("What this is") explaining the Protégé Effect and why articulating understanding is a metacognitive diagnostic. Added step 6: precision follow-up when explanation is vague.
- `SKILL.md — global principles`: two new principles added — "Praise effort and strategy, never intelligence" (Dweck caveat) and "Feedback must be formative, not binary" (Hattie process-level feedback).
- `README.md`: science table updated to 9 techniques (added Oracy, Formative feedback rows). Sources line updated.
- `TESTING.md — learn`: formative feedback checks added (wrong/right/partial branches, no bare "great job!" check).
- `TESTING.md — quiz`: formative feedback checks added per question.
- `TESTING.md — space`: second-run trigger added with deduplication and reschedule checks.
- `TESTING.md — explain-first`: oracy precision follow-up check added.
- `TESTING.md — regression checklist`: four new items for formative feedback, oracy scaffold, and space deduplication.

---

## [1.2] — 2026-03-03

### Added
- `interleave` action: mixed retrieval across multiple past topics in a single session. Deliberately alternates between domains to prevent pattern-matching shortcuts. Based on interleaving research (Rohrer & Taylor, 2007).
- `cognitive-load` action: decomposes an overwhelming concept or task into working-memory-sized chunks. Classifies the type of overload (too many terms / too many steps / pieces don't connect) and produces a sequenced learning plan. Based on cognitive load theory (Sweller, 1988).
- `references/learning-science.md`: three new techniques added — Technique 5 (Interleaving), Technique 6 (Cognitive Load Management), Technique 7 (Metacognition). Neurological basis section expanded with sleep and memory consolidation (Walker, *Why We Sleep*).
- New primary sources: Sweller (1988), Rohrer & Taylor (2007), Walker (2018), Mannion & McAllister (2020), and Lakhani, P. (2021) *Inadequate* — John Catt Educational.
- `README.md`: actions table updated (11 actions total), science table expanded to 7 techniques, Lakhani book referenced.

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

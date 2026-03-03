# agentic-learning

> A learning partner skill for AI coding agents, grounded in neuroscience and philosophy.

`agentic-learning` turns your AI assistant into a learning partner that resists the illusion of competence. Instead of just handing you answers, it guides you through four science-backed techniques — **retrieval, spacing, generation, and reflection** — while you build real software.

It also includes tools for collaborative design (**brainstorm**), decision journaling (**either-or**), and productive struggle (**struggle**) — because building with AI agents is itself a learning process.

---

## Actions

| Action | What it does |
|--------|-------------|
| `learn <topic>` | Teaching through retrieval and generation: you explain first, agent fills the gaps |
| `quiz` | Retrieval practice on your current file or topic |
| `reflect` | Structured 3-part reflection: what did I learn / what was my goal / what are the gaps |
| `space` | Schedules concepts to revisit; writes `docs/revisit.md` |
| `brainstorm <idea>` | Collaborative design dialogue; writes a design doc to `docs/brainstorm/` |
| `explain-first` | You narrate the current code in your own words before the agent says anything |
| `struggle <task>` | 3-hint ladder mode; agent reveals only when you ask or exhaust the hints |
| `either-or <decision>` | Decision journal inspired by Kierkegaard; appends to `docs/decisions/` |
| `explain` | Reads the whole project and writes a comprehension log to `docs/project-knowledge.md` |

---

## Installation

### Option 1 — `npx skills` (easiest, no git required)

Uses the [skills CLI](https://skills.sh) from the AgentSkills ecosystem:

```bash
npx skills add FavioVazquez/agentic-learn
```

This installs the skill into the current workspace. The skill will appear on [skills.sh/FavioVazquez/agentic-learn](https://skills.sh/FavioVazquez/agentic-learn) once it gets its first installs.

### Option 2 — `curl` one-liner

**Workspace skill** (current project only):
```bash
curl -fsSL https://raw.githubusercontent.com/FavioVazquez/agentic-learn/main/install.sh | bash
```

**Global skill** (all projects):
```bash
curl -fsSL https://raw.githubusercontent.com/FavioVazquez/agentic-learn/main/install.sh | bash -s -- --global
```

**Uninstall:**
```bash
curl -fsSL https://raw.githubusercontent.com/FavioVazquez/agentic-learn/main/install.sh | bash -s -- --uninstall
```

### Option 3 — `git clone` (manual)

```bash
# Workspace
git clone --depth 1 https://github.com/FavioVazquez/agentic-learn .windsurf/skills/agentic-learning

# Global
git clone --depth 1 https://github.com/FavioVazquez/agentic-learn ~/.codeium/windsurf/skills/agentic-learning
```

### Other AgentSkills-compatible agents

Place the `agentic-learning/` directory anywhere your agent scans for skills. The skill follows the [AgentSkills specification](https://agentskills.io/specification).

---

## Usage examples

> **Full walkthroughs with realistic conversations for every action:** [EXAMPLES.md](EXAMPLES.md)

```
@agentic-learning learn async/await in Python

@agentic-learning quiz

@agentic-learning struggle implement a binary search

@agentic-learning brainstorm auth system for a multi-tenant SaaS

@agentic-learning either-or use Redis vs in-memory cache

@agentic-learning reflect

@agentic-learning explain-first

@agentic-learning space

@agentic-learning explain
```

---

## Files written to your project

When you use this skill, it may create or append to:

```
docs/
├── brainstorm/
│   └── YYYY-MM-DD-<topic>.md         # brainstorm session design docs
├── decisions/
│   └── YYYY-MM-DD-decisions.md       # either-or decision journal
├── project-knowledge.md              # explain: growing comprehension log
└── revisit.md                        # spacing reminders
```

These files are yours — commit them, share them, or use them as the raw material for documentation and retrospectives.

---

## The science behind it

Learning requires what researchers call a **productive struggle** — the mental effort that builds real understanding. Four techniques are proven to work:

1. **Retrieval** — recalling from memory is more effective than re-reading
2. **Spacing** — returning to a concept over time beats cramming
3. **Generation** — producing an answer (even if wrong) creates a stronger memory trace
4. **Reflection** — structured feedback on goals and gaps improves outcomes

See [references/learning-science.md](references/learning-science.md) for sources and detail.

---

## The philosophy behind `either-or`

Kierkegaard's *Either/Or* explores how every significant choice defines who we are — not just the option chosen, but the act of choosing consciously. Applied to building software with AI agents: every architectural decision, every tradeoff, every "ship it vs. refactor" moment is worth recording. Not because there's always a right answer, but because the act of articulating the paths and the rationale is itself learning.

---

## Contributing

Contributions are welcome! Read [CONTRIBUTING.md](CONTRIBUTING.md) for how to add actions, improve existing ones, and what "correct behavior" means for this skill.

See [TESTING.md](TESTING.md) for the behavior verification checklist — run it before submitting a PR.

See [CHANGELOG.md](CHANGELOG.md) for the version history.

Please follow the [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

---

## License

MIT — see [LICENSE](LICENSE)

## Author

[Favio Vázquez](https://github.com/FavioVazquez) — built as part of [The Road to Reality](https://github.com/favio-vazquez/roadtoreality), Episode 2.

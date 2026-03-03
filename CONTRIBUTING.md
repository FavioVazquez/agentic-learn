# Contributing to agentic-learning

Thank you for wanting to improve this skill. Contributions of all kinds are welcome: new actions, improvements to existing ones, better examples, reference material, bug fixes, and documentation.

---

## What "correct behavior" means

Before contributing, understand the core constraint this skill enforces:

**The agent must never short-circuit the user's cognitive effort.**

Every action is designed around productive struggle — the mental effort that neuroscience shows is required for real learning. A contribution that makes the agent more helpful in a way that bypasses that effort is a regression, not an improvement.

Concretely:
- The agent must wait for the user's answer before providing its own
- The agent must ask one question at a time
- `struggle` must give hints in order — never jump to the answer unprompted
- `learn` must ask the user to explain/recall before teaching
- `brainstorm` must not write any code until the user explicitly approves the design

If you're unsure whether a change violates this principle, read `TESTING.md` and run through the checklist manually.

---

## How to contribute

### 1. Fork and clone

```bash
git clone https://github.com/FavioVazquez/agentic-learn
cd agentic-learn
```

### 2. Install the skill locally for testing

```bash
npx skills add FavioVazquez/agentic-learn
# or
curl -fsSL https://raw.githubusercontent.com/FavioVazquez/agentic-learn/main/install.sh | bash
```

### 3. Make your changes

See the section below for what each file is responsible for.

### 4. Test your changes

Run through the relevant checklist items in `TESTING.md` before submitting. For new actions, add a checklist section to `TESTING.md` and a full example dialogue to `EXAMPLES.md`.

### 5. Open a pull request

- Title: short description of what changed (`feat: add X action`, `fix: struggle hint ordering`, `docs: improve either-or examples`)
- Description: what you changed and why; which `TESTING.md` items you verified
- If you're adding a new action: include the `EXAMPLES.md` dialogue and `TESTING.md` checklist in the same PR

---

## File responsibilities

| File | What it is | Who reads it |
|------|-----------|-------------|
| `SKILL.md` | Agent instructions — defines all actions | The AI agent |
| `references/*.md` | Deep context the agent draws on during actions | The AI agent |
| `EXAMPLES.md` | Full realistic dialogues showing correct behavior | Humans (contributors, users) |
| `TESTING.md` | Behavior verification checklist | Humans (contributors) |
| `README.md` | Install instructions and quick reference | Users |
| `install.sh` | Bash installer | Users |
| `CONTRIBUTING.md` | This file | Contributors |
| `CHANGELOG.md` | Version history | Everyone |

---

## Adding a new action

1. Add the action definition to `SKILL.md` — follow the existing format:
   - `### \`action-name\` — Short description`
   - `**Trigger:**`
   - `**What to do:**` (numbered steps)
   - Hard constraints in bold
2. Add the action to the `description` field in `SKILL.md` frontmatter
3. Add a row to the actions table in `README.md`
4. Add the trigger to the usage examples in `README.md`
5. Add a full dialogue example to `EXAMPLES.md`
6. Add a behavior checklist section to `TESTING.md`
7. Bump the version in `SKILL.md` frontmatter (`metadata.version`)
8. Add an entry to `CHANGELOG.md`

---

## Improving existing actions

- Keep changes minimal and targeted
- Preserve the productive struggle constraints
- If you change agent behavior, update `EXAMPLES.md` and `TESTING.md` to reflect the new expected output
- Bump the version patch number (e.g. `"1.1"` → `"1.2"`)
- Add an entry to `CHANGELOG.md`

---

## Writing style for `SKILL.md`

The skill body is instructions to an AI agent, not documentation for humans. Write it accordingly:

- Use imperative voice: "Ask the user", "Wait for the answer", "Do NOT reveal"
- Be explicit about what NOT to do — agents need negative constraints as much as positive ones
- Use **bold** for hard constraints that must never be violated
- Reference supporting files with relative links: `[references/struggle-ladder.md](references/struggle-ladder.md)`

---

## Questions

Open an issue or start a discussion on GitHub. We're happy to talk through ideas before you invest time building them.

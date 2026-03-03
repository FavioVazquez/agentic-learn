# Testing — agentic-learning

A behavior verification checklist for contributors. Before submitting a PR that changes `SKILL.md` or any `references/` file, manually verify the relevant items below by running the action in a skills-compatible agent (e.g. Windsurf Cascade).

There is no automated test suite — agent behavior is non-deterministic and context-dependent. This checklist is the next best thing: a set of observable behaviors that define "correct" for each action.

---

## How to test

1. Install the skill in a test workspace:
   ```bash
   npx skills add FavioVazquez/agentic-learn
   ```
2. Open the workspace in your agent (e.g. Windsurf).
3. Run each trigger phrase below and verify the agent behaves as described.
4. Check the box if it passes. Note failures in your PR description.

---

## Global constraints (apply to ALL actions)

- [ ] Agent asks **one question at a time** — never two questions in the same message
- [ ] Agent **waits** after asking a question — does not answer its own question
- [ ] Agent acknowledges what the user got right before correcting what's wrong
- [ ] Agent does not append "Is there anything else you'd like to know?" at the end of actions

---

## `learn`

**Trigger:** `@agentic-learning learn async/await in Python`

- [ ] Agent asks what the user already knows **before** explaining anything
- [ ] Agent waits for the user's answer
- [ ] After the user answers, agent gives feedback (correct/incorrect), then provides the full explanation
- [ ] Agent ends with a generation exercise (partial code or incomplete sentence for the user to complete)
- [ ] Agent does **not** give the full explanation before the user has answered

---

## `quiz`

**Trigger:** `@agentic-learning quiz` (with a code file open)

- [ ] Agent generates 3-5 questions based on the current file/topic
- [ ] Agent presents questions **one at a time** — waits for each answer before showing the next
- [ ] Agent does **not** reveal the answer before the user attempts it
- [ ] After all questions, agent gives a 2-3 sentence summary of strengths and what to review

---

## `reflect`

**Trigger:** `@agentic-learning reflect`

- [ ] Agent asks exactly **three questions in sequence**, one at a time:
  1. What did you learn?
  2. What was your goal?
  3. What are the gaps?
- [ ] Agent waits for the user's answer before asking the next question
- [ ] After all three, agent produces a summary with: what was covered, gap identified, one concrete next step
- [ ] Next step is actionable (a specific topic, a `@agentic-learning learn` prompt, or a resource)

---

## `space`

**Trigger:** `@agentic-learning space`

- [ ] Agent identifies concepts from the current session (not generic/made-up ones)
- [ ] Agent categorizes them into tomorrow / 3 days / 1 week based on confidence level
- [ ] Agent writes (or appends) to `docs/revisit.md` in the current project
- [ ] Agent confirms the file was written and tells the user where it is

---

## `brainstorm`

**Trigger:** `@agentic-learning brainstorm auth system for a multi-tenant SaaS`

- [ ] Agent reads relevant files before asking questions
- [ ] Agent asks **one clarifying question at a time**
- [ ] Agent proposes **2-3 approaches** with trade-offs before settling on one
- [ ] Agent presents design sections and asks for approval after each
- [ ] Agent does **NOT** write any code before the user explicitly approves the design
- [ ] After approval, agent writes a design doc to `docs/brainstorm/YYYY-MM-DD-<topic>.md`
- [ ] Agent confirms the file was written

---

## `explain-first`

**Trigger:** `@agentic-learning explain-first`

- [ ] Agent identifies the most relevant code in context (current file or selection)
- [ ] Agent asks the user to explain it **in their own words** before saying anything about the code
- [ ] Agent waits for the full explanation — does not interrupt
- [ ] After the user explains, agent gives feedback: what they got right, what they missed, one key addition
- [ ] Agent does **not** re-explain the entire thing — only adds what was missing

---

## `struggle`

**Trigger:** `@agentic-learning struggle implement a debounce function in JavaScript`

- [ ] Agent starts with **Hint 1** (conceptual direction only — no code, no algorithm name)
- [ ] Agent waits for user's attempt before offering Hint 2
- [ ] Hint 2 is structural (shape of the solution, no code)
- [ ] Hint 3 provides a partial skeleton with blanks — not a complete solution
- [ ] Agent only reveals the full solution when the user says "show me" or "I give up"
- [ ] After reveal, agent asks the user to re-implement from scratch without looking
- [ ] "more hints" triggers the next hint level
- [ ] "show me" skips directly to the reveal at any point

---

## `either-or`

**Trigger:** `@agentic-learning either-or use Redis vs Postgres for session storage`

- [ ] If context is missing, agent asks for it (what are you building, what's the moment of decision)
- [ ] Agent pushes for **at least 2 genuine alternatives** — resists straw men
- [ ] Agent gathers: context, paths, choice, rationale, expected consequences — one question at a time
- [ ] Agent appends the formatted entry to `docs/decisions/YYYY-MM-DD-decisions.md`
- [ ] Entry matches the format defined in `references/either-or-format.md`
- [ ] **Outcome field** is set to `_pending_`
- [ ] Agent confirms the file was written

**Trigger:** `@agentic-learning either-or` (no decision specified)

- [ ] Agent asks "What decision did you just make, or are you about to make?" before doing anything else

---

## `explain`

**Trigger:** `@agentic-learning explain`

- [ ] Agent reads actual code/docs — does **not** just describe the file tree
- [ ] Summary covers all 7 sections: what it does, architecture, entry points, key concepts, non-obvious things, open questions, suggested learning path
- [ ] "Non-obvious things" section contains at least one genuinely non-obvious insight
- [ ] Summary is concise enough to read in ~2 minutes
- [ ] Agent writes/appends to `docs/project-knowledge.md`
- [ ] Agent does **not** overwrite existing entries — it appends with a new date header
- [ ] After summary, agent asks if there's a specific area to go deeper on

**Trigger:** `@agentic-learning explain references/`

- [ ] Agent focuses on the specified area only
- [ ] Still appends to `docs/project-knowledge.md` with a note indicating the focused scope

---

## Regression checklist (run after any `SKILL.md` change)

These are the most commonly broken behaviors after edits:

- [ ] `learn`: agent still asks before telling
- [ ] `struggle`: agent still gives hints in order, not all at once
- [ ] `brainstorm`: hard gate still holds — no code before approval
- [ ] `either-or`: outcome field still defaults to `_pending_`
- [ ] All file-writing actions: files go to the **user's project** `docs/`, not the skill directory

---

## Reporting a failure

If an agent consistently fails a checklist item, open an issue with:
- The agent and version you tested with
- The exact trigger you used
- What the agent did vs. what was expected
- The checklist item that failed

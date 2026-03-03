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
- [ ] After the user answers, agent gives **formative feedback** — not just "correct" or "incorrect":
  - [ ] If wrong: names what was wrong, explains *why*, anchors to the learning goal
  - [ ] If right: names what *specifically* they understood well (e.g. "you identified the key mechanism")
  - [ ] If partially right: clearly separates what was right from what needs work
- [ ] Agent does **not** say "great job!" or "you're so smart" as standalone praise
- [ ] Only after feedback does agent provide the full explanation
- [ ] Agent ends with a generation exercise (partial code or incomplete sentence for the user to complete)
- [ ] Agent does **not** give the full explanation before the user has answered

---

## `quiz`

**Trigger:** `@agentic-learning quiz` (with a code file open)

- [ ] Agent generates 3-5 questions based on the current file/topic
- [ ] Agent presents questions **one at a time** — waits for each answer before showing the next
- [ ] Agent does **not** reveal the answer before the user attempts it
- [ ] After each answer, agent gives **formative feedback** tied to the concept:
  - [ ] If wrong: explains what was wrong and why — not just "incorrect"
  - [ ] If right: confirms *what* they understood — not just "correct"
  - [ ] Feedback connects back to why the concept matters in context
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

**Trigger:** `@agentic-learning space` (first time — no existing `docs/revisit.md`)

- [ ] Agent identifies concepts from the current session (not generic/made-up ones)
- [ ] Agent categorizes them into tomorrow / 3 days / 1 week based on confidence level
- [ ] Agent writes `docs/revisit.md` with a dated entry
- [ ] Agent confirms the file was written and tells the user where it is

**Trigger:** `@agentic-learning space` (second time — `docs/revisit.md` already exists)

- [ ] Agent **reads the existing file** before generating any new entries
- [ ] Agent does **not** duplicate concepts already queued in `docs/revisit.md`
- [ ] If a concept from today's session is already scheduled for a *longer* timeline but was still shaky today, agent **reschedules it forward** (e.g. from 1 week to tomorrow) and notes why
- [ ] Agent appends a new dated entry rather than overwriting the file
- [ ] Agent tells the user how many new items were added and whether any were rescheduled

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
- [ ] Agent waits for the full explanation — does not interrupt or offer hints while the user is explaining
- [ ] After the user explains, agent gives structured feedback:
  - [ ] What they got right — names the specific concept or mechanism (not just "good")
  - [ ] What they missed or got wrong — precise, not vague ("you described the output but not the side effect")
  - [ ] The one most important thing to add to their mental model
- [ ] If the explanation was shallow or vague, agent asks **one follow-up precision question** (e.g. "you said it 'processes the data' — what transformation does it apply?") — this is the oracy scaffold
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

## `interleave`

**Trigger:** `@agentic-learning interleave`

- [ ] Agent reviews recent conversation and open files to identify distinct past topics before asking anything
- [ ] If no past context is available, agent asks "What are two or three topics you've been learning recently?" — does **not** make up topics
- [ ] Questions are drawn from **at least 2 different topics** — not all from the same domain
- [ ] Agent presents questions **one at a time** — does not list all questions upfront
- [ ] Agent does **not** announce which topic the next question is from
- [ ] After each answer, agent gives brief feedback before the next question
- [ ] After all questions, agent gives a summary: which topics were solid, which showed gaps, one suggested follow-up action

**Trigger:** `@agentic-learning interleave async/await decorators`

- [ ] Agent uses the two specified topics as the source for questions
- [ ] Questions still alternate — not all async first, then all decorators

---

## `cognitive-load`

**Trigger:** `@agentic-learning cognitive-load Kubernetes`

- [ ] Agent asks what specifically feels overwhelming — offers 3 categories (too many terms / too many steps / pieces don't connect)
- [ ] Agent waits for the user's answer before doing anything
- [ ] Agent classifies the load type correctly and responds with the appropriate strategy:
  - Too many terms → minimal glossary (3–4 essential terms only)
  - Too many steps → critical path identification
  - Pieces don't connect → text-based dependency map
- [ ] Agent produces a **chunked plan of 3–5 steps**, each explicitly labelled with why it matters
- [ ] Agent presents the plan and asks "Does this order make sense?" before proceeding
- [ ] Agent does **NOT** explain all steps at once — presents the plan, then offers to start Step 1
- [ ] Agent does **NOT** respond to overwhelm with more information — only with decomposition

**Trigger:** `@agentic-learning cognitive-load` (no topic specified)

- [ ] Agent asks what concept or task feels overwhelming before doing anything

---

## Regression checklist (run after any `SKILL.md` change)

These are the most commonly broken behaviors after edits:

- [ ] `learn`: agent still asks before telling
- [ ] `struggle`: agent still gives hints in order, not all at once
- [ ] `brainstorm`: hard gate still holds — no code before approval
- [ ] `either-or`: outcome field still defaults to `_pending_`
- [ ] `learn` and `quiz`: feedback is formative — names what was right/wrong and why, anchors to goal
- [ ] `learn` and `quiz`: no bare "correct!" or "great job!" as standalone responses
- [ ] `explain-first`: agent asks a precision follow-up if explanation is vague
- [ ] `space`: reads existing `docs/revisit.md` before scheduling; no duplicate entries
- [ ] `interleave`: questions are genuinely mixed — agent does not group by topic
- [ ] `cognitive-load`: agent responds with decomposition, not more explanation
- [ ] All file-writing actions: files go to the **user's project** `docs/`, not the skill directory

---

## Reporting a failure

If an agent consistently fails a checklist item, open an issue with:
- The agent and version you tested with
- The exact trigger you used
- What the agent did vs. what was expected
- The checklist item that failed

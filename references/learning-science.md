# Learning Science Reference

This file provides the agent with context on the four evidence-based learning techniques that power `agentic-learning`. Use it to explain the *why* behind each action when the user asks.

---

## The core problem: illusion of competence

When we read a fluent, well-structured answer from an AI model, it *feels* like we've learned. The information seems clear, logical, complete. But fluency in reading is not the same as encoding in memory or building understanding.

This is called the **illusion of competence**: we mistake the ease of *consuming* information for the ability to *use* it. Students who re-read notes feel more confident than students who test themselves — but they perform worse on exams.

**The fix:** learning requires effortful, active processing. The techniques below are not harder because they're poorly designed — they're harder because difficulty is the mechanism.

---

## Technique 1: Retrieval

**What it is:** The act of pulling information *out* of memory rather than putting it *in*.

**The research:** In a landmark study, students given a passage to read were divided into two groups: one group re-read it repeatedly; the other read it once and then tried to recall it from memory. The recall group remembered significantly more — even though they spent less time with the material.

**Why it works:** Retrieval strengthens the memory trace. Every time you successfully recall something, you make it easier to recall again. Re-reading does not do this — it only creates a familiarity signal, not a retrieval pathway.

**How the agent applies it:**
- In `learn`: ask the user to explain or recall before providing the answer
- In `quiz`: present questions from the current codebase; user answers before seeing corrections
- In `explain-first`: user narrates the code in their own words before the agent comments

---

## Technique 2: Spacing

**What it is:** Distributing learning over time rather than concentrating it in one session (cramming).

**The research:** Memory decays over time following the "forgetting curve" (Ebbinghaus, 1885). But each retrieval resets and extends the curve. Retrieving a concept after a delay is harder than retrieving it immediately — and that difficulty is precisely what strengthens the trace.

**Why it works:** Spaced practice forces the brain to rebuild the memory pathway from a weaker state, which leads to stronger long-term retention than massed practice.

**How the agent applies it:**
- In `space`: after a session, categorizes concepts by confidence level and schedules revisit prompts (tomorrow, 3 days, 1 week)
- Writes a `docs/revisit.md` file so the user has a concrete artifact to return to

---

## Technique 3: Generation

**What it is:** Producing an answer — even an incorrect one — before seeing the correct answer.

**The research:** In studies on "generation effect," students given word pairs like "rapid - ____" where they had to generate the word "fast" from a cue remembered the pair better than students given both words. Generating the answer, even incorrectly, creates a stronger memory trace than passively receiving it.

**Why it works:** The attempt to generate activates relevant knowledge and creates stronger encoding. Getting it wrong and then seeing the correct answer is more effective than never having to produce anything.

**How the agent applies it:**
- In `learn`: give partial examples (first line of code, function signature, first word) and ask the user to complete them
- In `struggle`: give the minimum context needed and ask the user to produce the solution, escalating hints only when truly stuck
- In `quiz`: fill-in-the-blank and predict-the-output questions

---

## Technique 4: Reflection

**What it is:** Structured self-assessment against a learning goal.

**The research:** Students who engaged in structured reflection — asking "how am I learning?", "what is my goal?", and "what are the gaps?" — showed measurably better outcomes than students who reviewed the same material without reflection.

**Why it works:** Reflection forces metacognition: thinking about your own thinking. It surfaces gaps that passive review hides and creates a feedback loop between effort and outcome.

**How the agent applies it:**
- In `reflect`: ask the three structured questions in sequence and generate a gap analysis
- In `struggle`: after revealing the answer, ask "can you re-implement this from scratch?"
- In `either-or`: ask the user to articulate rationale and expected consequences, which is itself a reflective act

---

## The neurological basis

Sustained mental effort is positively correlated with brain growth. A neuroscience study of London taxi drivers (who must memorize 26,000 streets to pass "The Knowledge" exam) found enlarged hippocampal regions compared to non-taxi drivers. The structural changes correlated with years of experience — the brain literally grows in response to the kind of effortful spatial memory work required by the job.

**The implication for software learning:** understanding a codebase, an architecture, or a new language requires the same kind of active, effortful construction of mental models. AI can provide the scaffolding, but the user must do the building.

---

## Primary sources

- Roediger, H.L. & Karpicke, J.D. (2006). "Test-Enhanced Learning." *Psychological Science*, 17(3), 249–255.
- Ebbinghaus, H. (1885). *Über das Gedächtnis*. (Memory: A Contribution to Experimental Psychology.)
- Maguire, E.A. et al. (2000). "Navigation-related structural change in the hippocampi of taxi drivers." *PNAS*, 97(8), 4398–4403.
- Hattie, J. & Timperley, H. (2007). "The Power of Feedback." *Review of Educational Research*, 77(1), 81–112.
- Brown, P.C., Roediger, H.L., & McDaniel, M.A. (2014). *Make It Stick: The Science of Successful Learning.* Harvard University Press.

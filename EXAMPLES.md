# Examples — agentic-learning

Detailed walkthroughs of each action, showing realistic conversations between user and agent.

---

## `learn` — Teaching through retrieval and generation

**Scenario:** You're new to Python's `asyncio` and want to actually understand it, not just get a summary.

```
You: @agentic-learning learn async/await in Python
```

```
Agent: Before I explain anything — what do you already know about async/await?
       Even a rough intuition counts. What problem do you think it's solving?
```

```
You: I think it has to do with running things at the same time?
```

```
Agent: Good instinct — you're pointing at the right problem. Let me add precision.

       async/await is about concurrency, not parallelism. The difference matters:
       parallelism = two things happening at the exact same moment (two CPUs working).
       concurrency = one thread switching between tasks while one is waiting (e.g. for
       a network response), so nothing is wasted sitting idle.

       Python's asyncio runs on a single thread. It can't do two things simultaneously,
       but it can do other work while waiting for I/O.

       Now — generation exercise. Complete this function:

       async def fetch_user(user_id: int):
           response = await _______________
           return response.json()

       What goes in the blank, and why does it need `await`?
```

---

## `quiz` — Retrieval practice on your current file

**Scenario:** You've just finished writing a module and want to test your understanding before moving on.

```
You: @agentic-learning quiz
```

```
Agent: I'll quiz you on the current file. Answer each question before I show the next.

       Question 1 of 4:
       This function is called in three places in the codebase.
       Without looking — what does `normalize_weights()` return?
```

```
You: A list of floats that sum to 1.0
```

```
Agent: Correct. It returns a list of floats normalized so they sum to 1.0.
       The edge case worth noting: if the input list is all zeros, it raises
       a ValueError rather than returning zeros.

       Question 2 of 4:
       What's the difference between `fit()` and `fit_transform()` in this class?
```

---

## `struggle` — Productive struggle with hint ladder

**Scenario:** You need to implement a debounce function in JavaScript and you want to work through it rather than just get the answer.

```
You: @agentic-learning struggle implement a debounce function in JavaScript
```

```
Agent: [Hint 1 — Conceptual direction]

       Think about what "debounce" means in physical electronics: a button that
       bounces several times when pressed but should only register once.

       In code, what mechanism exists in JavaScript for "do this, but not yet"?
```

```
You: setTimeout?
```

```
Agent: Exactly. Now think about what needs to happen when the function is called
       again before the delay has elapsed.

       Give it a try — don't worry about getting it perfect.
```

```
You: function debounce(fn, delay) {
       let timer;
       return function() {
         setTimeout(fn, delay);
       }
     }
```

```
Agent: You have the right structure and you found the right tool.
       One thing is missing: you're creating a new timer every call, but you're
       not cancelling the previous one.

       [Hint 2 — Structural hint]

       Each time the returned function is called, it should:
       1. Cancel whatever timer is currently pending
       2. Start a fresh timer

       JavaScript has a built-in function for step 1. What is it?
```

```
You: clearTimeout?
```

```
Agent: Yes. Try combining clearTimeout and setTimeout now.
```

```
You: function debounce(fn, delay) {
       let timer;
       return function() {
         clearTimeout(timer);
         timer = setTimeout(fn, delay);
       }
     }
```

```
Agent: That's it. Clean and correct.

       One thing to add: the returned function should forward its arguments to `fn`,
       so the debounced function can be used in place of the original.
       How would you pass `this` and arguments through?

       (If you want to stop here and look it up: that's the right call.
       The core logic is solid.)
```

---

## `reflect` — End-of-session structured reflection

**Scenario:** You've spent 2 hours building a data pipeline and want to close the session properly.

```
You: @agentic-learning reflect
```

```
Agent: Let's close this session with three questions. Take your time with each.

       1. What did you learn today — what concepts or patterns clicked that didn't
          before, or what did you understand more deeply?
```

```
You: I understood how generator functions work in Python. I kept using them
     without really knowing why they were memory-efficient.
     Also got clearer on when to use list comprehensions vs generators.
```

```
Agent: Good. That distinction (eager vs lazy evaluation) is foundational
       and transfers to a lot of other contexts.

       2. What was your goal when you started this session?
```

```
You: Build a pipeline that processes 10M rows without loading everything in memory.
```

```
Agent: 3. Given that goal — what do you still feel uncertain about?
          What's the thing you'd want to understand better before calling this done?
```

```
You: I'm not sure how to handle backpressure if the consumer is slower than
     the producer. I just ignored it for now.
```

```
Agent: ── Reflection summary ──────────────────────────────────────

       What you covered: lazy evaluation via generators; list comprehension
       vs generator expression trade-offs; memory-efficient pipeline design.

       Gap identified: backpressure handling — what happens when the consumer
       can't keep up with the producer.

       Suggested next step:
       @agentic-learning learn backpressure in Python async generators

       Or search: "asyncio queue backpressure Python" — the asyncio.Queue class
       is the standard tool here and will map directly onto what you built today.
```

---

## `space` — Schedule concepts to revisit

**Scenario:** After a learning session, you want to make sure the concepts stick.

```
You: @agentic-learning space
```

```
Agent: Based on this session, here's what I'd suggest revisiting:

       Writing to docs/revisit.md...

       ── Tomorrow ─────────────────────────────────────
       • Generator lazy evaluation: you understood it today but it's new —
         try explaining it out loud without looking at code.

       ── In 3 days ────────────────────────────────────
       • List comprehension vs generator: you're clear on the basics,
         reinforce the edge cases (large files, chained generators).

       ── In 1 week ────────────────────────────────────
       • asyncio pipeline structure: solid foundation, good to revisit
         once you've added the backpressure handling.

       ✓ Written to docs/revisit.md
```

---

## `brainstorm` — Collaborative design dialogue

**Scenario:** You want to build an auth system and need to think it through before writing any code.

```
You: @agentic-learning brainstorm auth system for a multi-tenant SaaS
```

```
Agent: Let me look at what you have in the codebase before we start...

       [reads relevant files]

       I see you're using FastAPI with a PostgreSQL database.
       One question to start:

       Is each tenant completely isolated (separate databases / schemas),
       or do all tenants share tables with a tenant_id column?
```

```
You: Shared tables, tenant_id column.
```

```
Agent: Good — that shapes things significantly.

       Next question: what's your threat model for tenant isolation?
       Specifically: are you worried about accidental data leakage
       (a bug exposes tenant A's data to tenant B), or active attacks
       (a tenant trying to access another's data intentionally)?
```

```
You: Mainly accidental leakage. We trust our users.
```

```
Agent: That's the more common case and it simplifies things.

       I see three reasonable approaches:

       A — Row-level security in PostgreSQL (recommended)
         Set a session variable per request; Postgres enforces the filter
         automatically on every query. Hard to accidentally forget.
         Trade-off: requires PostgreSQL-specific features, adds a small
         per-query overhead.

       B — Application-level tenant middleware
         A FastAPI dependency injects tenant_id into every query.
         Simple to understand; works with any DB.
         Trade-off: one missed dependency = data leak. Relies on developer discipline.

       C — ORM-level global filter (e.g. SQLAlchemy query filter)
         Register a default filter on every model.
         Trade-off: can be bypassed with raw queries; less visible than RLS.

       My recommendation: A, with B as a belt-and-suspenders backup.
       RLS gives you DB-level enforcement even if application code has a bug.

       Does this match your constraints?
```

*(After approval, agent writes `docs/brainstorm/2026-03-02-auth-system.md`)*

---

## `explain-first` — You narrate before the agent comments

**Scenario:** You're reviewing code you wrote a week ago and want to test if you still understand it.

```
You: @agentic-learning explain-first
```

```
Agent: Looking at the current file...

       Before I say anything: walk me through what `build_feature_matrix()` does.
       Explain it as if you're teaching someone who hasn't seen it.
       Take your time.
```

```
You: It takes a list of user events, groups them by user_id, and for each user
     builds a vector of features — like how many times they clicked, their last
     active date, that kind of thing. Returns a numpy array.
```

```
Agent: Good — you have the right mental model.

       Two things to add:
       1. The groupby uses a defaultdict internally, which means missing users
          get a zero vector rather than raising a KeyError. Worth knowing when
          you debug downstream issues.
       2. The "last active date" is stored as days-since-epoch (an integer),
          not a datetime — which affects how you'd interpret the feature weights
          in a model.

       Both are easy to miss if you're just reading fast.
```

---

## `either-or` — Decision journal

**Scenario:** You just decided to use Redis for session storage instead of the database and want to record it.

```
You: @agentic-learning either-or use Redis vs database for session storage
```

```
Agent: Let me capture this properly.

       What's the context — what are you building and what triggered this decision?
```

```
You: Building the session layer for the auth system. We need to store JWT
     refresh tokens so we can revoke them. Decided to use Redis instead of
     a sessions table in Postgres.
```

```
Agent: Good. What were the real alternatives you considered?
       (You mentioned Redis vs database — any others?)
```

```
You: Also considered stateless tokens with short expiry and no revocation.
     Three options: Redis, Postgres table, or just accept no revocation.
```

```
Agent: What made you choose Redis?
```

```
You: Fast reads, built-in TTL, doesn't pollute the main DB schema.
     The no-revocation option felt too risky for a SaaS product.
```

```
Agent: What do you expect to happen as a result of this choice?
```

```
You: We'll need to add Redis to infrastructure. Slightly more ops complexity.
     But instant revocation on logout and easy token TTL management.
```

```
Agent: ✓ Appended to docs/decisions/2026-03-02-decisions.md

       ## [14:35] Session storage: Redis vs Postgres vs stateless

       **Context:** Building the session layer for JWT refresh token revocation
       in a multi-tenant SaaS auth system.

       **Paths considered:**
       - **A — Redis:** Fast reads, built-in TTL, doesn't pollute main DB schema.
       - **B — Postgres sessions table:** No new infrastructure; slower reads; schema noise.
       - **C — Stateless (no revocation):** Zero ops cost; tokens live until expiry.

       **Chosen:** A — Redis

       **Rationale:** Fast reads + native TTL + clean separation from main DB.
       No-revocation felt too risky for a product with paying customers.

       **Expected consequences:** Additional infrastructure dependency (Redis).
       Ops complexity increases slightly. Gain: instant token revocation on logout.

       **Outcome (to fill later):** _pending_
```

---

## `explain` — Project comprehension log

**Scenario:** You've just cloned an unfamiliar repo and want to understand what it is before touching anything.

```
You: @agentic-learning explain
```

```
Agent: Reading the project...

       [scans README.md, SKILL.md, references/, EXAMPLES.md, install.sh]

       ── agentic-learning — Comprehension log ─────────────────────────
       Generated: 2026-03-03 00:09

       ### What this project does
       An agent skill that turns an AI coding assistant into a learning
       partner. Instead of handing over answers, it guides users through
       eight structured actions grounded in neuroscience (retrieval,
       spacing, generation, reflection) and philosophy (Kierkegaard's
       Either/Or). Installable in Windsurf, Cursor, Copilot, and any
       AgentSkills-compatible agent.

       ### Architecture overview
       Single SKILL.md file drives all behavior — the agent reads it as
       instructions. Three reference files provide deeper context:
       learning-science.md (the research), struggle-ladder.md (hint system),
       either-or-format.md (decision journal format). No code to run — pure
       markdown instructions for the agent.

       ### Entry points
       - Install: `npx skills add FavioVazquez/agentic-learn`
       - Use: `@agentic-learning <action>` in any compatible agent
       - All 8 actions are defined in SKILL.md

       ### Key concepts to understand
       1. The skill body is agent instructions, not user docs — write it
          for the model to read and follow
       2. `description` in frontmatter is the trigger — specificity matters
       3. All output files go into the user's project (docs/), not the skill
       4. The "productive struggle" principle governs all actions — the agent
          must not short-circuit the user's cognitive effort
       5. either-or and brainstorm produce persistent artifacts (markdown files)

       ### Non-obvious things
       - The skill is installed as a symlink by `npx skills` — edits to the
         source repo are reflected immediately without reinstalling
       - `explain-first` and `explain` look similar but are opposite directions:
         explain-first = user explains TO the agent; explain = agent explains
         TO the user
       - version is "1.1" in SKILL.md — bump this on any behavioral change

       ### Open questions
       - No test suite exists yet for verifying agent compliance with the
         skill's constraints (the "wait before answering" rule especially)
       - CONTRIBUTING.md not yet written

       ### Suggested learning path
       1. Read SKILL.md top to bottom — understand each action's constraints
       2. Run through EXAMPLES.md — see what correct behavior looks like
       3. Install and test each action once before contributing changes
       4. Read references/ to understand the science behind the design choices

       ✓ Written to docs/project-knowledge.md

       Is there a specific area you want to go deeper on, or something
       that seems wrong in my reading?
```

---

**Scenario:** You've been working on the project for a while and run `explain` again — it appends rather than overwrites.

```
You: @agentic-learning explain references/
```

```
Agent: Reading the references/ directory specifically...

       ── agentic-learning — Comprehension log ─────────────────────────
       Generated: 2026-03-10 14:22 (focused: references/)

       ### What this area does
       Three supporting documents the agent reads during skill execution.
       They are NOT user-facing docs — they are instructions and context
       for the agent to draw on when running specific actions.

       ### Non-obvious things
       - learning-science.md is cited in the SKILL.md body — if you update
         the research section, the agent will use it automatically
       - struggle-ladder.md defines 4 hint levels plus extended hints —
         the "harder" mode collapses levels upward
       - either-or-format.md contains 3 full worked examples, which is the
         most valuable part for calibrating agent behavior

       ✓ Appended to docs/project-knowledge.md
```

---

## `interleave` — Mixed retrieval across topics

**Scenario:** You've been learning Python generators, async/await, and decorators across separate sessions. Instead of going deep on one again, you want a session that mixes all three to force real discrimination.

```
You: @agentic-learning interleave
```

```
Agent: I can see you've been working across generators, async/await, and decorators
       recently. I'll mix questions from all three — don't expect them to stay in
       one topic.

       Question 1 of 5:

       What does this return, and why?

       def gen():
           yield 1
           yield 2
           yield 3

       list(gen())
```

```
You: [1, 2, 3] — because list() exhausts the generator by calling next() repeatedly
     until StopIteration.
```

```
Agent: Exactly right. The key detail you named — StopIteration — is what list()
       is actually catching internally. That's a non-obvious thing most people miss.

       Question 2 of 5:

       Different topic. Complete this sentence:
       "The difference between `async def` and a regular `def` is that async def
       returns a ________, which only runs when ________."
```

```
You: Returns a coroutine, which only runs when awaited or passed to an event loop.
```

```
Agent: Correct on both. Worth adding: the coroutine object is created immediately
       when you call the function — it just doesn't execute until driven.

       Question 3 of 5:

       Back to generators. What's the difference between these two:

       # A
       data = [x * 2 for x in range(1000000)]

       # B
       data = (x * 2 for x in range(1000000))
```

```
You: A builds the whole list in memory immediately. B is a generator expression —
     it produces values lazily, one at a time, so memory usage stays flat.
```

```
Agent: Right. The shape is identical, the brackets are the only difference —
       and the memory behaviour is completely different. That's worth remembering
       as a gotcha in code review.

       Question 4 of 5:

       New topic. What does a decorator actually do at the Python level?
       Explain it mechanically, not conceptually.
```

```
You: It wraps a function — takes the original function as input, returns a new
     function that usually calls the original inside it. The @ syntax is just
     shorthand for: my_func = decorator(my_func)
```

```
Agent: That's the cleanest possible explanation. The desugaring (@syntax = 
       reassignment) is exactly what people miss when they first see decorators.

       Question 5 of 5 — mixing two topics:

       Could you write a decorator that measures how long a coroutine takes to run?
       You don't need to write it perfectly — just sketch the structure.
```

```
You: import time, functools, asyncio

     def timer(func):
         @functools.wraps(func)
         async def wrapper(*args, **kwargs):
             start = time.time()
             result = await func(*args, **kwargs)
             print(f"Took {time.time() - start:.2f}s")
             return result
         return wrapper
```

```
Agent: That's correct and complete. Two things worth noting:
       1. The wrapper must be `async def` because it awaits the original function
       2. functools.wraps preserves the original function's metadata — easy to forget

       ── Session summary ──────────────────────────────────────────

       Solid across the board. Strongest: generators (mechanics and memory model)
       and the decorator desugaring.

       Worth revisiting: the event loop / coroutine lifecycle — you got the surface
       right but the "driven by the event loop" part was thin.

       Suggested follow-up:
       @agentic-learning struggle write an async event loop from scratch (simplified)
```

---

## `cognitive-load` — Decompose an overwhelming concept

**Scenario:** You're trying to learn Kubernetes and everything feels connected to everything else — you don't know where to start.

```
You: @agentic-learning cognitive-load Kubernetes
```

```
Agent: Before I break it down — what specifically feels overwhelming?

       Is it:
       A — Too many new terms (pod, node, cluster, deployment, service...)
       B — Too many steps to get something running
       C — The pieces don't connect — you can read the docs but can't
           build a mental model of how it all fits
```

```
You: Honestly C mostly. I've read the docs but I can't picture how a request
     actually gets from the internet to my container.
```

```
Agent: That's the right question to start with — request flow is the spine
       everything else hangs on.

       Here's the dependency map — what needs to exist before each thing works:

       Internet → LoadBalancer Service
                → Ingress Controller (optional but common)
                → ClusterIP Service  
                → Pod (your container)
                → Node (the machine the pod runs on)
                → Cluster (the set of nodes)

       The key insight: a Pod is the smallest unit, but you almost never
       talk to it directly. Services are stable addresses that route to Pods,
       because Pods are ephemeral — they die and get replaced.

       Here's a 5-step learning plan, each piece small enough to hold in
       working memory on its own:

       Step 1: Pod — what it is and how to run one manually
               Why it matters: everything else is built on top of this

       Step 2: Service (ClusterIP) — how to give a Pod a stable address
               Why it matters: Pods die; Services don't

       Step 3: Deployment — how Kubernetes manages Pod lifecycle for you
               Why it matters: you never create Pods directly in production

       Step 4: Ingress — how external HTTP traffic gets routed in
               Why it matters: this is what connects your app to the internet

       Step 5: Namespace — how to isolate workloads in one cluster
               Why it matters: required for any multi-team setup

       Does this order make sense, or is there something you think
       belongs earlier?
```

```
You: This is really helpful. Can we start with Step 1?
```

```
Agent: @agentic-learning learn Kubernetes Pods — starting now.

       Before I explain anything: what do you think a Pod is?
       Even a rough guess counts.
```

---

## Chaining actions in a session

These actions work well together. A few typical session patterns:

**Onboarding a new repo:**
```
# Understand what you're working with before touching anything
@agentic-learning explain

# Design the first change before coding it
@agentic-learning brainstorm caching strategy for the API

# Record the key architectural decision
@agentic-learning either-or use Redis cache vs in-memory LRU

# Work through the hardest part with productive struggle
@agentic-learning struggle implement LRU cache in Python without a library

# Test your understanding of what you built
@agentic-learning quiz

# Close the session properly
@agentic-learning reflect
@agentic-learning space
```

**Deep review session (reinforcing past learning):**
```
# Mix topics from past sessions — harder but stickier than going deep on one
@agentic-learning interleave

# Close with spacing reminders so today's review is reinforced over time
@agentic-learning space
```

**Tackling something overwhelming:**
```
# Break it into working-memory-sized pieces first
@agentic-learning cognitive-load distributed tracing in microservices

# Then learn the first piece properly
@agentic-learning learn Step 1 concept from the plan

# Struggle through the implementation
@agentic-learning struggle implement the first piece

# Reflect on what you understood vs. what you just followed
@agentic-learning reflect
```

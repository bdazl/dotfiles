# Work — guided exploration → questions → plan

Guided work loop: explore, ask focused questions, then enter plan mode.
The goal is alignment before planning, not implementation.

Initial task: $ARGUMENTS

## 0. If no task was given

If `$ARGUMENTS` is empty, ask the user — in one short line — what they
want to work on. Wait for an answer before doing anything else. Don't
guess from recent context or open files.

## 1. Explore (only if needed)

Read enough of the codebase to ask informed questions. For a trivial
task, skip this step. For anything non-trivial, prefer parallel `Agent`
(Explore) calls for breadth and direct `Read` for known files.

Pick up the project's own conventions while you're there: `CLAUDE.md`,
`AGENTS.md`, `README`, and any `.claude/rules/` or equivalent docs the
repo keeps. Also note how the repo already does things — build and test
commands, directory layout, naming, commit style in `git log`.

Stop exploring as soon as you can name the real decisions. Don't keep
reading "just in case" — questions surface the rest.

## 2. Ask the load-bearing questions

Surface decisions that actually change what gets built: scope
boundaries, subsystem splits, naming, dependencies, error model, test
strategy, in-scope vs. out-of-scope, etc.

Skip anything already settled by the project's conventions — the files
found in step 1, or the pattern the surrounding code already follows.
Don't re-ask what those already answer.

For every question:

- **Use `AskUserQuestion`.** Never plain-text questions — the user wants
  a pickable TUI.
- **Recommendation first** in the option list, with `(Recommended)` in
  the label. Lead with what you'd choose; the others are alternatives.
- Each option's `description` names the trade-off in one short line, not
  what the option literally says.
- 2–4 options per question. The harness adds "Other" for free-form, so
  don't include your own.
- Use `preview` when the choice is a concrete artifact the user should
  see side by side — a config snippet, a layout, two code shapes.
- Batch related questions in a single `AskUserQuestion` call (up to 4)
  when they're independent. Ask sequentially when one answer should
  shape the next question.

If a decision is open-ended ("what should this be called?") and a
pick-list feels forced, still propose 2–3 concrete starting points — the
user can override via Other.

Don't pad. A question that wouldn't change what you build is noise.

## 3. Decide whether plan mode is worth it

Once the open questions are answered, judge whether the work actually
needs a plan:

- **Small enough that a plan is overhead** — a localized change, an
  obvious fix, a few lines in one place with no real design decisions.
  Skip plan mode. Say so in one line and proceed straight to the work.
- **Non-trivial** — multiple files, subsystem splits, design trade-offs,
  or anything where a plan earns its keep. Hand off to plan mode: call
  `EnterPlanMode` directly. Don't ask "ready to plan?" first — the user
  prefers automatic hand-off.
- **Genuinely ambiguous** — you can't tell which bucket it falls in.
  Fold the call into step 2: add one `AskUserQuestion` option asking
  whether to plan or just do it, rather than guessing.

If you hand off but `EnterPlanMode` isn't accessible for any reason, say
one sentence: "Enough context — flip to plan mode when ready."

## Don'ts

- Don't start implementing before the questions are answered — this
  command is exploration + alignment first. Only proceed to the work
  once you've judged (step 3) that the change is too small to warrant a
  plan.
- Don't ask permission questions ("should I read more?", "ready to
  plan?"). Just act, or hand off.
- Don't summarize what you read back at the user before asking — the
  questions themselves prove you understood.

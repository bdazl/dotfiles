---
name: work
description: Guided work loop for exploring a task, asking focused questions, and planning before substantial implementation. Use when the user invokes $work or asks to align on a non-trivial change before coding.
---

# Work — guided exploration, questions, and planning

Use this workflow to align on the task before substantial implementation. The initial task is the user's text following `$work`.

## 1. If no task was given

Ask one short question about what the user wants to work on. Wait for the answer before inspecting files or inferring intent from recent context.

## 2. Explore only as needed

Read enough of the repository to ask informed questions. Skip exploration for trivial tasks. For non-trivial tasks, inspect the relevant `AGENTS.md`, `README`, existing patterns, and nearby code. Stop as soon as the important decisions are clear.

Read `../../implementation-policy.md` and `../../commit-policy.md` before planning or implementation.

## 3. Ask only load-bearing questions

Ask about decisions that materially change the result, such as scope, interfaces, dependencies, failure behavior, or acceptance criteria. Do not ask about choices already settled by repository conventions.

Batch related questions when possible. Prefer a short set of concrete options with a recommendation and the trade-off for each. Use the current Codex surface's interactive question control when available; otherwise ask directly in concise prose. Wait for answers before continuing.

The commit mode (`auto`, `checkpoint`, `manual`; see `../../commit-policy.md`) is load-bearing: if neither the user nor the repository's instructions have set it, include it in the questions with `auto` recommended.

Do not summarize the exploration before asking. Make the questions specific enough to show what you learned.

## 4. Decide whether planning is useful

- For a localized, obvious change, say briefly that planning would add overhead and proceed with the work once the user's answers are in.
- For non-trivial work involving multiple files, meaningful design choices, or subsystem boundaries, switch to Plan mode if available. If the current surface cannot switch modes, present a concise plan and pause for the user's direction.
- If the distinction is genuinely unclear, ask whether the user wants a plan or direct implementation.

Every plan ends with a **Commits** section: the commit mode and the ordered list of atomic commit titles, each tied to the step that completes it. During implementation, act on each unit as soon as it is done: commit it (`auto`) or stop and propose its title (`checkpoint`). Never batch the units into commits at the end. Without a plan, the same rule applies to the work you proceed with directly.

Do not ask whether you should explore or whether the user is ready to plan. Do not begin substantial implementation before the open questions are answered.

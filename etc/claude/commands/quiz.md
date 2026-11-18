# Quiz — verify and deepen understanding of the system being built

Ask the user questions, one at a time, that check and improve their
understanding of the selected change or topic. This is teaching and
verification, not an adversarial exam.

Arguments: $ARGUMENTS

This is a **read-only** activity.

@~/.claude/understanding-scope.md

Additional flags:

- `--deep` — harder questions: subtle invariants, failure paths,
  interactions, and design trade-offs.
- `--count <n>` — approximate number of main questions (default about 5).
  Follow-ups and hints do not count.
- `--explain` — quiz on the concepts from the preceding explanation in this
  conversation (typically `/explain`), using its target. If no such
  explanation is in context, say so in one line and continue with the
  target resolved from the remaining arguments.

## 1. Prepare

Inspect enough implementation, contracts, tests, and documentation to hold
an evidence-grounded model of the target. Then pick the concepts that
matter most for understanding it — the ones a contributor must get right
to change it safely. Do not show this list to the user.

Do not explain the target up front. Start with one line naming the target
and the approximate question count, then the first question.

## 2. Ask

- Ask **exactly one question per turn** in plain text, then stop and wait.
  Do not use `AskUserQuestion`: answers must be free-form.
- Prefer open-ended questions that require reasoning over trivia, recall of
  names, or multiple choice.
- Vary the kind across the session, as fits the target:
  - **model** — what a concept is responsible for, how parts relate
  - **trace** — what happens when a given input or event flows through
  - **invariant** — what must always hold, and what maintains it
  - **failure** — what happens when something goes wrong or an edge is hit
  - **design** — why this approach, and what it trades off
- Ground every question in actual behavior. Never invent behavior to make a
  question more interesting. Label hypothetical scenarios explicitly
  ("Hypothetically, if …").
- Reference code locations when the question is about a specific place, but
  do not quote the part that gives away the answer.

## 3. Respond to answers

- Assess the reasoning, not the vocabulary. Distinguish a correct mechanism
  from a lucky guess or the right term used without understanding; probe
  with a short follow-up when unsure.
- **Correct**: confirm briefly, add one sharpening detail if useful, move
  on.
- **Partial or incorrect**: name what is right, then give a hint or a
  narrower follow-up. Reveal the answer only after a second attempt, or
  sooner if the user asks or says they do not know after a hint. When
  revealing, explain it with `path:line` references.
- Adapt: go deeper where understanding is solid, revisit a weak concept
  from a different angle later.
- Never reveal an answer before the user has attempted the question,
  unless they explicitly ask.

## 4. Finish

End after about the requested count, or earlier if the user asks to stop.
Then summarize briefly:

- **Solid** — concepts the user demonstrated understanding of.
- **Gaps** — concepts with incomplete or incorrect reasoning, stated
  concretely.
- **Revisit** — specific `path:line` areas worth reading.

No numerical scores or grades, and no claim that a short session measures
expertise.

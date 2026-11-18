# Explain — build an accurate mental model of code or a change

Explain the selected change or topic so the user understands what it does,
why, and how — well enough to reason about it on their own.

Arguments: $ARGUMENTS

This is a **read-only** analysis.

@~/.claude/understanding-scope.md

`--deep` also means a more detailed explanation: more mechanisms, edge
cases, and implementation detail.

## Process

**1. Resolve the target** per the scope above. For a change, read the full
diff first, then enough surrounding code to know what it was like before.

**2. Build the model before writing.** Establish the problem addressed, the
concepts and their responsibilities, the mechanisms that implement them,
and — for a change — what behaves differently afterwards. Use parallel
`Agent` (Explore) calls only when the target spans several independent
areas.

**3. Explain concepts before code.** Lead with the model; use the
implementation to show how it is realized, not as the narrative itself.

## Content

Cover what applies, in roughly this order:

1. **Problem** — what the code or change addresses.
2. **Model** — the concepts, their responsibilities, and how they relate.
3. **Mechanisms** — how the relevant parts work, traced through a
   representative path.
4. **Behavior change** — for a change: before vs. after, including
   behavior that deliberately stays the same.
5. **Subtleties** — invariants, state transitions, ordering, failure
   paths, trade-offs, and details that are easy to get wrong.

Use concrete examples, `path:line` references, and small diagrams (ASCII,
a few lines) where they clarify flow or structure. Mark statements as
intended or inferred where they are not verified.

## Style

- Scale length to complexity: a small change gets a few paragraphs, not a
  report template. Omit sections that add nothing.
- Organize by concept, not by file. Do not narrate the diff file by file.
- Skip trivial mechanics (renames, imports, formatting) unless they matter.
- No review findings, praise, or suggested improvements. If a defect is
  plainly visible, mention it in one line as a side note.

End with a one-line note of the target (e.g. `Target: feature-x vs merge
base with origin/develop, incl. working tree`). Optionally suggest `/quiz
--explain` to check understanding.

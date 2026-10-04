---
name: defect-review
description: Read-only, precision-first review for concrete defects in a selected change. Use when the user invokes $defect-review or asks for a focused bug hunt.
---

# Defect Review — precision-first defect hunt

Search for concrete defects introduced or exposed by the selected change. Prioritize precision over coverage. Report only findings with a plausible, evidence-backed failure scenario. Zero findings is a successful review.

This is read-only. Do not modify the repository, create commits, switch branches, post review comments, approve or reject reviews, change issues, or modify remote state.

## Target and depth

Keep the review target separate from the context inspected. Only the target may produce findings; inspect surrounding code as needed to validate a candidate.

Parse the target from the user's arguments:

- Default: current branch relative to its base, including staged and unstaged changes. Determine the base from the upstream tracking ref, then the remote default branch. Compare against the merge base.
- `--working`: uncommitted working-tree changes only.
- `--staged`: staged changes only.
- `--commit <rev>`: one commit.
- `--range <a>..<b>`: an explicit revision range.
- `--base <ref>`: compare the current branch with this base using the default target behavior.

Reject conflicting target selectors instead of guessing. If there is no meaningful change to review, say so briefly and stop.

Depth is selected with `--depth=<local|context|history|deep>`; default to `context`:

- `local`: the diff and minimum nearby code needed to understand it.
- `context`: relevant definitions, callers, callees, interfaces, tests, state and data flow, and directly involved configuration or schema.
- `history`: context plus targeted Git history when it helps establish intent or whether a suspected regression is real.
- `deep`: broader investigation, focused builds, tests, static analysis, or small reproductions when they answer a concrete review question.

Expand inspection only to answer a specific question. Do not browse arbitrarily.

## Review process

1. Establish the intended behavior and important contracts from the change and relevant project guidance.
2. Build a small risk map based on the change, such as logic, boundaries, error handling, state transitions, concurrency, parsing, authorization, persistence, compatibility, or operational failures. Apply only relevant dimensions.
3. Search independently for plausible defects. Use parallel reviewers only when the review warrants them and the current environment permits delegation.
4. Require a concrete failure scenario: precondition or trigger → execution path → incorrect observable result.
5. Adversarially verify every candidate. Look for guards, caller guarantees, lifecycle constraints, tests, library semantics, unreachable states, and intentional behavior. Drop candidates that do not survive.
6. Use targeted checks as evidence when the selected depth warrants them. Do not run broad or expensive checks when a focused check answers the question.
7. Drop speculation, unrelated pre-existing issues, style comments, and duplicate findings.

## What counts as a defect

Report incorrect behavior, crashes, broken invariants, regressions, contract violations, data loss or corruption, transaction or retry failures, concurrency defects, concrete resource leaks, security issues, compatibility breaks, or operational failures.

Do not report style, naming, formatting, subjective preferences, speculative extensibility, generic maintainability, instruction-file compliance, or vague risks. Missing tests alone are not a finding. Report a test defect only when it helps demonstrate a concrete defect.

## Precision and severity

- If you cannot explain how the defect manifests, omit it.
- If the target did not introduce, expose, or materially worsen it, omit it.
- If evidence remains genuinely ambiguous after verification, omit it.
- `P0`: critical or catastrophic.
- `P1`: significant correctness, security, or operational defect.
- `P2`: limited but concrete and high-confidence defect.

Bias toward P0 and P1. Do not invent confidence percentages.

## Output

For each finding, use:

```text
[P1] Short defect title
path/to/file:line

<Trigger, incorrect behavior, and observable consequence.>

Evidence:
- <specific evidence>
- <specific evidence>

Impact:
<concrete observable consequence>
```

Point to the changed code responsible for the defect when possible. Do not add remediation sections or implement fixes. If no validated defects remain, output exactly:

`No defects found.`

Optionally add a terse note describing the target and depth when that helps the user understand the review.

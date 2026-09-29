# Defect Review — precision-first defect hunt

Search for concrete defects introduced or exposed by the selected change.
Prioritize precision over coverage. Report only findings with a plausible,
evidence-backed failure scenario.

Arguments: $ARGUMENTS

This is a **read-only** analysis. A review that finds zero defects is fully
successful — finding count is not a success metric. This is a defect hunt,
not a general code review.

## Hard constraints

Have **zero side effects** on the reviewed repository beyond ordinary
read-only inspection and verification. Never modify code, create commits,
touch branches, post PR/MR comments, approve or reject reviews, modify
issues, or change any remote state. There is no commenting mode.

## Target vs. depth

Keep two concepts distinct:

- **Target** — which change is reviewed. Only the target may generate
  findings.
- **Depth** — how far outside the target you may inspect to understand and
  verify it.

Invariant: **reason globally, report locally.** Inspect surrounding code —
contracts, callers, callees, state, tests — freely, but never report
unrelated pre-existing defects.

### Selecting the target

Parse intent from `$ARGUMENTS`. Determine the base branch sensibly from
local Git (upstream tracking ref, then the remote default branch); do not
assume `main`. Always use the **merge base**, not tip-to-tip.

- default (no target flag): current branch vs `git merge-base HEAD <base>`,
  **including staged and unstaged working-tree changes** — "review what I am
  building relative to the branch it came from"
- `--working`: only uncommitted working-tree changes
- `--staged`: only staged changes
- `--commit <rev>`: a single commit
- `--range <a>..<b>`: an explicit revision range
- `--base <ref>`: default target, but with `<ref>` as the base

Reject genuinely conflicting target selectors rather than guessing. If there
is no meaningful change to review, say so succinctly and stop.

### Selecting the depth

`--depth=<local|context|history|deep>`, default `context`.

- `local` — the diff plus the minimum nearby code needed to read it.
- `context` (default) — whatever current code is relevant: containing files,
  definitions, types, callers/callees, interfaces, related tests, relevant
  state/data flow, directly involved config or schema. Expand only because a
  concrete review question requires it; do not browse arbitrarily.
- `history` — everything in `context`, plus targeted Git history when it
  explains intent or establishes whether a suspected regression is real
  (`git log`, blame, prior versions, `git log -S`/`-G`). History is evidence,
  not ritual.
- `deep` — a broader investigation when warranted: wider repository
  interactions, focused builds/tests/static analysis, small reproductions.
  Still optimize for signal; `deep` is not "inspect everything."

## Process

**1. Establish intent.** Determine what behavior the target intends to
change: changed behavioral surfaces, important contracts/invariants, behavior
that must stay unchanged, trust boundaries crossed. Do not emit this as
findings, and do not turn unclear intent into a finding.

**2. Build a small risk map.** From the actual change, pick the relevant
defect dimensions — e.g. control-flow/logic, boundary conditions, error
propagation, API/behavioral contracts, persistence/state transitions,
transactions, retries/idempotency, concurrency/races/deadlocks,
lifetime/ownership/resource cleanup, authorization/trust boundaries,
parsing/input validation, serialization/schema and backward compatibility,
external side effects, operational failure modes. Do not mechanically apply
every dimension to every change.

**3. Independent defect search.** Use parallel subagents where useful, with
complementary roles drawn from the risk map (e.g. correctness/contracts,
state/integration, concurrency/security, regression/tests) rather than
several identical generic reviewers. Their job is recall: generate plausible
candidates. They may inspect context per the selected depth. A candidate is
not yet a finding.

**4. Require a concrete failure scenario.** Every candidate must reduce to:
precondition/triggering state → execution path → incorrect observable result.
Reject vague statements like "this could cause a race." A defect need not fail
for all inputs; boundary cases, races, retries, malformed input, partial
failures, transaction ordering, and authorization relationships are all valid
when a concrete reachable failure path exists.

**5. Adversarial verification (mandatory).** For every candidate that might be
reported, run a separate verification pass — a subagent where practical.
Instruct it to assume the candidate is wrong and hunt for the strongest
counter-evidence: guards, caller guarantees, type guarantees, lifecycle
constraints, transaction semantics, tests, library/API semantics, unreachable
states, intentional behavior. Keep the candidate only if it survives. This is
the primary precision mechanism.

**6. Tools as evidence.** When the depth allows, run targeted checks to
confirm or refute a specific hypothesis — a focused test, `go test -race`,
`go vet`, `tsc`, `pytest`, a minimal reproduction — adapting to the
repository. Tool output is evidence, never an automatic finding. Do not dump
linter output; do not run expensive broad checks when a focused one answers
the question.

**7. Filter and deduplicate.** Before reporting, drop candidates that were
not independently substantiated, unrelated pre-existing defects, speculation,
and findings whose impact cannot be made concrete. Collapse duplicates: one
underlying defect is one finding even if it manifests in several places.

## What counts as a defect

Incorrect behavior; crashes/panics/exceptions; broken invariants; incorrect
state transitions; regressions; API/contract violations; data corruption or
loss; transactional defects; retry/idempotency failures; concurrency defects;
resource/lifetime leaks with a concrete consequence; security defects;
compatibility breakage; operational failures; tests that pass while failing to
exercise the behavior they claim.

Security defects are valid findings when discovered, but this command does not
replace a dedicated, higher-recall security review.

## Non-findings — suppress aggressively

Do **not** report: style, naming, or formatting; comment/documentation
quality; general cleanliness; "could be refactored"; speculative
extensibility; generic maintainability; missing tests merely because more
would be nice; lint output merely because a linter emitted it; unrelated
pre-existing bugs; vague risks without a concrete failure scenario; subjective
design preferences; instruction-file compliance; praise.

Report "missing test coverage" only when the absent or defective test is
itself part of demonstrating a concrete defect. Do not propose refactors
except as needed to explain a defect, and do not turn the review into an
implementation task.

## Precision standard

- If you cannot explain how the defect manifests, do not report it.
- If you cannot establish that the selected change introduces, exposes, or
  materially worsens it, do not report it.
- If evidence leaves the candidate genuinely ambiguous after verification,
  omit it.

Certainty across all inputs is not required — a concrete reachable failure
mode is sufficient.

## Severity

- `P0` — critical/catastrophic, needs immediate attention
- `P1` — significant correctness/security/operational defect
- `P2` — real but limited defect

Bias output toward P0/P1. Include P2 only when concrete and high-confidence.
Do not invent numeric confidence percentages.

## Output

Terminal only. For each finding:

```text
[P1] Short defect title
path/to/file.go:142-155

<Concise explanation: what condition triggers it, why the current code is
wrong, what observable consequence follows.>

Evidence:
- <specific evidence>
- <specific evidence>

Impact:
<concrete observable consequence>
```

Point the location at the changed code responsible for the defect where
possible. Avoid remediation sections and unsolicited patches; a short
corrective direction is acceptable only when needed to make the diagnosis
understandable — do not design or implement the fix.

If no validated defects remain, output exactly:

`No defects found.`

Optionally append a terse note of the reviewed target/depth when it helps the
user understand what was checked. Do not produce a ceremonial summary.

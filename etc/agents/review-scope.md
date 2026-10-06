# Review scope — shared target, depth, and read-only rules

## Read-only

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

Invariant: **reason globally, report locally.** Inspect surrounding code
freely, but never report unrelated pre-existing issues.

### Selecting the target

Parse intent from the command arguments. Determine the base branch sensibly
from local Git (upstream tracking ref, then the remote default branch); do
not assume `main`. Always use the **merge base**, not tip-to-tip.

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

- `local` — the diff plus the minimum nearby code needed to understand it.
- `context` (default) — whatever current code is relevant to the review
  question: containing files, definitions, types, callers/callees,
  interfaces, tests, state/data flow, directly involved configuration or
  schema.
- `history` — everything in `context`, plus targeted Git history when it
  establishes intent, prior behavior, or whether a pattern is deliberate
  (`git log`, blame, prior versions, `git log -S`/`-G`).
- `deep` — broader repository-level investigation when warranted: wider
  interactions and consumers, focused builds, tests, static analysis, or
  small reproductions.

Expand only because a concrete review question requires it; do not browse
arbitrarily. `deep` is not "inspect everything", and the target remains the
only source of findings.

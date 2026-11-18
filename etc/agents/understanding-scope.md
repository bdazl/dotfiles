# Understanding scope — shared target, evidence, and read-only rules

Used by the educational workflows (`explain`, `quiz`). Their goal is an
accurate mental model, not findings: there are no severities, no finding
filters, and pre-existing behavior is in scope whenever it explains the
target.

## Read-only

Have **zero side effects** on the repository and remote state. Never modify
files, create commits, stage, stash, check out, switch or reset branches,
or post anything remotely. Inspect other revisions with `git show
<rev>:<path>`, `git diff`, and `git log`, never by checking them out.

Prefer reading to running. Run code only when it answers a concrete
question that reading cannot, and only in a way that writes no files —
including ignored caches and build outputs (e.g. `python -B`). Compare
`git status --porcelain --ignored` before and after; if anything appeared,
tell the user rather than deleting it.

## Selecting the target

Parse intent from the arguments. A target is either a **change** or a
**topic**.

### Change targets

Determine the base branch from local Git (upstream tracking ref, then the
remote default branch via `refs/remotes/<remote>/HEAD`); do not assume
`main`. Always diff from the **merge base**, not tip-to-tip.

- default (no selector, no topic): current branch vs
  `git merge-base HEAD <base>`, **including staged and unstaged
  working-tree changes** and relevant untracked files
- `--working`: only uncommitted working-tree changes
- `--staged`: only staged changes
- `--commit <rev>`: a single commit
- `--range <a>..<b>`: an explicit revision range
- `--base <ref>`: default target, but with `<ref>` as the base

Reject genuinely conflicting selectors rather than guessing. If the base
cannot be determined, say which refs were tried and ask for `--base`.

If the selected change is empty, say so in one line, mention what was
compared (e.g. `feature-x` vs merge base with `origin/develop`, clean
tree), suggest a topic or an explicit selector, and stop.

### Topic targets

Remaining non-flag text is a topic: a concept, component, symbol, path, or
question about the existing system. Locate it by search (paths, symbol
definitions, documentation) before explaining. If it matches several
unrelated things, name the candidates and ask which one is meant; if it
matches nothing, say so and stop.

A topic combined with a change selector narrows the focus: explain or quiz
on that part of the change, using the topic to choose what matters.

## Investigation

Read beyond the diff or topic as far as understanding requires: definitions,
callers and callees, contracts, state and data flow, tests, configuration,
documentation, and project guidance. Use targeted history (`git log`,
blame, `git log -S`) when it establishes intent or prior behavior. Stop when
the model is grounded; do not browse arbitrarily.

`--deep` allows broader investigation: wider consumers, alternative paths,
edge cases, and history.

## Evidence

Every claim rests on what was read, and the explanation keeps three levels
distinct:

- **Verified** — read in code or observed by running it; cite `path:line`.
- **Intended** — stated by docs, comments, tests, commit messages, or names,
  but not confirmed in code.
- **Inferred** — a reasonable conclusion not directly established; mark it
  as such.

Do not present architecture, rationale, or history that the repository does
not support. When intent and implementation disagree, say so plainly.

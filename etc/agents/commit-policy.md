# Commit Policy

Repository instructions override this policy.

## Messages

- Write a title line only: no body and no trailers (no `Co-Authored-By`, no generated-by lines).
- Match the repository's log style, in formal English.

## Scope

- Keep commits atomic: one logical change per commit.
- Never amend a commit unless the user explicitly asks.
- Commit on the checked-out branch. Do not create a branch unless the user or the repository asks for one.
- Do not push or publish unless the user asks.

## Commit modes

- `auto` — commit each unit as soon as it is complete and checked. Never batch the units into commits at the end.
- `checkpoint` — at each commit point, stop and propose the commit title; the user inspects the change and commits.
- `manual` — do all the work in one pass and do not commit.

If neither the user nor the repository has set a mode, ask which mode to use before implementing, offering `auto` as the default.

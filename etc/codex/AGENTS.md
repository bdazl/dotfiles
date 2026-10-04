# Global Codex Guidance

## Communication and Editing

- Respond in Swedish when the user writes in Swedish; otherwise follow the user's language.
- Keep explanations concise, direct, and practical.
- Write code, comments, documentation, and commit messages in formal English.
- Follow repository-specific instructions and existing conventions.
- When suggesting editor or shell workflows, account for Vim modal editing and zsh vi mode.
- For Vim guidance, account for the comma leader and the Swedish `ö` and `ä` movement mappings when relevant.

## Policy Modules

Codex discovers this `AGENTS.md` automatically. It does not document Claude-style `@file` imports, so treat the entries below as task-scoped references: read a listed file before doing related work.

- `@commit-policy.md` — read before creating, amending, or publishing commits.
- `@implementation-policy.md` — read before planning or implementing code changes.

Add or remove entries here to compose the global policy set. Keep environment-specific policies in their own files and add them to this list when they should apply globally. Repository instructions are layered after global guidance and may add more specific rules.

## Reusable Workflows

- `$work` — guided exploration and alignment before planning or implementation.
- `$defect-review` — read-only, precision-first defect review.

Keep each Codex skill aligned with the corresponding command in `etc/claude/commands/`.

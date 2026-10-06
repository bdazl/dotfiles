---
name: design-review
description: Read-only architecture and code-design pressure test of a selected change. Use when the user invokes $design-review or asks for a focused design review.
---

# Design Review — architecture and code-design pressure test

Review the selected change for concrete design problems: misplaced responsibilities, harmful coupling, weak boundaries, conflicting ownership, poorly modeled state, leaky abstractions, and architectural erosion. Prioritize precision over coverage. Report only findings whose structural consequence can be explained concretely. Zero findings is a successful review.

This is a design review, not a defect hunt, style review, or invitation to rewrite code according to personal taste. Do not redesign the system; diagnose the design of the selected change.

Read `../../review-scope.md` before selecting the target. It defines the read-only constraints, target selectors, base resolution, and depth levels. Relevant context for design: module and subsystem boundaries, domain concepts, ownership of state and behavior, dependency direction, consumers, and existing abstractions. Never report unrelated pre-existing design debt.

## Core standard

Every finding must reduce to: structural condition → realistic pressure, use, or change → concrete consequence. For example: two components become authoritative for the same concept → either is changed independently → behavior and invariants diverge.

The current code need not already fail; that is the domain of `$defect-review`. Vague statements such as "tightly coupled", "could be cleaner", or "hard to maintain" are not sufficient.

## Review process

1. Establish design intent: the concepts and responsibilities the target introduces, changes, moves, or connects; relevant boundaries, invariants, state and lifecycle ownership, dependency direction, contracts, and orchestration vs. domain logic. Treat project guidance and existing architecture as evidence, not immutable law.
2. Build a small design map from the change, such as responsibility placement, boundaries, layering, coupling, abstraction leakage, API ownership, domain modeling and illegal states, sources of truth, state ownership, data-flow boundaries, or consistency with established patterns. Apply only relevant dimensions.
3. Identify realistic pressures evidenced by current code, tests, documentation, or history: another caller needs the same operation, a domain concept gains a state, a representation changes behind an abstraction, a second implementation is used, a workflow crosses the new boundary, or a neighboring feature performs the analogous operation. Do not invent future requirements to manufacture a finding.
4. Search independently for candidates from complementary perspectives, such as boundaries and responsibility, domain and state modeling, dependencies and abstractions, and API and consumer impact. Use parallel reviewers only when the review warrants them and the current environment permits delegation.
5. For each candidate, state what structural property the change introduces or worsens, what realistic condition pressures it, what must then know, coordinate, duplicate, or change that should not have to, and why that follows from the present structure. Reject candidates that end in subjective judgments.
6. Adversarially verify every candidate. Look for evidence that the responsibility belongs here, the dependency direction or exposed representation is intentional, an invariant prevents the problematic state, callers form one cohesive unit, an existing extension point handles the pressure, repository conventions define a different boundary, the duplicated concept has distinct semantics, or the pressure is speculative. Drop candidates that do not survive.
7. Trace the smallest realistic change that exposes each surviving problem: modules changing in lockstep, consumers depending on internal representation, duplicated branching on one domain distinction, state transitions with several owners, boundary-crossing calls, or bypassed abstractions. File count alone is not evidence.
8. Drop subjective preferences, speculative future-proofing, unrelated pre-existing debt, findings justified only by a named principle, cosmetic refactors, harmless duplication, concrete defects better suited to `$defect-review`, and duplicates. One underlying design problem is one finding.

## What counts as a design finding

Report responsibility across the wrong boundary, competing sources of truth, structurally ambiguous state or resource ownership, dependency direction that forces lower-level policy to know higher-level mechanism, domain logic unnecessarily coupled to transport, persistence, framework, or representation, internal representation in several consumers' effective contracts, abstractions mismatched to their semantic responsibility, one domain distinction encoded in several places, bypasses around an established boundary, unrelated concerns coupled so ordinary changes require coordination, APIs requiring callers to own invariants, or contradictory states that materially complicate consumers. The finding must be introduced, materially worsened, or made architecturally significant by the target.

Do not report naming, formatting, style, function or file size without a structural consequence, methodology preferences, extraction opportunities, harmless duplication, "could be more generic", speculative extensibility, generic testability or maintainability, documentation, consistency complaints without architectural consequence, unrelated pre-existing debt, or praise. Do not enforce patterns; evaluate consequences.

Mention a correctness defect only when it is necessary evidence for a design finding.

## Priority

- `D1`: significant structural problem affecting an important boundary, ownership model, domain concept, or dependency relationship, likely to cause repeated or cross-cutting design cost.
- `D2`: localized but concrete problem with meaningful change amplification, leakage, duplication, or coordination cost.

There is no low-priority category. Omit a finding rather than downgrade it into a nit.

## Output

For each finding, use:

```text
[D1] Short design finding
path/to/file:line

<Structural condition and why it is problematic.>

Pressure:
<realistic use or change that exposes the problem>

Evidence:
- <specific repository evidence>
- <specific repository evidence>

Consequence:
<what becomes coupled, duplicated, exposed, coordinated, or hard to change>
```

Point to the changed code that introduces or materially worsens the structure when possible. Do not provide a replacement architecture or patch; a short corrective direction is acceptable only when needed to make the diagnosis clear. If no validated design findings remain, output exactly:

`No design findings.`

Optionally add a terse note describing the target and depth when that helps the user understand the review.

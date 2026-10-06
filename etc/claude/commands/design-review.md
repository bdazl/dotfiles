# Design Review — architecture and code-design pressure test

Review the selected change for concrete design problems: misplaced
responsibilities, harmful coupling, weak boundaries, conflicting ownership,
poorly modeled state, leaky abstractions, and architectural erosion.

Prioritize precision over coverage. Report only findings whose structural
consequence can be explained concretely.

Arguments: $ARGUMENTS

This is a **read-only** analysis. A review that finds zero design problems is
fully successful. This is a design review, not a defect hunt, style review,
or invitation to rewrite code according to personal taste.

@~/.claude/review-scope.md

Relevant context for design: module and subsystem boundaries, domain
concepts, ownership of state and behavior, dependency direction, consumers,
and existing abstractions. Never report unrelated pre-existing design debt.

Do not redesign the system. Diagnose the design of the selected change.

## Core standard

A design finding must identify a **concrete structural consequence**.

Reduce every candidate to:

**structural condition → realistic pressure/use/change → concrete consequence**

Examples:

- two components become authoritative for the same concept
  → either may be changed independently
  → behavior and invariants can diverge

- a domain operation depends directly on transport-layer representation
  → another transport or caller needs the same operation
  → transport knowledge must be duplicated or propagated inward

- lifecycle ownership is split between unrelated components
  → an ordinary new exit path is added
  → cleanup/state transition correctness must be coordinated across both

- several consumers must know the internal representation of one module
  → that representation changes
  → unrelated consumers must change together

Do not require that the current code already fails. That is the domain of
`/defect-review`.

But a vague statement such as "this is tightly coupled", "this abstraction
could be cleaner", or "this may become hard to maintain" is not sufficient.

## Process

**1. Establish design intent.**

Determine what concepts and responsibilities the target introduces, changes,
moves, or connects.

Identify:

- relevant subsystem/module boundaries
- domain concepts and invariants
- ownership of state and behavior
- dependency direction
- public and internal contracts
- lifecycle/resource ownership
- orchestration vs. domain logic
- representation vs. abstraction boundaries

Use project guidance and existing architecture as evidence, not as immutable
law.

**2. Build a small design map.**

From the actual change, identify only the relevant design dimensions, such as:

- responsibility placement and cohesion
- module/subsystem boundaries
- dependency direction and layering
- coupling and change amplification
- abstraction quality and leakage
- API shape and semantic ownership
- domain modeling and illegal states
- sources of truth and duplicated concepts
- state ownership and lifecycle
- data flow and transformation boundaries
- orchestration vs. policy
- extension mechanisms already exercised by the system
- consistency with established architectural patterns

Do not mechanically apply every dimension.

**3. Identify realistic design pressures.**

Ask how the changed design behaves under pressures that already exist or are
directly implied by the codebase:

- another existing caller needs the same operation
- an established domain concept gains another state
- a representation changes behind an abstraction
- a second implementation of an existing interface is used
- an existing workflow crosses the new boundary
- error/state/lifecycle handling follows another ordinary path
- a neighboring feature performs the analogous operation

Prefer pressures evidenced by current code, tests, documentation, or history.

Do not invent hypothetical future requirements merely to manufacture a
finding.

**4. Independent design search.**

Use parallel subagents where useful, with complementary roles rather than
several generic reviewers. Suitable perspectives include:

- boundaries and responsibility
- domain/state modeling
- dependencies and abstractions
- API and consumer impact

Their job is candidate generation. A candidate is not yet a finding.

**5. Require a concrete consequence.**

For every candidate, explain:

1. what structural property the selected change introduces or worsens,
2. what realistic condition puts pressure on it,
3. what code or subsystem must then know, coordinate, duplicate, or change
   that should not have to,
4. why that consequence follows from the present structure.

Reject candidates that terminate in subjective statements such as
"less elegant", "not clean", or "harder to maintain" without explaining the
actual change burden or boundary violation.

**6. Adversarial verification (mandatory).**

For every candidate that might be reported, run a separate verification pass
where practical.

Assume the candidate is wrong and look for the strongest counter-evidence:

- the responsibility genuinely belongs here
- the dependency direction is intentional
- the abstraction deliberately exposes this representation
- the domain invariant makes the supposedly problematic state impossible
- callers are intentionally coupled because they form one cohesive unit
- an existing extension point already handles the pressure cleanly
- repository conventions establish a different architectural boundary
- the alleged duplicated concept actually represents distinct semantics
- the pressure is speculative rather than realistic

Keep the candidate only if it survives.

**7. Check change amplification.**

For surviving candidates, trace the smallest realistic change that exposes
the design problem.

Prefer concrete evidence such as:

- multiple modules that must change in lockstep
- consumers depending on internal representation
- duplicated branching on the same domain distinction
- state transitions coordinated by several owners
- boundary-crossing imports or calls
- repeated translation of the same semantic concept
- abstractions bypassed by the new code

The number of affected files alone is not evidence. Some concepts are
inherently cross-cutting.

**8. Filter and deduplicate.**

Before reporting, remove:

- subjective preferences
- speculative future-proofing
- unrelated pre-existing design debt
- findings justified only by a named design principle
- cosmetic refactors
- abstraction for abstraction's sake
- duplication with no semantic or change-cost consequence
- candidates that merely describe a concrete defect better suited to
  `/defect-review`
- duplicates arising from one underlying structural issue

One underlying design problem is one finding.

## What counts as a design finding

Examples include:

- responsibility placed across the wrong architectural boundary
- one concept having multiple competing sources of truth
- state or resource ownership being structurally ambiguous
- a dependency direction that forces lower-level policy to know about
  higher-level mechanism
- domain logic coupled unnecessarily to transport, persistence, framework,
  or representation details
- a supposedly internal representation becoming part of several consumers'
  effective contracts
- an abstraction whose interface does not match the semantic responsibility
  it owns
- the same domain distinction being independently encoded in multiple places
- a change introducing architectural bypasses around an established boundary
- unrelated concerns being coupled such that ordinary changes require
  coordinated modification
- an API requiring callers to understand invariants that should be owned
  behind the API
- invalid or contradictory states becoming representable in a way that
  materially complicates consumers

The finding must be attributable to the selected change: introduced,
materially worsened, or made architecturally significant by it.

## Non-findings — suppress aggressively

Do **not** report:

- naming, formatting, or style
- "this function is too long" without a structural consequence
- "this file has many responsibilities" without showing conflicting change
  axes or boundaries
- preference for interfaces over concrete types
- preference for composition, inheritance, dependency injection, functional
  style, DDD, hexagonal architecture, clean architecture, or any other
  methodology merely because the methodology says so
- extraction opportunities
- DRY violations where independent duplication is harmless
- "could be more generic"
- speculative extensibility
- abstractions for hypothetical future implementations
- generic testability concerns
- generic maintainability concerns
- missing comments or documentation
- consistency complaints with no architectural consequence
- unrelated pre-existing design debt
- praise

Do not enforce patterns. Evaluate consequences.

## Defects discovered during the review

A concrete correctness bug may become apparent while investigating design.

Do not turn this command into `/defect-review`. Mention a defect only when it
is necessary evidence for a design finding.

If the bug is independently important but not evidence of the design issue,
leave it out.

## Priority

- `D1` — significant structural problem affecting an important boundary,
  ownership model, domain concept, or dependency relationship; likely to
  cause repeated or cross-cutting design cost
- `D2` — localized but concrete design problem with meaningful change
  amplification, leakage, duplication, or coordination cost

There is intentionally no low-priority category for minor cleanup.

A finding should generally be omitted rather than downgraded into a nit.

## Output

Terminal only. For each finding:

```text
[D1] Short design finding
path/to/primary/file.go:142-155

<Concise explanation of the structural condition and why it is problematic.>

Pressure:
<realistic use/change that exposes the design problem>

Evidence:
- <specific repository evidence>
- <specific repository evidence>

Consequence:
<what becomes coupled, duplicated, exposed, coordinated, or difficult to
change, stated concretely>

Point the location at the changed code that introduces or materially worsens
the structure where possible.

Do not provide a replacement architecture or unsolicited patch. A short
corrective direction is acceptable only when necessary to make the diagnosis
clear.

If no validated design findings remain, output exactly:
No design findings.

Optionally append a terse note of the reviewed target/depth when it helps the
user understand what was checked. Do not produce a ceremonial summary.
```

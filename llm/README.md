# LLM Prompts

This folder contains prompt templates and shared string mappings for agents and LLMs.

## Layout

- `llm/prompt/`: prompt templates.
- `llm/strings.yml`: optional mappings for `{{var}}` substitutions.

## Template syntax

- `{{var}}` uses `llm/strings.yml`.
- `[[var]]` is a free variable provided on the command line.

## Using bin/llmp

Examples:

- Render a prompt:
  - `llmp save`
- Render a prompt (explicit):
  - `llmp render save`
- Render a nested prompt:
  - `llmp katalog/sammanfatta`
- List available templates:
  - `llmp list` (alias: `llmp ls`)
- List defined strings (keys and raw values):
  - `llmp strings`
- List defined string keys only:
  - `llmp strings -k`
- List defined string values only:
  - `llmp strings -v`
- List defined strings with expanded values:
  - `llmp strings -e`
- List free variables in a prompt:
  - `llmp vars katalog/granska` (alias: `llmp free katalog/granska`)
- Substitute a free variable:
- `llmp -s diff:"$(git diff)" katalog/granska`
- Substitute from a file:
  - `llmp -f source:notes.md katalog/sammanfatta`
- Use an alternate root directory:
  - `llmp -r ~/notes/llm save`

## llm/strings.yml

You can define top-level string mappings. The file is optional.

Substitutions inside values:

- `$(...)` runs a shell command and inserts stdout.
- `${ENV}` inserts the environment variable value (empty string if missing).
- Escape a literal `$` as `\\$`.

Example:

```yaml
repo-name: "etc"
cwd: "$(pwd)"
filesys-datetime: "$(date +%Y%m%d_%H%M%S)"
user-home: "${HOME}"
mixed: "Hej: $(date +%Y-%m-%d) in ${PWD}"
```

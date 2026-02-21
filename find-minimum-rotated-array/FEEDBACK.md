# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 05:10 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files.

**What the issue was:** The parameter format for `mcporter call` was unclear. I tried several approaches:
1. JSON format: `'{"file_path": "/path"}'` - Did not work
2. Different path formats (with/without home directory expansion) - All returned "File not found"
3. Using `--code` flag: `--code 'function ...'` - Interpreted as literal code starting with `--code`

The working format was: `mcporter call xano validate_xanoscript file_path: '/path/to/file.xs'`

**Why it was an issue:** The documentation shows JSON-style parameters but the actual working syntax is different. This caused significant confusion and trial-and-error.

**Potential solution:** Update the mcporter help/examples to clearly show the correct parameter passing syntax. The current `Examples:` section shows `file_path: "/path/to/file.md"` format but it's easy to miss.

---

## [2026-02-21 05:15 PST] - xanoscript_docs Returns Same Generic Content

**What I was trying to do:** Get specific documentation for topics like `quickstart`, `functions`, `run`, and `syntax`.

**What the issue was:** All calls to `xanoscript_docs` with different topics returned the same generic documentation about workspace structure and file naming conventions, not the specific syntax details I needed.

**Why it was an issue:** I couldn't get detailed syntax documentation for:
- How to write loops (while/for)
- Conditional syntax details
- Variable declaration patterns
- How run jobs call functions

I had to rely on reading existing implementations in `~/xs/` to understand the patterns.

**Potential solution:** Either:
1. Fix the topic-based documentation to return specific content for each topic
2. Provide a comprehensive syntax reference that covers all language constructs
3. Include more inline examples in the generic documentation

---

## [2026-02-21 05:20 PST] - Stack Block Cannot Be Empty

**What I was trying to do:** Test a minimal function to understand the validation format.

**What the issue was:** When I wrote `stack { }` (empty stack block), the validator returned:
```
Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '}'
```

**Why it was an issue:** The error message is confusing - it mentions "NewlineToken" and "iteration" which doesn't clearly communicate "stack block cannot be empty."

**Potential solution:** Improve the error message to something like: "Stack block cannot be empty. Add at least one variable declaration, operation, or comment."

---

## [2026-02-21 05:25 PST] - Run Job Documentation Missing

**What I was trying to do:** Understand the exact syntax for run jobs and how they call functions.

**What the issue was:** The documentation mentions `run.job` construct but doesn't provide clear examples of:
- The exact syntax for `main = { name: "...", input: { ... } }`
- Whether quotes are needed around keys
- Whether `function.run` is an explicit call or implicit via `main`

I found two different patterns in existing code:
1. `main = { name: "...", input: { ... } }` (used in most examples)
2. Some might use `function.run` explicitly

**Why it was an issue:** Unclear which pattern is correct/preferred.

**Potential solution:** Add a dedicated `run` topic to `xanoscript_docs` that specifically covers:
- Run job syntax
- How to call functions from run jobs
- Input/output handling in run context

---

## General Observations

1. **MCP tools are useful but documentation is fragmented** - Had to rely heavily on existing code examples rather than documentation.

2. **Validation tool works well** - Once I figured out the correct syntax, the validation provided clear, actionable error messages with line/column numbers.

3. **Language is intuitive** - XanoScript syntax for variables, conditionals, and loops was easy to pick up from examples.

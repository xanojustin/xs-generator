# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 04:33 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Check if an array is empty using `$input.days|count == 0`

**What the issue was:** The validator rejected the expression with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** I initially wrote `if ($input.days|count == 0)` which seems natural, but XanoScript requires parentheses around the filtered expression when comparing: `(($input.days|count) == 0)`

**Potential solution:** The error message was actually quite helpful and the fix was straightforward. However, it might be worth documenting this pattern more explicitly in the essentials guide as it's a common pattern (checking array length).

---

## [2025-02-27 04:30 PST] - MCP Tool Parameter Discovery

**What I was trying to do:** Call the `validate_xanoscript` tool on the Xano MCP

**What the issue was:** I initially tried several parameter formats that didn't work:
- `{files: [...]}` - wrong parameter name
- JSON with `~` paths - paths need to be absolute
- Various quoting approaches with mcporter

**Why it was an issue:** I had to guess the correct parameter format. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" helped, but I had to try multiple approaches before finding that `--args '{"file_paths": [...]}'` worked with mcporter.

**Potential solution:** Having a simple tool listing or schema view in mcporter would help. Something like `mcporter describe xano.validate_xanoscript` to see expected parameters.

---

## [2025-02-27 04:30 PST] - Documentation Topic Gaps

**What I was trying to do:** Get specific documentation for `run` jobs and the `run.job` construct

**What the issue was:** Calling `xanoscript_docs({ topic: "run" })` returned the generic documentation index instead of specific run job syntax

**Why it was an issue:** I had to infer the `run.job` syntax by looking at existing implementations in the `~/xs/` directory rather than having official documentation

**Potential solution:** Add specific documentation for the `run` topic that covers:
- `run.job` construct syntax
- The `main = { name: ..., input: ... }` pattern
- How run jobs invoke functions
- Examples of run job configurations

---

## [2025-02-27 04:35 PST] - Boolean Type Suggestion

**What I was trying to do:** Create boolean variables for the travel day lookup array

**What the issue was:** The validator suggested using `bool` instead of `boolean`, which I actually did correctly, but it made me double-check

**Why it was an issue:** Minor confusion - the suggestion appeared even though I wasn't using `boolean` (the invalid type). It might be a generic suggestion that always appears.

**Potential solution:** Only show type suggestions when the user actually uses the wrong type name, not on every validation.

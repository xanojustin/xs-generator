# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 16:32 PST] - Reserved Variable Error Not Clear

**What I was trying to do:** Create a function that modifies a linked list structure by updating nodes

**What the issue was:** I initially tried to use `var $input.nodes { value = $nodes }` to update the input nodes array after modifications. This caused a cryptic parser error:
```
[Line 57, Column 17] Expecting: one of these possible Token sequences:
  1. [$]
  2. [$api_baseurl]
  ...
  17. [.]
but found: '$input'
```

**Why it was an issue:** The error message lists expected tokens but doesn't clearly state that `$input` is a reserved variable that cannot be reassigned or used as a prefix for variable names. It took me a moment to realize that `$input` itself is reserved, not just that I had a syntax error.

**Potential solution (if known):** 
- The error message could explicitly say: `"$input is a reserved variable name and cannot be used as a variable prefix. Try using a different variable name like $my_nodes instead.`"
- The hint at the bottom is helpful but could appear earlier in the error

---

## [2026-03-02 16:35 PST] - mcporter Parameter Passing Syntax Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter

**What the issue was:** I initially tried several formats that didn't work:
- `mcporter call xano validate_xanoscript '{"file_path": "run.xs"}'` - JSON didn't work
- `mcporter call xano.validate_xanoscript file_path="run.xs"` - selector with dot worked but needed full path

The error "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was confusing because I was passing parameters but they weren't being received.

**Why it was an issue:** The documentation shows JSON format but the CLI actually expects key=value format. Also, relative paths don't work - need absolute paths.

**Potential solution (if known):**
- Document that `mcporter call` uses `key=value` syntax, not JSON
- Clarify that file paths must be absolute, not relative
- The error could suggest using absolute paths when a file isn't found

---

## [2026-03-02 16:30 PST] - Documentation Topics All Return Same Content

**What I was trying to do:** Get specific documentation on functions, essentials, and run topics

**What the issue was:** Calling `xanoscript_docs` with topics `functions`, `essentials`, and `run` all returned the same general README content instead of topic-specific documentation.

**Why it was an issue:** I needed specific syntax examples for run jobs and functions but kept getting the same overview documentation. This made it harder to understand the exact syntax patterns.

**Potential solution (if known):**
- Ensure topic-specific documentation actually returns different content
- Consider adding code examples specific to each topic (e.g., complete run.job examples for the 'run' topic)

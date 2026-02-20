# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 21:32 PST] - First attempt passed unexpectedly

**What I was trying to do:** Create a recursive flatten function that uses `function.run` to call itself for nested arrays.

**What the issue was:** Actually, there was no issue. The code passed validation on the first attempt.

**Why it was an issue:** This was surprising because I expected to need several iterations to get the syntax right, especially for:
1. The recursive `function.run` call syntax
2. Array concatenation with `~`
3. The `is_array` filter usage
4. Proper input/output handling

**Potential solution (if known):** None needed - the MCP validation worked well and the documentation was sufficient.

---

## [2026-02-19 21:33 PST] - Documentation was very helpful

**What I was trying to do:** Understand the correct syntax for XanoScript constructs.

**What the issue was:** None - the `xanoscript_docs` tool with `mode=quick_reference` provided exactly what I needed.

**Why it was an issue:** N/A - this is positive feedback. The quick reference mode was concise and contained the key patterns.

**Potential solution (if known):** Continue providing the quick_reference mode - it's efficient for context window usage.

---

## [2026-02-19 21:34 PST] - run.job main syntax could be clearer in docs

**What I was trying to do:** Understand the exact syntax for the `main` block in `run.job`.

**What the issue was:** The documentation showed examples but I had to infer that `input:` takes an object with the actual input parameters.

**Why it was an issue:** Minor confusion about whether to use `input: { nested_array: ... }` vs `input.nested_array: ...`

**Potential solution (if known):** The docs could explicitly show the structure: `main.input.<param_name>` maps to the function's input block parameter names.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 02:35 PST] - MCP Parameter Passing Documentation Gap

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths to validate my XanoScript code.

**What the issue was:** The MCP tool description showed `file_paths` as a JSON array parameter, but passing it via mcporter's CLI was non-obvious. Multiple attempts with different JSON formatting failed:
- `'{"file_paths": ["path1", "path2"]}'` - Failed, said parameter was required
- Using `--params` flag - Tool returned "Unknown topic" error (wrong parameter name)

**Why it was an issue:** I had to try 4+ different syntax variations before finding the working pattern: `directory="/path/to/dir"`. This wasted time and was frustrating.

**Potential solution:** 
1. Add clear CLI examples in the tool description showing the exact mcporter syntax
2. The `file_paths` array parameter should have working examples for mcporter CLI specifically
3. Consider accepting a simpler comma-separated string for file_paths in the CLI context

---

## [2025-02-20 02:30 PST] - Documentation Index Returns Same Content for All Topics

**What I was trying to do:** Get detailed XanoScript syntax documentation by calling `xanoscript_docs` with different topics like "quickstart", "syntax", "functions", and "run".

**What the issue was:** Every topic I requested returned the same high-level index/overview content instead of the specific detailed documentation for that topic. The topics listed in the index (like `syntax`, `quickstart`, `functions`) all returned identical content with just the documentation index table.

**Why it was an issue:** I was expecting to get specific syntax patterns for:
- How to write `run.job` constructs
- How to call functions from run jobs using `function.run` or `main = { name: ... }` syntax
- Conditional statements and loop patterns
- Available filters like `bitwise_and`

Instead, I had to look at existing implementations in `~/xs/` to infer the correct syntax patterns.

**Potential solution:**
1. Ensure the topic parameter actually returns specific content for each topic
2. If the MCP can't return detailed docs, consider removing the topic parameter and directing users to look at examples
3. Add a `mode=quick_reference` example that actually returns concise syntax patterns

---

## [2025-02-20 02:32 PST] - No Clear Guidance on Bitwise Operations

**What I was trying to do:** Implement a bit manipulation solution for the power-of-two exercise using the pattern `n & (n - 1) == 0`.

**What the issue was:** I couldn't find documentation on how to perform bitwise AND operations in XanoScript. I guessed that a filter like `bitwise_and` might exist, but had no confirmation.

**Why it was an issue:** I had to just try the syntax and hope the validator would catch it if wrong. This is risky for less obvious operations.

**Potential solution:**
1. Add a "operators" or "math" topic to xanoscript_docs covering arithmetic, bitwise, and logical operators
2. Include common filter functions reference

---

## Summary

The Xano MCP works well for validation (once you figure out the CLI syntax), but the documentation retrieval (`xanoscript_docs`) was not helpful for getting specific syntax guidance. I relied entirely on reading existing implementations from previous exercises to understand the correct patterns.

The validation tool is the most useful part - it caught no errors in my initial implementation, which gives confidence that the syntax I inferred from examples was correct.

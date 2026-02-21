# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 07:05 PST] - MCP Tool Discovery and Validation Syntax

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** 
1. Initially unclear how to properly invoke the validation tool via mcporter CLI
2. Multiple attempts with different argument formats failed:
   - `mcporter call xano validate_xanoscript '{"files": [...]}'` - JSON format not accepted
   - `mcporter call xano validate_xanoscript --file_paths '...'` - flag syntax not accepted
   - `mcporter call xano validate_xanoscript file_path=...` - key=value without server.tool format

3. Eventually discovered the correct format is: `mcporter call xano.validate_xanoscript directory=/path/to/dir`

**Why it was an issue:** The mcporter CLI syntax is not intuitive. The help shows `mcporter call <selector> [key=value ...]` but it wasn't clear that `<selector>` should be `server.tool` format, and the examples in the tool schema use JSON parameters which don't translate directly to CLI key=value format.

**Potential solution (if known):** 
- Add more CLI examples to the tool documentation showing the key=value format
- Consider supporting JSON input via stdin or a `--json` flag for complex parameters like arrays

---

## [2025-02-21 07:08 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Compare string lengths using the `strlen` filter in a conditional expression

**What the issue was:** The expression `if ($input.s|strlen != $input.t|strlen)` failed validation with error: "An expression should be wrapped in parentheses when combining filters and tests"

The fix required wrapping each filtered expression in parentheses: `if (($input.s|strlen) != ($input.t|strlen))`

**Why it was an issue:** This syntax requirement wasn't obvious from the documentation or examples. The error message was helpful in pointing to the solution, but it's easy to forget this rule when writing complex expressions.

**Potential solution (if known):**
- Add a specific code example to the quickstart docs showing filter expressions in conditionals
- Consider mentioning this in a "common pitfalls" or "common mistakes" section

---

## [2025-02-21 07:10 PST] - Documentation Topic Redirection

**What I was trying to do:** Get specific XanoScript documentation on the `run` topic for run job syntax

**What the issue was:** Calling `xanoscript_docs({ topic: "run" })` returned the same general index/documentation overview page instead of specific documentation about run jobs.

**Why it was an issue:** Expected topic-specific documentation but received the general index. This made it difficult to verify the exact syntax for `run.job` constructs.

**Potential solution (if known):**
- Ensure topic-specific queries return relevant content
- If a topic doesn't have specific content, return a "not found" message rather than the index
- Consider adding more detailed run job examples to the documentation

---

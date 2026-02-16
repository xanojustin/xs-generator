# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 17:20 PST] - Object vs JSON Type Confusion

**What I was trying to do:**
Create a function input parameter for arbitrary key-value properties (event properties for PostHog analytics).

**What the issue was:**
Used `object properties?` thinking it would accept any object/dictionary structure. Got a validation error: "[Line 6, Column 26] Expecting: expecting at least one iteration which starts with one of these possible Token sequences: <[NewlineToken]> but found: 'description'"

**Why it was an issue:**
The error message was cryptic and didn't clearly indicate that `object` type requires a `schema` block. I thought `object` was for arbitrary objects like in TypeScript/JavaScript.

**Potential solution:**
- Better error message: "Object type requires a schema block. Use 'json' type for arbitrary JSON objects."
- Documentation could highlight the difference between `object` (structured with schema) vs `json` (arbitrary JSON)

---

## [2026-02-15 17:20 PST] - Validate Tool Requires Code Parameter

**What I was trying to do:**
Validate .xs files using the MCP validate_xanoscript tool.

**What the issue was:**
Initially tried to use `file_path` parameter like: `mcporter call xano.validate_xanoscript file_path="/path/to/file.xs"`

Got error: "Error: 'code' parameter is required"

**Why it was an issue:**
Had to read the file content and pass it as the `code` parameter instead. This is less convenient than passing a file path directly.

**Potential solution:**
- Support both `file_path` and `code` parameters
- Or at least provide a clearer error message: "Use 'code' parameter with file contents, not 'file_path'"

---

## [2026-02-15 17:20 PST] - JSON Escaping Issues with CLI Validation

**What I was trying to do:**
Pass XanoScript code containing quotes and special characters to the validate tool via CLI.

**What the issue was:**
Had to use complex escaping: `CODE=$(cat file.xs) && mcporter call xano.validate_xanoscript --args "{\"code\": $(echo "$CODE" | jq -Rs .)}"`

**Why it was an issue:**
The --args JSON format makes it difficult to pass multi-line code strings with quotes. Had to use jq to properly escape.

**Potential solution:**
- Support file path validation directly (see above)
- Or provide a CLI wrapper that handles file reading: `mcporter call xano.validate_xanoscript --file /path/to/file.xs`

---

## [2026-02-15 17:22 PST] - Positive Feedback

**What worked well:**
- The xanoscript_docs tool is excellent - comprehensive and well-organized
- The error messages include line/column numbers which is very helpful
- The quickstart documentation has great common patterns
- The run.job/run.service documentation was clear and complete

---

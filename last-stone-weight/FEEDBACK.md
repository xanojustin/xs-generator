# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 11:05 PST] - MCP Parameter Naming Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The MCP schema shows parameters with underscores (`file_path`), but the mcporter CLI requires JSON args format to pass them correctly. Using `file-path=` (kebab-case) didn't work - the server responded with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** It took multiple attempts to figure out the correct way to pass parameters:
1. First tried `file="run.xs"` - wrong parameter name
2. Then tried `file-path="run.xs"` - CLI didn't convert properly
3. Finally worked with `--args '{"file_path": "/absolute/path"}'`

**Potential solution:** The mcporter CLI could automatically convert kebab-case flags to snake_case for the JSON payload, or the error message could suggest using `--args` for JSON parameters.

---

## [2025-02-26 11:05 PST] - Relative Path Resolution

**What I was trying to do:** Validate files using relative paths from the current directory

**What the issue was:** The validator couldn't find files when using relative paths like `"run.xs"` or `"function/last_stone_weight.xs"` even when running from the correct directory

**Why it was an issue:** Had to use absolute paths (`/Users/justinalbrecht/xs/last-stone-weight/run.xs`) for validation to work

**Potential solution:** The MCP server could resolve relative paths against the current working directory, or the documentation could explicitly mention that absolute paths are required.

---

## [2025-02-26 11:00 PST] - Documentation Discovery

**What I was trying to do:** Find the correct XanoScript syntax for run jobs and functions

**What the issue was:** The `xanoscript_docs` tool is very helpful but requires knowing what topics exist. The topic list is extensive but I had to call it multiple times to find what I needed.

**Why it was an issue:** Initially wasn't clear which topics contained what information. The overview helped, but a more prominent "start here" or quick reference guide would be useful.

**Potential solution:** A `topic: "cheatsheet"` or `topic: "quickstart"` that gives the most commonly needed patterns in one place would be valuable for AI coding tasks.

---

## [2025-02-26 11:00 PST] - Array Filter Documentation

**What I was trying to do:** Find the correct syntax for array operations (slice, merge for removing elements)

**What the issue was:** The documentation correctly shows `|slice:offset:length` but it took time to understand that this means "skip N elements, return M elements" rather than "from index A to index B"

**Why it was an issue:** Mental model from other languages (Python, JavaScript) has slice as start:end, but XanoScript uses offset:length

**Potential solution:** The docs are actually clear on this - more of a user mental model issue. The example `[10,20,30,40]|slice:1:2` → `[20,30]` helps clarify.

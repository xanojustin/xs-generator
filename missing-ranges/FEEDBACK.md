# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-25 15:35 PST - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter to validate my XanoScript files.

**What the issue was:** The parameter format for mcporter was unclear. I initially tried:
- `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` - Error: parameter required
- `mcporter call xano.validate_xanoscript '{"file_paths": [...]}'` - Same error
- Finally worked with: `mcporter call xano.validate_xanoscript file_paths='[...]'`

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" appeared even when I was passing these parameters. The issue was the format - mcporter expects `key='value'` format, not JSON.

**Potential solution:** Include examples in the mcporter tool documentation showing the exact format for passing parameters, especially for array parameters like `file_paths`.

---

## 2025-02-25 15:37 PST - Filter Name Inconsistency

**What I was trying to do:** Get the length/count of an array in XanoScript.

**What the issue was:** I used `|length` (common in many languages like JavaScript, PHP, Python) but XanoScript uses `|count` for arrays. The error message "Unknown filter function 'length'" was clear, but I had to look up the correct filter name.

**Why it was an issue:** `length` is a very common property name across many programming languages. Having to remember that XanoScript uses `count` for arrays and `strlen` for strings creates cognitive overhead.

**Potential solution:** 
1. Consider aliasing `length` to `count` for arrays to match developer expectations from other languages
2. Or improve the error message to say: "Unknown filter function 'length'. Did you mean 'count' for arrays or 'strlen' for strings?"

---

## 2025-02-25 15:38 PST - Filter Precedence and Parentheses Requirement

**What I was trying to do:** Concatenate filtered values: `$range_start|to_text ~ "->" ~ $range_end|to_text`

**What the issue was:** Got error "An expression should be wrapped in parentheses when combining filters and tests". The fix was to wrap each filtered expression: `($range_start|to_text) ~ "->" ~ ($range_end|to_text)`

**Why it was an issue:** This is a subtle syntax rule that's easy to forget. The error message was helpful and pointed directly to the issue, but it's a common pattern (string concatenation after filtering) that requires extra boilerplate.

**Potential solution:** The error message is already good, but perhaps the syntax could be more forgiving here since the intent is clear. Alternatively, documenting this prominently in the quickstart would help.

---

## 2025-02-25 15:40 PST - Documentation Response Consistency

**What I was trying to do:** Get specific documentation for `functions` and `tasks` topics.

**What the issue was:** Calling `xanoscript_docs({ topic: "functions" })` and `xanoscript_docs({ topic: "tasks" })` both returned the same general README overview instead of topic-specific documentation.

**Why it was an issue:** I needed specific syntax details for functions and tasks, but got the same general documentation twice. I had to look at existing exercise files to understand the exact syntax.

**Potential solution:** Ensure the topic parameter actually returns topic-specific documentation, or update the documentation index to indicate which topics are currently implemented.

---

## 2025-02-25 15:42 PST - Run Job Syntax Discovery

**What I was trying to do:** Understand the exact syntax for `run.job` constructs.

**What the issue was:** The documentation mentions `task/{name}.xs` for scheduled jobs but doesn't clearly document the `run.job` syntax used in the exercises. I had to examine existing exercise files to understand:
- The `run.job "Name" { main = { name: "...", input: {...} } }` structure
- That `function.run` is implicit in the `main` block

**Why it was an issue:** The `run.job` syntax is specific to these exercises but not clearly documented in the MCP. The documentation index shows `run` as a topic but `xanoscript_docs({ topic: "run" })` wasn't returning specific run job syntax.

**Potential solution:** Ensure the `run` topic documentation includes the complete `run.job` syntax with examples of calling functions via `main = { name: "...", input: {...} }`.

---

## General Observations

**What worked well:**
- The validation tool is excellent - gives clear line/column numbers and helpful suggestions
- The syntax quick reference (when I finally accessed it) was very useful
- The error messages are generally descriptive

**Areas for improvement:**
1. More consistent topic-specific documentation responses
2. Consider common language aliases for filters (`length` → `count`)
3. Clearer mcporter parameter format documentation
4. Complete `run.job` syntax documentation

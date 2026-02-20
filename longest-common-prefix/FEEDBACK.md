# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 19:32 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Write a while loop condition that checks array length using a filter

**What the issue was:** The validator rejected code like:
```xs
while ($i < $input.strings|count && $prefix|strlen > 0) {
```

The error message was: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** It's not intuitive that `$input.strings|count` needs parentheses when used in a comparison expression. The error appeared multiple times for similar patterns.

**Potential solution:** Either:
1. Better error messaging showing the exact fix (e.g., "Wrap ($input.strings|count) in parentheses")
2. Allow filter expressions without parentheses in simple comparisons
3. Document this requirement more prominently in the quickstart guide

---

## [2025-02-19 19:33 PST] - Unknown filter 'substring'

**What I was trying to do:** Use a `substring` filter to extract a portion of a string

**What the issue was:** I assumed (based on common programming conventions) that the filter would be named `substring`, but the validator reported: "Unknown filter function 'substring'"

**Why it was an issue:** The filter is actually named `substr` (like PHP/C), but this wasn't obvious from the error message. I had to guess or look up the correct filter name.

**Potential solution:** 
1. Suggest the correct filter name in the error message (e.g., "Did you mean 'substr'?")
2. Include a list of available string filters in the error context
3. Support common aliases like `substring` -> `substr` for better DX

---

## [2025-02-19 19:30 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths

**What the issue was:** I initially tried using JSON format like `'{"file_paths": [...]}'` but the MCP expected key=value format like `file_paths="[...]"`

**Why it was an issue:** The mcporter CLI help shows examples with `key=value` format, but as someone used to JSON APIs, I defaulted to JSON. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" wasn't helpful because I WAS providing those parameters.

**Potential solution:**
1. Accept both JSON and key=value formats
2. Better error message when parameters are provided in wrong format
3. More prominent documentation of the expected format

---

## [2025-02-19 19:28 PST] - Documentation Topics Return Generic README

**What I was trying to do:** Get specific documentation for `functions` and `run` topics to understand syntax patterns

**What the issue was:** Calling `xanoscript_docs` with `topic: "functions"` or `topic: "run"` returned the same generic README/documentation index instead of specific content about those topics.

**Why it was an issue:** I needed to see examples of function syntax and run job patterns, but the documentation didn't provide topic-specific content. I had to look at existing implementations in the `~/xs/` folder instead.

**Potential solution:**
1. Ensure topic-specific documentation actually returns content for that topic
2. If a topic has no specific content, return a "not found" message rather than the generic README
3. Include actual code examples in each topic's documentation

---

## General Observations

**What worked well:**
- The validator provides helpful suggestions (like suggesting "text" instead of "string")
- Line/column numbers in error messages are accurate
- The `directory` parameter for batch validation is convenient

**Suggested improvements:**
1. A comprehensive list of all available filters with descriptions
2. More complete code examples in documentation (beyond the basic structure)
3. A "common mistakes" or "troubleshooting" section in the quickstart

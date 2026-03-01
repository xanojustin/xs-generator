# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 21:35 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files.

**What the issue was:** The MCP tool expects key=value format, not JSON format. I initially tried:
```bash
mcporter call xano validate_xanoscript '{"directory": "/path/to/dir"}'
```

This failed with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

The correct format is:
```bash
mcporter call xano validate_xanoscript directory="/path/to/dir"
```

**Why it was an issue:** The error message was confusing because I WAS providing the directory parameter, just in the wrong format. The error made me think the tool couldn't find the files.

**Potential solution:** The error message could mention the correct format: "Parameters must be in key=value format, not JSON. Example: directory=/path/to/dir"

---

## [2026-02-28 21:38 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Use a filter expression in a conditional: `if ($current|strlen > 0)`

**What the issue was:** XanoScript requires parentheses around filter expressions when used in conditionals: `if (($current|strlen) > 0)`

The error was: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This is a common pattern in many languages and the requirement isn't immediately obvious. The error message was helpful though.

**Potential solution:** The error message is good, but perhaps the documentation could emphasize this more prominently in the syntax section.

---

## [2026-02-28 21:40 PST] - foreach Syntax Confusion

**What I was trying to do:** Iterate over an array using `foreach ($fractions as $fraction)`

**What the issue was:** XanoScript uses a different syntax: `foreach ($fractions) { each as $fraction { ... } }`

The error was: "Expecting --> ) <-- but found --> 'as' <--"

**Why it was an issue:** This syntax is unusual compared to most programming languages (PHP, JavaScript, Python, etc.) which use `foreach ($array as $item)` or similar. The error message wasn't helpful in understanding the correct syntax.

**Potential solution:** The error message could suggest the correct syntax: "Use 'foreach ($array) { each as $item { ... } }' instead of 'foreach ($array as $item)'"

---

## [2026-02-28 21:30 PST] - Documentation Topic Limited Content

**What I was trying to do:** Get detailed documentation about functions and run jobs by calling `xanoscript_docs` with topics "functions" and "run".

**What the issue was:** Both calls returned the same general overview documentation instead of topic-specific content.

**Why it was an issue:** I needed specific syntax examples for `function` and `run.job` constructs but got the same generic documentation.

**Potential solution:** Ensure topic-specific documentation is available, or update the index to show which topics have detailed content vs. just overview content.

---

## General Observation

The Xano MCP validation tool is very helpful! The line/column error reporting makes it easy to locate issues. The main friction points are:
1. Understanding the correct parameter format for mcporter calls
2. Remembering XanoScript's unique syntax patterns (especially foreach)
3. Knowing when parentheses are required around filter expressions

Having more examples in the documentation or a "common patterns" cheat sheet would help.

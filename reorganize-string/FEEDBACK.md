# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 15:35 PST] - Documentation topics return same content

**What I was trying to do:** Get specific documentation for functions, quickstart, and run topics to understand XanoScript syntax

**What the issue was:** All three `xanoscript_docs` calls (topic: "functions", topic: "quickstart", topic: "run") returned the exact same general documentation instead of topic-specific content

**Why it was an issue:** I had to rely on reading existing example files in the ~/xs/ directory to understand the actual syntax patterns instead of getting targeted documentation

**Potential solution:** The MCP should return topic-specific documentation content, or the topics should be removed if they're not implemented

---

## [2025-02-26 15:36 PST] - Parameter passing confusion for validate_xanoscript

**What I was trying to do:** Call `validate_xanoscript` with multiple files using the `file_paths` parameter with JSON syntax

**What the issue was:** The MCP rejected the JSON format `{"file_paths": [...]}` and required the format `file_path="/path"` instead. The `file_paths` (plural) parameter for batch validation didn't seem to work with JSON syntax.

**Why it was an issue:** Wasted time trying different JSON formats before discovering the correct CLI-style parameter passing

**Potential solution:** Better documentation on parameter passing formats, or support both JSON and CLI-style parameters consistently

---

## [2025-02-26 15:40 PST] - Reserved variable name error was confusing

**What I was trying to do:** Use `$output` as a variable name to store the result string

**What the issue was:** Got error: "'$output' is a reserved variable name and should not be used as a variable." The error suggested using `$my_output` but the general documentation only mentions `$response`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result`, `$index` as reserved - not `$output`.

**Why it was an issue:** The documentation didn't list `$output` as reserved, causing confusion about what variable names are safe to use

**Potential solution:** Update documentation to include all reserved variable names including `$output` and `$output`

---

## [2025-02-26 15:42 PST] - Array length filter naming inconsistent

**What I was trying to do:** Get the length of an array using the `length` filter (common in most languages)

**What the issue was:** The filter is called `count` not `length`. The error message said "Unknown filter function 'length'" but didn't suggest the correct filter name.

**Why it was an issue:** Had to search existing code files to discover that `count` is the correct filter for array length

**Potential solution:** The validation error could suggest `count` as an alternative when `length` is used, or document common filter names more prominently

---

## [2025-02-26 15:45 PST] - Conditional response pattern unclear

**What I was trying to do:** Return early from a function within a conditional block when handling edge cases (like `if (len <= 1) { response = input }`)

**What the issue was:** Cannot use `response = ...` inside a conditional block in the stack. The function must always set variables in conditionals and then have a single `response = $var` at the end.

**Why it was an issue:** This pattern is different from most programming languages where early return is common. Had to restructure the entire function logic.

**Potential solution:** Document this constraint clearly with examples showing how to handle edge cases without early returns

---

## [2025-02-26 15:48 PST] - No array push/update syntax documented

**What I was trying to do:** Update an array element at a specific index (like `array[i] = value`)

**What the issue was:** XanoScript doesn't seem to have direct array index assignment. I had to use `slice` and `merge` to reconstruct the array with the updated value, which is verbose and inefficient.

**Why it was an issue:** Made the code much longer and more complex than necessary

**Potential solution:** Document if there's a better way to update array elements, or consider adding array index assignment syntax

---

## Summary

Overall the MCP validation tool was very helpful - it caught errors quickly and provided useful suggestions. The main pain points were:
1. Documentation not being topic-specific as expected
2. Discovering correct syntax required reading existing code examples
3. Some error messages could be more helpful with suggestions
4. Array manipulation is verbose compared to other languages

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 21:32 PST] - Issue 1: Incorrect assumption about filter name

**What I was trying to do:** Get unique elements from an array to count distinct letters in a pangram checker

**What the issue was:** Used `array_unique` filter (common in PHP and other languages), but the actual filter is just `unique`

**Why it was an issue:** The error message "Unknown filter function 'array_unique'" was clear, but I had to guess at the correct filter name. I tried `array_unique` first because that's what it's called in PHP.

**Potential solution:** Add aliases for common filter names that developers from other languages might expect. For example, `array_unique` could be an alias for `unique`. Alternatively, improve the error message to suggest: "Did you mean 'unique'?"

---

## [2025-02-23 21:35 PST] - Issue 2: Unclear about control flow in stack blocks

**What I was trying to do:** Use conditional logic (`if` statements) inside a function's stack block to check for individual letters

**What the issue was:** Got error "Expecting --> } <-- but found --> 'if' <--" when trying to use standalone `if` statements in the stack block

**Why it was an issue:** I incorrectly assumed that standard `if` statements could be used directly in stack blocks. I didn't know about the `conditional { if (...) { } }` syntax requirement from the documentation until I searched for it.

**Potential solution:** 
1. The error message could be more helpful: "Use 'conditional' blocks for if/else logic in stack blocks. Example: conditional { if (...) { ... } }"
2. The quick reference could mention this earlier/more prominently
3. A code example in the function documentation showing conditional logic would help

---

## [2025-02-23 21:30 PST] - Issue 3: MCP validate_xanoscript with comma-separated file_paths

**What I was trying to do:** Validate multiple files using `file_paths` parameter with comma-separated values

**What the issue was:** The MCP parsed the comma-separated string as individual characters instead of file paths, producing errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** The documentation shows `file_paths: Array of file paths for batch validation` with example `["apis/users/get.xs", "apis/users/create.xs"]`, but when using CLI, passing comma-separated values caused parsing issues.

**Potential solution:** 
1. Clarify in documentation how to properly pass array values via CLI
2. Or suggest using `directory` parameter for multiple files in the same folder (which worked perfectly)

---

## Positive Feedback

**The `directory` validation parameter worked great!** Once I switched to using `directory=/Users/justinalbrecht/xs/pangram-check`, validation worked perfectly and showed clear error messages with line numbers.

**The `unique` filter is intuitive** - once I found it, the solution was elegant and clean.

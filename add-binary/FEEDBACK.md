# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-21 13:35 PST - MCP Tool file_paths Argument Parsing Issue

**What I was trying to do:** Validate multiple XanoScript files at once using the `file_paths` parameter

**What the issue was:** The `file_paths` argument with comma-separated paths caused parsing issues. The tool interpreted each character as a separate file path, resulting in errors like "File not found: U", "File not found: s", etc. (breaking down "/Users/justinalbrecht/..." into individual characters).

Command used:
```
mcporter call xano.validate_xanoscript file_paths="/path/to/file1.xs,/path/to/file2.xs"
```

Output showed:
- "Error reading file: EISDIR: illegal operation on a directory, read"
- "File not found: U", "File not found: s", "File not found: e", etc.

**Why it was an issue:** I had to run validation twice (once per file) instead of batch validating all files, which is less efficient.

**Potential solution:** 
- The MCP tool should properly parse comma-separated file paths as an array
- Alternative: Support JSON array format for file_paths parameter
- Or document that file_paths requires a specific format

**Workaround:** Validating files one at a time using `file_path` (singular) parameter works correctly.

---

## 2025-02-21 13:40 PST - XanoScript Documentation Clarification

**What I was trying to do:** Implement a while loop with multiple conditions

**What the issue was:** Initially unclear about the proper syntax for complex while loop conditions and whether backticks are required.

**Why it was an issue:** Had to experiment to find the correct syntax for:
```xs
while (`$i >= 0 || $j >= 0 || $carry > 0`)
```

**Potential solution:** 
- The syntax documentation could more prominently feature that backticks are required for expressions in while loop conditions
- A dedicated "Control Flow" section with more while loop examples would be helpful

---

## 2025-02-21 13:42 PST - Variable Mutation Pattern

**What I was trying to do:** Update a variable inside a loop (decrementing indices)

**What the issue was:** Initially wasn't sure about the difference between `var` and `var.update` inside loops.

**Why it was an issue:** The documentation mentions `var.update` but doesn't clearly explain when it's required vs. when redeclaring with `var` works.

**Potential solution:**
- Clarify in documentation that `var.update` is required when modifying an existing variable
- Explain that redeclaring with `var` creates a new variable in the current scope that shadows the outer one

---

## General Feedback

### Positive
- The `validate_xanoscript` tool is very helpful and provides clear error messages
- The `xanoscript_docs` tool provides comprehensive documentation
- Once understood, XanoScript syntax is clean and readable
- The filter system is powerful and chainable

### Suggestions
1. **Quick Reference Card:** A single-page cheatsheet with the most common patterns would be helpful for frequent reference
2. **More Examples:** More complete function examples showing common patterns (loops, conditionals, string manipulation)
3. **Common Pitfalls Section:** A dedicated section in the docs for mistakes like:
   - Using `else if` instead of `elseif`
   - Missing parentheses around filters in comparisons
   - Using wrong type names (string vs text, integer vs int)
4. **Batch Validation:** Fix the file_paths parameter to properly handle multiple files

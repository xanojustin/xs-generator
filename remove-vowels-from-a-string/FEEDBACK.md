# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 10:35 PST] - Multi-line conditionals not supported

**What I was trying to do:** Write a clean if statement that checks if a character is NOT one of 10 different vowels (both cases) in a single conditional.

**What the issue was:** I attempted to use a backslash (`\`) for line continuation to split a long `if` condition across multiple lines:
```xs
if ($char != "a" && $char != "e" && $char != "i" && $char != "o" && $char != "u" &&
    $char != "A" && $char != "E" && $char != "I" && $char != "O" && $char != "U") {
```

This resulted in a cryptic parser error: "Expecting: one of these possible Token sequences... but found: '\n'"

**Why it was an issue:** 
1. The error message is not user-friendly - it lists 29 possible token types without explaining the actual problem
2. There's no clear indication that multi-line expressions within conditionals aren't supported
3. I had to completely restructure my logic to use multiple conditional blocks and a flag variable instead

**Potential solution (if known):**
- Document clearly in the syntax docs that conditionals must fit on a single line
- Provide a better error message like: "Line continuation not supported in conditionals. Consider breaking into multiple conditionals or using a different approach."
- Consider supporting multi-line expressions for readability (common in other languages)

---

## [2025-02-24 10:32 PST] - Array parameter format confusion

**What I was trying to do:** Pass multiple file paths to the `validate_xanoscript` tool using the `file_paths` parameter.

**What the issue was:** The MCP tool accepts `file_paths` as an array, but the CLI parsing seems to split on commas in unexpected ways. When I tried:
```
mcporter call xano.validate_xanoscript file_paths="~/xs/.../run.xs,~/xs/.../remove_vowels.xs"
```

The tool interpreted each character of the path as a separate file, resulting in errors like "File not found: U", "File not found: s", "File not found: e", etc.

**Why it was an issue:** 
- The array syntax wasn't clear from the documentation
- The error messages were extremely confusing (it was trying to read each character as a filename)
- Had to switch to using `directory` parameter instead, which worked fine

**Potential solution (if known):**
- Document the correct way to pass arrays via CLI
- Improve error handling to detect when paths look like they've been split character-by-character
- Consider adding examples showing array parameter usage in the tool description

---

## [2025-02-24 10:30 PST] - Path expansion with tilde (~)

**What I was trying to do:** Use `~/xs/` shorthand to reference files in my home directory when calling the validate tool.

**What the issue was:** The tilde (`~`) was not expanded to the home directory, causing "File not found" errors.

**Why it was an issue:** Shell users expect tilde expansion to work. Had to use full absolute path `/Users/justinalbrecht/xs/` instead.

**Potential solution (if known):**
- Either support tilde expansion in file paths
- Or document that absolute paths are required

---

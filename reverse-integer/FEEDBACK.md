# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 21:32 PST] - MCP Tool Input Parsing Issue

**What I was trying to do:** Validate multiple XanoScript files using the `validate_xanoscript` tool with the `file_paths` parameter

**What the issue was:** When passing comma-separated file paths like `/Users/justinalbrecht/xs/reverse-integer/run.xs,/Users/justinalbrecht/xs/reverse-integer/function/reverse-integer.xs`, the MCP server appeared to split the string character-by-character, treating each character (including the comma) as a separate file path. This resulted in errors like "File not found: U", "File not found: s", "File not found: e", etc.

**Why it was an issue:** This prevented batch validation of multiple specific files. I had to work around it by using the `directory` parameter instead, which validates all files in a directory.

**Potential solution:** The `file_paths` parameter should properly handle comma-separated values as distinct array elements, not as a string to be split character-by-character. The MCP server should parse the input as a proper JSON array.

---

## [2025-02-20 21:32 PST] - Positive Feedback: Directory Validation Works Well

**What I was trying to do:** Validate all .xs files in a directory

**What worked well:** The `directory` parameter with the `validate_xanoscript` tool worked perfectly, recursively finding and validating all .xs files in the specified path.

**Result:** Both files validated successfully on the first attempt, with clear output showing "2 valid, 0 invalid".

---

## [2025-02-20 21:32 PST] - Documentation Quality

**What I was trying to do:** Learn XanoScript syntax for writing a function with conditionals, loops, and arithmetic operations

**What worked well:** The `xanoscript_docs` tool with `mode=quick_reference` provided concise, useful information about:
- Variable declaration syntax
- Conditional blocks with `if`/`elseif`/`else`
- While loops with `while` and `each`
- Type names (int, bool, text vs wrong names like integer, boolean, string)
- The `return` statement for early exits
- Reserved variable names

**Minor confusion:** Initially wasn't sure about the exact syntax for variable updates inside loops - the docs showed `var.update` syntax which was helpful.

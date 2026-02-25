# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 22:01 PST] - Validation Parameter Confusion

**What I was trying to do:** Validate XanoScript files using the MCP

**What the issue was:** The tool expects parameters `file_path`, `file_paths`, `code`, or `directory` but I initially tried using `file` which is not a valid parameter name.

**Why it was an issue:** Got error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even though I was passing a file path.

**Potential solution (if known):** The parameter is `file_path` not `file`. This could be clearer in tool naming or aliases could be supported.

---

## [2026-02-24 22:02 PST] - First Validation Success

**What I was trying to do:** Write XanoScript code based on documentation

**What the issue was:** No issues! Both files passed validation on the first attempt.

**Why it was an issue:** Not an issue - the documentation was clear enough to write correct code.

**What worked well:**
- The `xanoscript_docs` with topic="quickstart" provided clear examples
- The topic="functions" showed proper function structure
- The topic="run" showed the run.job syntax
- Examples of `var.update`, `while` loops, `return` statements, and conditionals were all clear

---

## Summary

The Xano MCP worked well for this exercise. The documentation was comprehensive enough that I could write valid XanoScript on the first attempt. The only confusion was the parameter naming for validation (`file_path` vs `file`).

The Ugly Number exercise required:
- Early returns using `return { value = ... }`
- While loops with modulo operations
- Variable updates using `var.update`
- Conditionals for branching

All of these patterns were clearly documented and worked as expected.

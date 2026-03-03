# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 07:45 PST] - File Encoding Issues with Validation

**What I was trying to do:** Validate XanoScript files after creating them with the `write` tool

**What the issue was:** The validator reported errors like "Expecting --> run <-- but found --> '\n' <--" even though the files looked correct when viewed with `read` and `cat`. The content appeared to start with the correct construct, but the parser was seeing something else.

**Why it was an issue:** This blocked validation and required rewriting files using shell heredocs instead of the `write` tool.

**Potential solution:** 
- The MCP could provide clearer error messages about encoding/BOM issues
- The validator could strip leading whitespace/comments more robustly
- Documentation could mention preferred file creation methods

---

## [2025-03-03 07:50 PST] - Reserved Keyword Confusion

**What I was trying to do:** Use a variable named `$stack` inside a `stack` block to implement iterative backtracking

**What the issue was:** Got error "Expecting --> } <-- but found --> 'stack' <--" which was confusing because I was inside a stack block and didn't realize `stack` was reserved

**Why it was an issue:** The error message suggests it was expecting a closing brace, not that `stack` is a reserved word. This made debugging harder.

**Potential solution:**
- Error message could explicitly say "'stack' is a reserved keyword and cannot be used as a variable name"
- Documentation could have a more prominent list of reserved keywords
- IDE/linter could highlight reserved words in real-time

---

## [2025-03-03 07:55 PST] - Group Construct Documentation Gap

**What I was trying to do:** Use the `group` construct to organize related variable declarations

**What the issue was:** Got error "Expecting --> stack <-- but found --> '\n' <--" which was unclear. I didn't realize `group` requires a `stack` block inside it.

**Why it was an issue:** The documentation says "The `group` block is purely organizational — it does **not** create parallel execution or a new scope" but doesn't clearly state the required child block structure in the quick examples.

**Potential solution:**
- Make the required `stack` child block more explicit in the documentation examples
- Error message could suggest "group blocks require a stack child block"

---

## [2025-03-03 08:00 PST] - Validate Tool Parameter Discovery

**What I was trying to do:** Validate specific files using `file_paths` parameter

**What the issue was:** Initially tried `files` parameter which doesn't exist, then tried `file_paths` with relative paths which failed, then had to use `directory` parameter with absolute paths.

**Why it was an issue:** Trial and error to find the right parameter name and path format.

**Potential solution:**
- MCP could provide a `validate_xanoscript --help` or usage information
- Documentation could show examples of all parameter options
- Better error messages when parameters are missing or incorrect

---

## General Feedback

**Positive:**
- The `xanoscript_docs` tool is excellent - comprehensive and well-organized
- Once files are valid, the validation messages are clear and helpful
- The directory-based validation is convenient for batch checking

**Areas for improvement:**
- Error messages could be more actionable (suggest fixes, not just state problems)
- Reserved keywords should be prominently documented with clear error messages
- More examples of complex control flow (nested while/conditional inside loops)

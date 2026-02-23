# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-22 21:35 PST - MCP Tool Name Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool on the Xano MCP

**What the issue was:** Initially tried calling `mcporter call xano.validate_xanoscript` but got "Unknown MCP server 'xano'" error. Then tried using `mcporter call xano.xanoscript_docs` which worked for docs but validation had different patterns.

**Why it was an issue:** The error messages were confusing because the server IS named "xano" when listing (`mcporter list` shows `xano`), but tool calls need to use the format `mcporter call <server>.<tool>` with correct parameters.

**Resolution:** Using `--args` JSON format worked: `mcporter call xano.validate_xanoscript --args '{"file_paths":[...]}'`

---

## 2025-02-22 21:37 PST - Validation Error with File Array

**What I was trying to do:** Validate multiple .xs files by passing an array of file paths

**What the issue was:** First attempt used `files=` parameter which failed with "source.match is not a function". The parameter name is `file_paths` (not `files`).

**Why it was an issue:** The error message "source.match is not a function" doesn't indicate the actual problem (wrong parameter name). This made it unclear whether the issue was with the tool, the files, or the parameters.

**Potential solution:** Better parameter validation with clear error messages like "Unknown parameter 'files'. Did you mean 'file_paths'?"

---

## 2025-02-22 21:40 PST - No Issues with XanoScript Syntax

**What I was trying to do:** Validate existing XanoScript code

**What the issue was:** None - the code passed validation on first attempt

**Why it was an issue:** N/A - this is positive feedback that the existing code was well-written

**Notes:** The existing `can_finish.xs` function properly implements Kahn's algorithm for topological sort with correct XanoScript syntax including:
- Proper `function` block structure
- Correct `input` parameter definitions  
- Proper `stack` execution block
- Correct use of `var` declarations and `var.update`
- Proper `conditional` blocks with `if`
- Correct `while` loops with `each` blocks
- Proper `response` assignment


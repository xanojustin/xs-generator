# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-18 15:18 PST - Initial Validation Success

**What I was trying to do:**
Create a Notion API run job with proper XanoScript syntax - including a run.job definition, a function with API calls, and a table definition.

**What the issue was:**
No issues encountered! All three files passed validation on the first try.

**Why it was an issue:**
N/A - No issues, just documenting the successful workflow.

**Potential solution (if known):**
The MCP validation worked perfectly. The clear error messages in the schema (when I used wrong parameters initially) helped me understand to use `directory` parameter instead of `path`.

---

## 2026-02-18 15:15 PST - MCP Tool Parameter Discovery

**What I was trying to do:**
Call the `validate_xanoscript` tool to validate my code.

**What the issue was:**
Initially used `path:` parameter but the tool expected `file_path`, `file_paths`, or `directory`.

**Why it was an issue:**
Got an error: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Potential solution (if known):**
I used `mcporter list xano --schema` to discover the correct parameter names. The error message was helpful but could be more specific about which parameter names are accepted. Consider suggesting the available parameters in the error.

---

## 2026-02-18 15:10 PST - Understanding Run Job Structure

**What I was trying to do:**
Understand how to structure a complete run job (run.xs + function + table).

**What the issue was:**
No specific issue - the documentation was comprehensive. I just needed to read existing examples to understand the pattern.

**Why it was an issue:**
N/A - Documentation and existing examples were sufficient.

**Potential solution (if known):**
The existing implementations in ~/xs/ served as excellent reference. The `xanoscript_docs({ topic: "run" })` call provided clear guidance on run.job vs run.service differences.


# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 03:35 PST - Initial Setup

**What I was trying to do:** Create a XanoScript coding exercise for generating combinations (n choose k problem)

**What the issue was:** No major issues encountered. The Xano MCP was already configured and the `validate_xanoscript` tool worked correctly.

**Why it was an issue:** N/A - initial setup went smoothly

**Potential solution (if known):** N/A

---

## 2026-02-23 03:38 PST - Documentation Access

**What I was trying to do:** Access XanoScript documentation to understand syntax for functions, run jobs, and language constructs

**What the issue was:** Had to call `xanoscript_docs` multiple times with different topics to get complete information. The docs are well-organized but I needed topics="functions", topics="run", and topics="quickstart" to get all the patterns I needed.

**Why it was an issue:** Required multiple MCP calls to gather all necessary syntax information. A single comprehensive topic or a "coding-exercise" specific guide might help.

**Potential solution (if known):** Consider adding a "coding-exercise" or "algorithm-template" topic that covers the run.job + function pattern specifically for algorithm implementations. This is a common pattern for interview prep exercises.

---

## 2026-02-23 03:42 PST - Validation Tool Parameter Format

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths

**What the issue was:** Initially tried `files:` parameter but the correct parameter is `file_paths` (array of strings). The error message was helpful: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** Minor confusion on parameter name, quickly resolved by checking the tool schema

**Potential solution (if known):** The tool schema is clear when viewed with `--schema`. No changes needed.

---

## 2026-02-23 03:45 PST - First-Pass Validation Success

**What I was trying to do:** Validate the combinations.xs and run.xs files

**What the issue was:** Both files passed validation on the first attempt! This is notable because previous exercises often required multiple validation-fix cycles.

**Why it was an issue:** N/A - success case

**Potential solution (if known):** The documentation at topics="functions" and topics="run" was comprehensive enough to write correct code on the first try. The examples for run.job structure and function.call patterns were particularly helpful.

---

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-02 06:05 PST - No Issues Encountered

**What I was trying to do:** Create a Basic Calculator II exercise in XanoScript with a run job that calls a function

**What the issue was:** No issues encountered - all code passed validation on the first attempt

**Why it was an issue:** N/A - development was smooth

**Potential solution (if known):** The Xano MCP validation tool worked correctly and provided clear success messages

---

## 2025-03-02 06:00 PST - Documentation Request Clarification

**What I was trying to do:** Retrieve XanoScript documentation using the xanoscript_docs tool

**What the issue was:** Initially tried using `--params` flag which is not the correct syntax for mcporter

**Why it was an issue:** The error message was helpful and showed available topics, but didn't explain the correct parameter passing syntax

**Potential solution (if known):** The correct syntax is `mcporter call xano.xanoscript_docs topic=functions` (using key=value format). This could be documented more clearly in the skill or error message

---

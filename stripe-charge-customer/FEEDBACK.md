# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 11:17 PST - MCP validate_xanoscript Tool Bug

**What I was trying to do:**
Validate the XanoScript (.xs) files I created using the `validate_xanoscript` MCP tool.

**What the issue was:**
The validation tool returns an error for ALL .xs files, including existing valid ones:
```
Found 1 error(s):
1. [Line 1, Column 1] Expecting --> function <-- but found --> '-' <--
```

This happens even when validating the existing working files from `twilio-send-sms/function/send_sms.xs` which we know are valid. The error suggests the parser is seeing a '-' character at the start of the file, but hexdump confirms files start with 'f' (0x66).

**Why it was an issue:**
- Cannot verify syntax correctness of new code
- Blocked from confirming files "pass" validation as required by task
- Had to rely on pattern-matching with existing working examples instead

**Potential solution (if known):**
The MCP validation tool may have an issue with:
1. How it receives the `code` parameter (encoding/escaping issue)
2. The language server backend may not be properly initialized
3. There may be a mismatch between the expected and actual file format

---

## 2026-02-13 11:15 PST - Limited Documentation for run.job Syntax

**What I was trying to do:**
Find detailed documentation on the `run.job` construct syntax for creating run jobs.

**What the issue was:**
Calling `xanoscript_docs({ topic: "run" })` returns only the general documentation index, not specific `run.job` syntax details. I had to infer the structure by examining existing implementations in the `~/xs/` folder.

**Why it was an issue:**
- No clear documentation on required vs optional fields in `run.job`
- Unclear what the `main` block structure should contain
- Had to reverse-engineer from existing working examples

**Potential solution (if known):**
Add specific documentation for:
- `run.job` construct syntax and fields
- Proper structure for `main`, `env`, and other blocks
- Examples of valid run job configurations

---

## 2026-02-13 11:14 PST - xanoscript_docs Returns Same Content for All Topics

**What I was trying to do:**
Get specific documentation for different topics (syntax, integrations, run, etc.).

**What the issue was:**
Calling `xanoscript_docs` with different topic parameters (`syntax`, `integrations`, `run`) all returned the same general documentation index page with the quick reference table, not topic-specific content.

**Why it was an issue:**
- Could not get detailed syntax reference
- Could not get specific information on API request patterns
- Had to rely on existing code examples rather than authoritative documentation

**Potential solution (if known):**
The topic filtering may not be working correctly in the MCP, or the documentation files may not contain the expected topic-specific content.

---

## Summary

Despite these issues, I was able to complete the task by:
1. Examining existing working implementations in `~/xs/`
2. Following established patterns from `twilio-send-sms` and `sendgrid-send-email`
3. Using the general syntax patterns from the documentation index

The Stripe charge customer run job follows the same structure as existing valid implementations.

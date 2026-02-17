# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 21:20 PST - Inline Comments Not Allowed in Input Blocks

**What I was trying to do:**
Add helpful inline comments to document input parameters in the function input block:
```xs
input {
  text start_time          // ISO 8601 format: 2025-02-17T10:00:00
  int duration?=60         // Duration in minutes
}
```

**What the issue was:**
The validator threw an error: "[Line 7, Column 30] Expecting --> } <-- but found --> '/' <--"

It rejected the inline comment syntax within the input block. The comment after `text start_time` caused a parse error.

**Why it was an issue:**
This is a common and helpful pattern in programming languages - documenting parameters inline where they're declared. Having to move comments above the input block or into the stack reduces code readability.

**Potential solution (if known):**
Either:
1. Allow inline comments in input blocks (preferable)
2. Document this restriction clearly in the quickstart/docs

---

## 2025-02-16 21:18 PST - Blank Line After Comments Causes Parse Error

**What I was trying to do:**
Write clean, well-formatted XanoScript with standard spacing between comments and code blocks:
```xs
// Comment here

function "name" {
```

**What the issue was:**
The validator threw: "[Line 3, Column 1] Expecting --> function <-- but found --> '' <--"

The blank line between the comment and the function definition caused a parse error.

**Why it was an issue:**
This is standard formatting in virtually all programming languages. Removing blank lines makes code feel cramped and harder to read. The error message was also confusing - it shows empty quotes which made me think there was an encoding issue.

**Potential solution (if known):**
Either:
1. Allow blank lines between comments and definitions (preferable)
2. Improve error message to say "Remove blank line after comment"

---

## 2025-02-16 21:15 PST - MCP Server Connection Issues

**What I was trying to do:**
Call the validate_xanoscript tool using the Xano MCP server.

**What the issue was:**
Got error: "Unknown MCP server 'xano'." intermittently when calling the tool. The server would show as healthy in `mcporter list` but calls would fail.

**Why it was an issue:**
Had to restart the daemon multiple times. Unclear if this is a timing issue, STDIO transport issue, or something else.

**Potential solution (if known):**
Maybe add retry logic or investigate STDIO transport stability. The error was inconsistent - sometimes worked, sometimes didn't.

---

## 2025-02-16 21:10 PST - Parameter Name Confusion in validate_xanoscript

**What I was trying to do:**
Validate a file using the MCP tool. Initially tried `filepath` (lowercase, no underscore) because that's a common pattern.

**What the issue was:**
The parameter is named `file_path` (with underscore). Had to check the schema to find the correct name.

**Why it was an issue:**
Minor issue, but `filepath` (one word) is common in many APIs. The inconsistency between common conventions and the actual parameter name caused a moment of confusion.

**Potential solution (if known):**
Document the exact parameter names prominently, or accept both `filepath` and `file_path` for convenience.

---

## General Observations

**Documentation Quality:**
The `xanoscript_docs` tool is excellent! Very comprehensive and well-organized. The quickstart guide with "Common Mistakes" section was particularly helpful.

**Validation Tool:**
Once working, the validation tool provides helpful error messages with line/column numbers and even code snippets. The suggestions (like "Use text instead of string") are great.

**Type System:**
The strict type system (text vs string, bool vs boolean) is clear once you know it, but the error messages could be more explicit about what types ARE valid when an invalid one is used.

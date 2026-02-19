# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 13:05 PST] - Issue 1: Incorrect filter name assumption

**What I was trying to do:** Create a palindrome check function that normalizes input strings by converting to lowercase and removing non-alphanumeric characters.

**What the issue was:** I assumed the lowercase filter was `lower` (common in many languages), but XanoScript uses `to_lower`. The validation caught this with a clear error message.

**Why it was an issue:** This is a common naming discrepancy between languages. JavaScript uses `toLowerCase()`, Python uses `lower()`, XanoScript uses `to_lower`. Without validation, this would have been a runtime error.

**Potential solution (if known):** The MCP validation worked perfectly here - caught the issue immediately with line/column numbers. The documentation also lists the correct filter name. No changes needed to the MCP, but perhaps the docs could mention common aliases that people might try (like `lower` vs `to_lower`).

---

## [2025-02-19 13:05 PST] - Positive Feedback: Validation Tool Works Great

**What worked well:**
1. The `validate_xanoscript` tool provides clear, actionable error messages with exact line and column numbers
2. The error message even included a helpful suggestion (though it was about a different issue - type names)
3. The tool accepts `file_path` parameter which makes it easy to validate files directly without escaping code
4. Both files validated successfully on the second attempt

**No issues to report with the MCP itself** - the validation tool performed exactly as expected and helped catch the syntax error immediately.

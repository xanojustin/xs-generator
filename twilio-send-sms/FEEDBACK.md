# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 11:48 PST] - Documentation Returns Generic Index Instead of Specific Content

**What I was trying to do:** Get specific documentation for `syntax`, `run`, and `integrations` topics using `xanoscript_docs`.

**What the issue was:** Called `xanoscript_docs({"topic": "syntax"})`, `xanoscript_docs({"topic": "run"})`, and `xanoscript_docs({"topic": "integrations"})` but all three returned the same generic documentation index/overview instead of topic-specific content.

**Why it was an issue:** I couldn't access the detailed syntax documentation that supposedly contains information about filters (L179-275) and error handling (L411-477). This made it harder to write correct XanoScript code without trial and error.

**Potential solution (if known):** The MCP might need to check if the topic parameter is actually returning specific content vs. falling back to the index. The documentation mentions line number references (e.g., "Filters (L179-275)") but these sections aren't accessible.

---

## [2026-02-18 11:50 PST] - Reserved Variable Names Not Documented in Output

**What I was trying to do:** Create a variable named `$auth` to store Twilio authentication credentials.

**What the issue was:** The validator correctly identified that `$auth` is a reserved variable name, but this wasn't mentioned in the documentation I received. The documentation only listed: `$response`, `$output`, `$input`, `$auth`, `$env`, `$db`, `$this`, `$result` as reserved - wait, `$auth` IS listed. Let me re-check... Actually the documentation DID list `$auth` as reserved. This was my oversight.

**Why it was an issue:** User error - I should have checked the reserved variables list more carefully. The error message from the validator was very helpful: `"$auth" is a reserved variable name. Try a different name like "$my_auth"`

**Potential solution (if known):** The error message is already excellent and suggests alternatives. No change needed.

---

## [2026-02-18 11:50 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Use a ternary operator with a filter expression: `($input.from_number|strlen > 0) ? ...`

**What the issue was:** The validator rejected this with "An expression should be wrapped in parentheses when combining filters and tests." I had to change it to `(($input.from_number|strlen) > 0) ? ...` - wrapping just the filter part in parentheses.

**Why it was an issue:** The syntax requirement wasn't clear from the documentation. The error message explained it, but having this in the syntax docs with examples of correct filter+operator combinations would help.

**Potential solution (if known):** Add examples to the syntax documentation showing:
- ❌ `$value|filter > 0`  
- ✅ `($value|filter) > 0`

---

## [2026-02-18 11:52 PST] - mcporter Parameter Passing Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with JSON parameters.

**What the issue was:** Initially tried `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` which failed with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required". Using `directory=/path` (without JSON wrapping) worked.

**Why it was an issue:** The tool description shows parameters in JSON format in the description, but mcporter CLI expects key=value format, not JSON.

**Potential solution (if known):** The mcporter CLI could potentially accept JSON format with a `--json` flag, or the tool description could clarify the expected CLI format vs. the programmatic format.

---

## [2026-02-18 11:53 PST] - Working Directory Affects MCP Server Discovery

**What I was trying to do:** Validate files while in the `twilio-send-sms` directory.

**What the issue was:** When I ran `cd /Users/justinalbrecht/xs/twilio-send-sms && mcporter call xano validate_xanoscript ...`, mcporter couldn't find the xano server. The server is discoverable from the home directory but not from within the project directory.

**Why it was an issue:** This suggests mcporter looks for MCP server configuration relative to the current working directory, which is unexpected behavior.

**Potential solution (if known):** mcporter should probably look for MCP configuration from a consistent location (e.g., user's home directory) regardless of the current working directory.

---

## Summary

Overall the validation tool worked well - the error messages were clear and helpful. The main issues were:
1. Documentation topics returning index instead of specific content
2. Working directory affecting MCP server discovery
3. Minor confusion about parameter passing format

The validator's error messages (especially the suggestion to use `$my_auth` instead of `$auth`) were excellent and made fixing issues straightforward.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 13:20 PST] - Directory Path Resolution Issue

**What I was trying to do:**
Validate the .xs files using the Xano MCP validate_xanoscript tool with the directory parameter.

**What the issue was:**
The MCP returned "No .xs files found in directory" when using the path `/Users/justinalbrecht/.openclaw/workspace/xs/discord-send-webhook`. However, the files were actually at `/Users/justinalbrecht/xs/discord-send-webhook/` (without the `.openclaw/workspace` segment).

**Why it was an issue:**
This caused initial confusion about whether the files were created correctly. I had to use `find` to locate the actual files and discovered the path expansion issue. The MCP tool appears to not resolve `~` or relative paths the same way the shell does.

**Potential solution (if known):**
The MCP could either:
1. Support shell-style path expansion (~/xs/...)
2. Return a more helpful error indicating the directory doesn't exist vs. no files found
3. Document that absolute paths are required

---

## [2025-02-16 13:15 PST] - Validation Success Documentation Gap

**What I was trying to do:**
Understand what a successful validation response looks like to ensure my files passed correctly.

**What the issue was:**
The documentation for `validate_xanoscript` describes what happens on errors but doesn't clearly show what a successful validation response format looks like. I had to run the tool to discover it returns a text summary with counts of valid/invalid files.

**Why it was an issue:**
Minor issue - I wanted to programmatically confirm success but the output is text-based rather than structured JSON with a clear `success: true/false` field. The `--output json` flag doesn't change the content structure of the validation result.

**Potential solution (if known):**
Consider returning structured JSON for the validation results when `--output json` is used, including:
- `success: true/false`
- `files_checked: [...]`
- `errors: [...]` with line/column info

---

## [2025-02-16 13:10 PST] - File Path Handling in Read Tool

**What I was trying to do:**
Read existing run.xs and README.md files from other implementations to use as reference.

**What the issue was:**
The `read` tool failed with ENOENT errors when trying to read files at `~/xs/twilio-send-sms/run.xs` and `~/xs/twilio-send-sms/README.md`, even though the files exist. I had to fall back to using `cat` via exec.

**Why it was an issue:**
This is inconsistent behavior - the write tool handles the same paths correctly, but read doesn't. It seems like read may not expand `~` to the home directory.

**Potential solution (if known):**
Ensure the read tool uses the same path resolution as write and other tools, supporting `~` expansion.

---

## General Notes

### What Worked Well

1. **Xano MCP xanoscript_docs tool** - The documentation is comprehensive and well-organized. Having topics for `run`, `quickstart`, `syntax`, etc. made it easy to find what I needed.

2. **Validation tool** - Once I used the correct path, the validation was fast and accurate. Both files passed on first attempt.

3. **Error examples in docs** - The quickstart guide's "Common Mistakes" section was extremely helpful for avoiding pitfalls like:
   - Using `elseif` instead of `else if`
   - Using `body` instead of `params` for api.request
   - Wrong type names (string vs text, boolean vs bool)

### Suggestions for Improvement

1. **More Run Job Examples** - While the docs show basic patterns, having more real-world examples for common APIs (Discord, Slack, etc.) would help developers understand best practices for error handling and response parsing.

2. **Filter Documentation** - Some filters like `starts_with` and `strlen` were discoverable but not prominently documented in the quick reference. A complete filter index would be helpful.

3. **MC Porter CLI Output** - The output from `mcporter call` includes JSON with a `content` array containing text. It would be cleaner if the MCP returned the raw result directly instead of wrapping it.

---

## Summary

Overall the development experience was smooth. The main friction points were:
- Path resolution inconsistencies between tools
- Output format differences between tools

The XanoScript language itself is intuitive once you learn the syntax patterns, and the validation tool caught no errors (indicating the documentation was clear enough to write correct code on first attempt).

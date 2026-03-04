# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 20:35 PST] - Comment Syntax Restriction

**What I was trying to do:** Write a function with inline comments to explain the code

**What the issue was:** XanoScript does not allow inline comments (comments on the same line as code). Comments MUST be on their own separate lines.

**Why it was an issue:** This is different from most programming languages (JavaScript, Python, etc.) where inline comments are standard. The error message was cryptic - it said "expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]>" which doesn't clearly indicate that comments can't be inline.

**Potential solution (if known):** 
- Improve the error message to clearly state "Comments must be on their own line"
- Consider adding support for inline comments in future XanoScript versions
- Document this restriction prominently in the syntax guide

---

## [2026-03-03 20:30 PST] - MCP Documentation Parameter Format

**What I was trying to do:** Call the `xanoscript_docs` MCP tool with a topic parameter

**What the issue was:** The documentation kept returning the index instead of the specific topic content. I tried various JSON formats but the specific topic content wasn't retrieved.

**Why it was an issue:** I needed specific syntax details (like comment rules, loop patterns, etc.) but couldn't access them through the MCP. I had to rely on reading existing code examples instead.

**Potential solution (if known):**
- Verify the MCP tool implementation for `xanoscript_docs` correctly handles topic parameters
- Ensure the documentation content is properly segmented and retrievable by topic

---

## [2026-03-03 20:32 PST] - MCP Validation Parameter Format

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths

**What the issue was:** The parameter format wasn't immediately clear. I tried `file_path`, `file_paths`, and JSON object formats before finding that `--args '{"directory": "/path"}'` works.

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was helpful, but the exact JSON structure expected wasn't documented in the tool help.

**Potential solution (if known):**
- Add example calls to the MCP tool documentation
- Show the expected JSON schema for each parameter option

---

## [2026-03-03 20:33 PST] - Type Suggestion Mismatch

**What I was trying to do:** Understand the validation error about types

**What the issue was:** The validator suggested "Use 'int' instead of 'integer' for type declaration" but my code already used `int[]`. The suggestion seemed to be a generic hint rather than relevant to my actual error.

**Why it was an issue:** The misleading suggestion distracted from the actual problem (inline comments).

**Potential solution (if known):**
- Only show type suggestions when the error is actually related to type declarations
- Improve error context to show what the parser was expecting vs. what it found

---

## General Observations

**Positive:**
- The two-pointer solution pattern works well in XanoScript
- The `|sort`, `|abs`, and array filters are intuitive
- The validation tool catches syntax errors effectively

**Challenges:**
- Comment restrictions are strict and not well-documented in the accessible help
- The two-pointer algorithm required careful variable scoping within conditionals
- Without clear documentation on loops and conditionals, pattern-matching from existing code was necessary

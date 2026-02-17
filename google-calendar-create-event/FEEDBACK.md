# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 02:47 PST] - File Path Validation Issue

**What I was trying to do:**
Validate multiple .xs files by passing comma-separated file paths to the validate_xanoscript tool.

**What the issue was:**
I called the tool with:
```
mcporter call xano.validate_xanoscript file_paths=/Users/justinalbrecht/xs/google-calendar-create-event/run.xs,/Users/justinalbrecht/xs/google-calendar-create-event/function/create_calendar_event.xs
```

The tool interpreted the comma-separated string as individual characters, resulting in errors like:
- "File not found: U"
- "File not found: s"
- "File not found: e"
- etc.

It treated each character in the path string as a separate file path.

**Why it was an issue:**
This blocked batch validation using file_paths parameter. I had to work around by using the `directory` parameter instead, which worked fine.

**Potential solution (if known):**
The MCP tool should properly parse comma-separated file paths, or the documentation should clarify that file_paths expects a JSON array format rather than a comma-separated string. Alternatively, the CLI wrapper could convert comma-separated values to proper JSON arrays before sending to the MCP.

---

## [2026-02-17 02:45 PST] - Initial Documentation Access Was Smooth

**What I was trying to do:**
Access XanoScript documentation to understand the syntax before writing code.

**What the issue was:**
No issues! The xanoscript_docs tool worked well and returned comprehensive documentation for:
- run (for run.job syntax)
- quickstart (for common patterns)
- integrations/external-apis (for api.request patterns)

**Why it was an issue:**
N/A - This worked well.

**Potential solution (if known):**
The documentation is excellent and well-organized. The quickstart guide in particular was very helpful for avoiding common mistakes.

---

## [2026-02-17 02:46 PST] - Syntax Validation Passed First Try

**What I was trying to do:**
Write valid XanoScript code for a Google Calendar integration run job.

**What the issue was:**
No issues! Following the documentation closely, both the run.xs and function/create_calendar_event.xs files passed validation on the first attempt.

**Why it was an issue:**
N/A - The documentation was clear enough to write correct code.

**Potential solution (if known):**
The quickstart documentation's "Common Mistakes" section was particularly valuable. Key things I remembered:
- Use `text` not `string`
- Use `elseif` not `else if`
- Use `params` not `body` for api.request
- Wrap filter expressions in parentheses when concatenating

---

## Summary

Overall experience was positive:
1. Documentation was comprehensive and well-structured
2. The validate_xanoscript tool worked well (once using directory parameter)
3. The syntax is intuitive if you follow the documented patterns
4. Only minor friction with the file_paths parameter format

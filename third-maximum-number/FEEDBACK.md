# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-25 08:35 PST - Sort Filter Syntax Unclear

**What I was trying to do:** Sort an array of integers in descending order to find the third maximum number.

**What the issue was:** I attempted to use `$input.nums|sort:""` based on general filter pattern intuition, but this caused a parse error:
```
[Line 16, Column 34] Expecting --> } <-- but found --> ')' <--
```

The error message wasn't very helpful - it didn't tell me what the correct sort filter syntax should be.

**Why it was an issue:** I couldn't find the correct syntax for the `sort` filter in the available documentation. The `xanoscript_docs` output for syntax/quickstart didn't provide clear filter parameter syntax.

**Potential solution (if known):** 
- Include a complete filter reference with parameter syntax in the documentation
- Better error messages that suggest the correct syntax
- Include common filter examples like sort in the quickstart

**Workaround used:** I implemented a manual bubble sort algorithm instead of using the built-in filter.

---

## 2025-02-25 08:30 PST - MCP Tool Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool.

**What the issue was:** Initially I tried using `files=` parameter but got:
```
Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

I then tried `file_paths=` with a JSON array string which worked, but the parameter naming wasn't intuitive.

**Why it was an issue:** The parameter name `file_paths` (plural with underscore) wasn't the first thing I tried - I expected `files` or just `paths`.

**Potential solution (if known):** 
- Accept multiple parameter names as aliases (files, file_paths, paths)
- Include example tool calls in the documentation output
- Show parameter schema with `mcporter list <server> --schema`

---

## General Feedback

### Positive
- The `xanoscript_docs` tool is very helpful for understanding language constructs
- The validation tool provides clear line/column error locations
- Documentation is comprehensive for most topics

### Suggestions for Improvement
1. **Filter Reference:** A dedicated topic for all available filters with their parameter signatures would be invaluable
2. **More Examples:** More complete, runnable examples in the documentation
3. **Error Messages:** More descriptive errors that suggest fixes, not just identify problems
4. **Validation Output:** When validation succeeds, it would be nice to see a summary of what was validated (function names, entry points, etc.)

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 12:00 PST] - File paths array parameter doesn't work correctly

**What I was trying to do:** Validate multiple XanoScript files at once using the `file_paths` parameter with comma-separated paths.

**What the issue was:** The `file_paths` parameter appears to be splitting the comma-separated string by individual characters instead of by commas. The validation returned 129 "files" which were actually individual characters from my paths:
```
File not found: U
File not found: s
File not found: e
...
```

**Why it was an issue:** I had to make two separate validation calls instead of one batch call, which is less efficient and more verbose.

**Potential solution (if known):** The MCP tool should properly parse comma-separated strings as an array, or the documentation should clarify the expected format (e.g., JSON array syntax like `["path1", "path2"]`).

---

## [2025-02-26 12:00 PST] - Unclear input field description syntax

**What I was trying to do:** Add descriptive metadata to input fields in my function to document what each parameter represents.

**What the issue was:** I assumed the syntax would be similar to other declarative languages where you can add `{ description = "..." }` after a field definition. The XanoScript validator rejected this with a confusing error: "Expecting --> } <-- but found --> '{' <--".

**Why it was an issue:** Without being able to document input fields inline, I have to rely on external documentation (README.md) to explain what each parameter means. The error message also didn't clearly indicate that descriptions aren't supported in input blocks.

**Potential solution (if known):** Either:
1. Support `{ description = "..." }` syntax for input fields (like email fields support `{ sensitive = true }`)
2. Document clearly that input fields cannot have descriptions, only the function itself can have a description
3. Provide a clearer error message like "Description blocks not supported in input field definitions"

---

## [2025-02-26 12:00 PST] - No way to document input parameters in code

**What I was trying to do:** Self-document the function's input parameters within the XanoScript code itself.

**What the issue was:** After removing the invalid description blocks, there's no way to add inline documentation for what `phrf_rating`, `course_distance`, or `elapsed_time_seconds` represent within the code. The function-level `description` field only describes the function as a whole.

**Why it was an issue:** Code maintainability suffers when parameter meanings can only be found in external documentation. Someone reading just the `.xs` file won't understand what valid PHRF ratings are or what units the time should be in.

**Potential solution (if known):** Support for inline comments in XanoScript would help, or allow a `description` property on input fields similar to OpenAPI specification style.
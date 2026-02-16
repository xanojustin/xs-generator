# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 18:17 PST] - validate_xanoscript requires 'code' parameter, not file_path

**What I was trying to do:**
Validate .xs files by providing a file path to the validate_xanoscript tool.

**What the issue was:**
The tool returned error "'code' parameter is required" when passing `file_path`. I had to read the file content and pass it as the `code` parameter instead.

**Why it was an issue:**
This is unintuitive since most validation tools accept file paths. Having to manually read file contents and pass them as a parameter adds extra steps to the workflow.

**Potential solution (if known):**
Support both `file_path` and `code` parameters in validate_xanoscript. If file_path is provided, read the file internally.

---

## [2025-02-15 18:20 PST] - Unclear difference between 'object' and 'json' types

**What I was trying to do:**
Create a function input parameter that accepts a JSON object/payload for the Supabase API request.

**What the issue was:**
Used `object data` in the input block, which caused a parse error: "Expecting --> { <-- but found --> '\n' <--". Changing to `json data` fixed it.

**Why it was an issue:**
The documentation lists both `object` and `json` types but doesn't clearly explain when to use each. The error message was confusing - it suggested a brace was missing when the actual issue was the type choice.

**Potential solution (if known):**
- Clarify in the types documentation that `json` is for arbitrary JSON payloads while `object` requires a schema definition
- Improve error messaging to suggest using `json` type when `object` is used without a schema

---

## [2025-02-15 18:22 PST] - Input descriptions cause parse errors in certain positions

**What I was trying to do:**
Add descriptions to input parameters using the documented syntax:
```xs
text table filters=trim { description = "..." }
```

**What the issue was:**
This syntax caused a parse error: "Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found: 'description'"

**Why it was an issue:**
The documentation shows descriptions should work in braces after the input declaration, but this failed validation. Had to remove descriptions to get validation to pass.

**Potential solution (if known):**
- Verify the documented syntax for input descriptions is correct
- Provide working examples in the quickstart guide

---

## [2025-02-15 18:18 PST] - Shell escaping issues with multi-line code validation

**What I was trying to do:**
Validate XanoScript code containing quotes and special characters via mcporter CLI.

**What the issue was:**
Passing multi-line XanoScript with quotes through shell commands caused escaping issues. Had to carefully manage single vs double quotes and escaping.

**Why it was an issue:**
This makes automated validation workflows fragile. The validate tool should ideally support file path reading to avoid shell escaping complexities.

**Potential solution (if known):**
Support file_path parameter in validate_xanoscript to avoid shell escaping entirely.

---

## General Feedback

**What worked well:**
- The xanoscript_docs tool is comprehensive and well-organized
- Quickstart guide has good common patterns
- Validation errors include line/column numbers which is helpful

**Areas for improvement:**
1. **Type clarity**: Better distinction between `object` and `json` types
2. **File-based validation**: Allow file_path in validate_xanoscript
3. **Error messages**: More specific errors that suggest fixes
4. **Input syntax**: Verify documented input description syntax works as shown

**Tool availability:**
All MCP tools were available and functional. No connection issues.

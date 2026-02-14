# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 15:20 PST] - Validation Tool Parameter Confusion

**What I was trying to do:**
Validate the .xs files using the Xano MCP `validate_xanoscript` tool.

**What the issue was:**
The tool expects a `code` parameter containing the actual code content, not a `filePath` parameter. When I first tried:
```
mcporter call xano.validate_xanoscript filePath="/path/to/file.xs"
```
I got: `Error: 'code' parameter is required`

**Why it was an issue:**
I had to read the file content separately and then pass it as a `code` parameter. This is less convenient than passing a file path, especially for multi-file validation workflows.

**Potential solution (if known):**
Add support for `filePath` parameter as an alternative to `code`, or document the `code` parameter requirement more prominently in the tool description.

---

## [2026-02-14 15:22 PST] - Reserved Variable Name Error

**What I was trying to do:**
Create a function that returns a response object. I used `$response` as a variable name inside the stack block.

**What the issue was:**
Got validation errors:
```
Found 3 error(s):
1. [Line 122, Column 13] '$response' is a reserved variable name and should not be used as a variable.
2. [Line 133, Column 13] '$response' is a reserved variable name and should not be used as a variable.
3. [Line 142, Column 13] '$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
The documentation mentions `$response` is reserved in the syntax section, but it's easy to miss. The error message is clear, but it's a common pattern to use `$response` as a variable name before assigning to `response = ` at the end.

**Potential solution (if known):**
Consider allowing `$response` inside stack blocks but only reserving it for the actual `response = ` statement at the end. Alternatively, provide a linter warning in the documentation examples showing the preferred pattern (e.g., `$result` or `$api_response`).

---

## [2026-02-14 15:15 PST] - Documentation Discovery Process

**What I was trying to do:**
Find the correct XanoScript syntax for run jobs, functions, and API requests.

**What the issue was:**
The `xanoscript_docs` tool has multiple topics but no index or search capability. I had to call it multiple times with different topic names to find what I needed (run, quickstart, functions, integrations).

**Why it was an issue:**
It took 4 separate API calls to gather all the documentation needed. The documentation is comprehensive but scattered across topics.

**Potential solution (if known):**
- Add a search function: `xanoscript_docs({ search: "api.request" })`
- Provide a topic index with brief descriptions
- Consider consolidating related topics (e.g., "run" and "functions" have significant overlap)

---

## [2026-02-14 15:18 PST] - Input Block Default Values Not Clear

**What I was trying to do:**
Understand how to set default values for optional input parameters.

**What the issue was:**
The documentation shows input declarations like `text name?` for optional fields, but doesn't clearly explain how to provide default values or if they're supported in input blocks.

**Why it was an issue:**
I wanted to provide sensible defaults in the run.job input block. The documentation shows:
```xs
input {
  text name filters=trim
  int age? filters=min:0
}
```
But it's unclear if `text name = "default"` or similar syntax is supported.

**Potential solution (if known):**
Add explicit documentation about default values in input blocks, including examples showing both the input definition and how defaults work when the function is called.

---

## [2026-02-14 15:25 PST] - String Concatenation in Headers

**What I was trying to do:**
Build the Authorization header with a dynamic API key from environment variables.

**What the issue was:**
Had to use the `~` concatenation operator: `"Authorization: Klaviyo-API-Key " ~ $env.klaviyo_api_key`

This was documented, but the syntax is unusual compared to other languages that use `+` or template literals.

**Why it was an issue:**
Minor friction - had to look up the concatenation operator. The `~` operator is not commonly used in other languages (PHP uses `.`, JS/Python use `+`).

**Potential solution (if known):**
Not a big issue, but perhaps mention common patterns like header construction in the quickstart examples.

---

## Summary

The Xano MCP and XanoScript documentation are comprehensive and well-structured. The main pain points were:

1. **Tool interface**: The validate tool expecting `code` instead of `filePath` was unexpected
2. **Variable naming**: The reserved `$response` variable caught me off guard despite being documented
3. **Documentation navigation**: Multiple calls needed to gather all relevant docs

Overall, once I found the right documentation, development was straightforward. The syntax is clean and the validation tool is helpful for catching errors early.

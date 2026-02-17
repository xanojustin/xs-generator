# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 14:18 PST] - Array Default Value Syntax Confusion

**What I was trying to do:**
Define an optional array input parameter with an empty array as the default value.

**What the issue was:**
I wrote: `text[] tags?=[]`

This caused a validation error: "Expecting: one of these possible Token sequences... but found: '['"

The error message didn't clearly indicate that array default values aren't supported in the same way as scalar types.

**Why it was an issue:**
I had to remove the default value entirely and handle the null case in the stack code instead. This added extra boilerplate code that shouldn't be necessary.

**Potential solution (if known):**
Either:
1. Support array literal syntax in input defaults (e.g., `text[] tags?=[]` or `text[] tags?={}`)
2. Document clearly that array types cannot have default values in the `types` documentation
3. Provide a better error message specifically for this case

---

## [2026-02-17 14:22 PST] - Reserved Variable Name Error for $response

**What I was trying to do:**
Create a variable named `$response` to build the function response data before returning it.

**What the issue was:**
Got error: "'$response' is a reserved variable name and should not be used as a variable."

While the error message was helpful and even suggested an alternative name (`$my_response`), I had already forgotten that `$response` was in the reserved list from the quickstart documentation.

**Why it was an issue:**
`$response` is a natural name to use when building a response object. The error was caught at validation time, which is good, but it's an easy mistake to make because the name is semantically appropriate.

**Potential solution (if known):**
- Add `$response` to a "Common Mistakes" section in the `types` or `syntax` documentation since it's such a natural variable name to reach for
- Consider allowing `$response` as a local variable since it's only used at the function level for the actual response assignment

---

## [2026-02-17 14:15 PST] - MCP Parameter Passing with Arrays

**What I was trying to do:**
Validate multiple files using the `file_paths` parameter with comma-separated values.

**What the issue was:**
The first attempt with `--file-paths path1,path2` combined the paths into a single string, causing a parse error where the validator tried to parse the file paths as XanoScript code.

**Why it was an issue:**
The CLI parameter format wasn't clear. I had to switch to using `directory` parameter instead.

**Potential solution (if known):**
Document the proper CLI format for array parameters. The `--file-paths` flag might need different syntax (maybe multiple flags or JSON array format).

---

## [2026-02-17 14:16 PST] - Home Directory Path Expansion

**What I was trying to do:**
Use `~/xs/...` paths with the validation tool.

**What the issue was:**
The MCP tool doesn't expand `~` to the home directory. Using `~/xs/datadog-submit-metric` resulted in "No .xs files found in directory".

**Why it was an issue:**
Had to use the full absolute path `/Users/justinalbrecht/xs/...` instead of the convenient `~` shorthand.

**Potential solution (if known):**
Add shell-style tilde expansion to path parameters in the MCP server.

---

## General Observations

**What's Working Well:**
- The validation tool provides helpful error messages with line/column numbers
- The suggestions for reserved variable names are very useful
- The documentation is comprehensive and well-organized

**Documentation Gaps:**
- The `types` documentation should explicitly state what default values are supported for each type
- More examples of array handling in the quickstart would be helpful
- The difference between `json` type and `object` type with schema could be clearer

**Tool Feedback:**
The MCP server worked reliably once I understood the parameter formats. The validation is fast and catches errors that would be hard to debug at runtime.

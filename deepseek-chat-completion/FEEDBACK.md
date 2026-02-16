# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 14:50 PST - Issue: Default Values in Input Blocks

**What I was trying to do:**
Create a function with optional input parameters that have default values (e.g., `default = "deepseek-chat"` for a model parameter).

**What the issue was:**
The validator returned errors saying "The argument 'default' is not valid in this context" and "Expected value of `default` to be `null`". This indicates that the `default` keyword I thought would work for input parameters is not supported in XanoScript input blocks.

**Why it was an issue:**
This forced me to move default value handling into the stack block using manual conditional checks with ternary operators, which is more verbose and less declarative than having defaults in the input block.

**Potential solution (if known):**
- Either add support for `default` in input blocks (if not already planned)
- Or document the recommended pattern for handling optional parameters with defaults (using var declarations in stack)

---

## 2025-02-16 14:52 PST - Issue: Optional Chaining Operator Not Supported

**What I was trying to do:**
Safely access nested properties that might not exist using the optional chaining operator (`?.`), like `$api_response.response.result.error?.message`.

**What the issue was:**
The validator threw an error: "Expecting: one of these possible Token sequences... but found: '.'" - indicating that `?.` is not valid syntax in XanoScript.

**Why it was an issue:**
I had to remove the elegant optional chaining and instead just use a simpler error message without trying to extract the API's error message. This reduces the quality of error reporting.

**Potential solution (if known):**
- Add support for optional chaining (`?.`) and nullish coalescing (`??`) operators
- Or provide an alternative function like `object.get($obj, "path", "default")` for safe property access

---

## 2025-02-16 14:55 PST - Issue: MCP Parameter Format Confusion

**What I was trying to do:**
Call the `validate_xanoscript` tool with the `file_path` parameter.

**What the issue was:**
I initially tried various formats like JSON params `'{"file_path": "/path"}'` and `--file_path /path` which didn't work. The correct format appears to be `key=value` without quotes or dashes.

**Why it was an issue:**
This caused several failed attempts before finding the right syntax. The error messages were not helpful - one even suggested it was parsing `--file_path` as code rather than a parameter.

**Potential solution (if known):**
- Document the expected parameter format for mcporter calls more clearly
- Or provide more helpful error messages when parameter format is wrong

---

## 2025-02-16 14:45 PST - Issue: Documentation for Run Jobs Lacking

**What I was trying to do:**
Understand the proper structure for a `run.job` construct by calling `xanoscript_docs({ topic: "run" })`.

**What the issue was:**
The documentation returned was the same general documentation without specific syntax details for run jobs. I had to examine existing implementations to understand the structure.

**Why it was an issue:**
Without specific run job documentation, I had to infer the syntax from examples, which may lead to incorrect assumptions.

**Potential solution (if known):**
- Add specific documentation for the `run.job` construct syntax
- Include examples of valid run.job configurations

---

## Summary

Overall, the validation tool was very helpful once I understood how to use it. The error messages were generally clear about what was wrong with the code. The main struggles were:

1. Lack of clarity on what syntax is/isn't supported (defaults, optional chaining)
2. Documentation gaps for specific constructs like run.job
3. Parameter format confusion for the MCP tool itself

The validation tool caught all issues before deployment, which is exactly what you want from such a tool.

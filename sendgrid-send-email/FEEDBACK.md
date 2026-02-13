# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 10:45 PST - MCP Tool Parameter Naming Inconsistency

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool from the Xano MCP.

**What the issue was:**
The tool expects a `code` parameter but I initially tried to use `file_path` (which is a common pattern for validation tools). The error message said "Error: 'code' parameter is required" which wasn't immediately clear that I needed to pass the actual code content rather than a file path.

**Why it was an issue:**
This required extra steps to read the file content and pass it as a parameter. Most validation tools accept either file paths or code content. The documentation didn't clearly indicate which parameter to use.

**Potential solution:**
- Support both `code` and `file_path` parameters for convenience
- Or improve the error message to say something like: "Parameter 'code' is required. Pass the XanoScript code content as a string."

---

## 2026-02-13 10:47 PST - String Concatenation Syntax Confusion

**What I was trying to do:**
Concatenate strings for error messages and email content in XanoScript.

**What the issue was:**
The documentation shows the `~` operator for string concatenation but doesn't clearly show examples of multiple concatenations in sequence. I had to infer that `~` works like: `"text" ~ $variable ~ "more text"`

**Why it was an issue:**
Had to look through multiple documentation sections to confirm the concatenation pattern works in a chain.

**Potential solution:**
Add a clear example in the syntax docs showing chained concatenation:
```xs
var $full_message { value = "Status: " ~ $status ~ ", Error: " ~ $error }
```

---

## 2026-02-13 10:48 PST - Conditional Block Syntax Clarity

**What I was trying to do:**
Set a variable inside a conditional block and have it accessible outside the block.

**What the issue was:**
I wasn't sure if variables declared inside a `conditional { if () { ... } }` block would be accessible outside. The documentation doesn't explicitly state the scoping rules for conditional blocks.

**Why it was an issue:**
Had to assume based on the function documentation which mentions that `group` blocks don't create new scope. I assumed conditionals work similarly but wasn't 100% sure.

**Potential solution:**
Add a section to the syntax documentation clearly explaining variable scoping rules for:
- `conditional` blocks
- `foreach` loops
- `try_catch` blocks
- `group` blocks

---

## 2026-02-13 10:50 PST - No Validation for Required Environment Variables

**What I was trying to do:**
Understand if XanoScript validates that required environment variables are set before running.

**What the issue was:**
The `run.job` allows specifying `env = ["var1", "var2"]` but there's no indication if Xano validates these exist before execution, or if the job will just fail at runtime when `$env.var` is accessed.

**Why it was an issue:**
Unclear whether I need to add manual validation in my function code or if Xano handles this automatically.

**Potential solution:**
Clarify in the `run` documentation whether the `env` array is:
1. Just documentation/declarative
2. Validated before execution
3. Used for something else

---

## 2026-02-13 10:52 PST - API Response Handling Documentation

**What I was trying to do:**
Access the HTTP response status code and body from an `api.request` call.

**What the issue was:**
While the integrations documentation shows the response structure, it wasn't immediately obvious that I need to access `$api_result.response.status` and `$api_result.response.result`. I had to read through the JSON example carefully.

**Why it was an issue:**
The example response structure is shown in JSON format but there's no explicit XanoScript example showing how to access these fields.

**Potential solution:**
Add a clear XanoScript example right after the JSON structure:
```xs
api.request { ... } as $result
var $status { value = $result.response.status }
var $body { value = $result.response.result }
```

---

## 2026-02-13 10:55 PST - SendGrid API Payload Structure Complexity

**What I was trying to do:**
Build the correct JSON payload for SendGrid's v3 Mail Send API.

**What the issue was:**
SendGrid requires a fairly complex nested structure with `personalizations`, `from`, and `content` arrays/objects. Constructing this in XanoScript required multiple `var` statements to build nested objects.

**Why it was an issue:**
The XanoScript syntax for building complex nested objects is verbose. I had to create intermediate variables for arrays and objects.

**Potential solution:**
Not really an MCP issue, but it would be nice if XanoScript supported inline object/array construction more elegantly, perhaps:
```xs
var $payload {
  value = {
    personalizations: [{to: [{email: $input.to}]}],
    from: {email: $from_email},
    // ...
  }
}
```
Actually, this might already work - the documentation isn't clear on inline construction of nested objects.

---

## Summary

Overall, the Xano MCP worked well:
- ✅ `xanoscript_docs` topic retrieval is excellent
- ✅ Validation tool catches syntax errors
- ✅ Tool availability was instant (already configured)

Main areas for improvement:
1. Better parameter naming/documentation for `validate_xanoscript`
2. More explicit scoping documentation
3. Clearer examples for API response handling
4. Validation of environment variables at parse time

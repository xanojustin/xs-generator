# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 06:18 PST] - Reserved Variable Name Error

**What I was trying to do:**
Create a XanoScript function that returns a response object after making an API call.

**What the issue was:**
The validation failed with: `'$response' is a reserved variable name and should not be used as a variable.`

I initially wrote:
```xs
var $response {
  value = {
    success: true,
    tweet_id: $api_result.response.result.data.id,
    text: $api_result.response.result.data.text,
    created_at: now
  }
}
// ...
response = $response
```

**Why it was an issue:**
The variable name `$response` conflicts with the reserved keyword `response` used in the function block. This wasn't obvious from the quickstart documentation, and the error only appeared during validation.

**Potential solution (if known):**
Add a note in the quickstart documentation about reserved variable names, or provide a list of reserved keywords that cannot be used as variable names. Common reserved words like `response`, `input`, `stack`, `env` should be highlighted.

---

## [2026-02-16 06:19 PST] - Throw Statement Syntax Ambiguity

**What I was trying to do:**
Create error handling with throw statements that include both a name and a value.

**What the issue was:**
The validation failed with: `Expecting --> } <-- but found --> ',' <--`

I initially wrote:
```xs
throw {
  name = "AuthenticationError",
  value = "Invalid X API credentials. Check your access token."
}
```

**Why it was an issue:**
I assumed XanoScript uses commas to separate properties like JSON or JavaScript object notation. However, XanoScript uses newlines as separators, not commas.

**Potential solution (if known):**
- Add a clear example of `throw` statement syntax in the quickstart guide
- Include a syntax comparison showing "Common mistakes" for developers coming from JavaScript/JSON backgrounds
- The `throw` documentation should explicitly state that commas are not used as separators

---

## [2026-02-16 06:15 PST] - MCP Documentation Discovery

**What I was trying to do:**
Find the XanoScript syntax documentation to write correct code.

**What the issue was:**
The user prompt emphasized that I "do NOT know XanoScript syntax" and "MUST call `xanoscript_docs`". However, discovering the correct topic names and understanding the documentation structure required trial and error.

I had to:
1. First call `xanoscript_docs` with no parameters to get the README
2. Then discover specific topics like "run" for run.job documentation
3. Call "quickstart" for common patterns

**Why it was an issue:**
The documentation is comprehensive but finding the right topic requires knowing the topic names in advance. The initial README lists topics but doesn't explain what each contains in enough detail to choose without multiple calls.

**Potential solution (if known):**
- Provide a brief description of each topic's content in the initial README
- Consider adding a search or recommend functionality to the docs tool
- Add a "getting started for AI assistants" topic that covers the most common patterns

---

## [2026-02-16 06:16 PST] - Conditional Block elseif Syntax

**What I was trying to do:**
Write a conditional block with multiple elseif branches for different HTTP status codes.

**What the issue was:**
I initially wasn't sure if the syntax was `else if` or `elseif`. The quickstart mentions this as a "Common Mistake" but I had to actively look for it.

**Why it was an issue:**
Many languages use `else if` (JavaScript, C, Java) while others use `elseif` (PHP, XanoScript). Without explicit guidance upfront, this is an easy syntax error to make.

**Potential solution (if known):**
The quickstart already mentions this as a common mistake - this is good! Consider adding syntax highlighting or visual distinction for XanoScript keywords in documentation to make them stand out.

---

## General Observations

1. **Validation is helpful**: The validation tool caught my errors quickly and provided line/column numbers, which was excellent for fixing issues.

2. **Error messages could be more descriptive**: The "reserved variable name" error could suggest alternative names or explain *why* it's reserved.

3. **Documentation is well-structured**: Once I found the right topics, the documentation was clear and comprehensive with good examples.

4. **File-based validation workflow**: Having to read file contents and pass to the validate tool is a bit cumbersome. It would be helpful if the MCP could validate files by path.

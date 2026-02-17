# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 02:17 PST] - Limited Run Documentation

**What I was trying to do:**
Understand how to create a proper run.job structure for a Dropbox file upload.

**What the issue was:**
The `run` documentation only provides very basic examples with minimal syntax details. When calling `xanoscript_docs({ topic: "run" })`, the quick reference only shows:
- Basic directory structure
- Simple job definition syntax
- No advanced patterns or edge cases

**Why it was an issue:**
Had to piece together information from multiple documentation topics (run + functions + integrations/external-apis) to understand the full picture. For a complete run job, you need to understand:
1. How to define the run.job in run.xs
2. How to write a function in function/*.xs
3. How to make API requests
4. How to handle responses and errors

Each of these is documented separately, making it hard to get a cohesive understanding.

**Potential solution (if known):**
Provide a complete end-to-end example in the run documentation that includes:
- A full run.xs with function call
- A complete function definition with API requests
- Error handling patterns
- Environment variable usage

---

## [2026-02-17 02:18 PST] - Unclear Headers Syntax in api.request

**What I was trying to do:**
Construct proper headers for the Dropbox API request, which requires multiple headers including an Authorization Bearer token and a complex Dropbox-API-Arg header with JSON content.

**What the issue was:**
The documentation says headers should be an "array of text strings" with the format `name: value`, but doesn't provide clear examples of:
- How to handle string concatenation within headers
- How to properly escape quotes in headers that contain JSON
- Whether headers support template expressions

**Why it was an issue:**
For the Dropbox API, I needed to create a header like:
```
Dropbox-API-Arg: {"path": "/file.txt", "mode": "add"}
```

It was unclear if string concatenation (`~`) works inside header strings, or if I needed to build the header value separately first.

**Potential solution (if known):**
Add more header examples showing:
- Dynamic header values with string concatenation
- Headers containing JSON
- Multi-line header construction patterns

---

## [2026-02-17 02:19 PST] - Limited Error Handling Documentation

**What I was trying to do:**
Add proper error handling for the Dropbox API upload with specific status code checking.

**What the issue was:**
The quickstart mentions `precondition` blocks but doesn't clearly explain:
- All available error_type options
- How to include dynamic data in error messages
- Whether response checking should use `==` or other operators

**Why it was an issue:**
I wanted to include the actual API error response in the error message for debugging, like:
```xs
error = "Dropbox upload failed: " ~ ($upload_result.response.result|json_encode)
```

But wasn't sure if filters like `json_encode` work inside error messages or if they need to be pre-computed.

**Potential solution (if known):**
Expand the precondition/error handling documentation with:
- All error_type values and their HTTP status codes
- Examples showing dynamic error messages
- Best practices for API error handling

---

## [2026-02-17 02:20 PST] - Confusing File Reference for xanoscript_docs

**What I was trying to do:**
Initially tried to use the `file_path` parameter with `xanoscript_docs` to get context-aware documentation.

**What the issue was:**
The documentation says `file_path` can be used for "context-aware docs based on the file you're editing", but doesn't explain:
- What "context-aware" actually returns
- How it differs from topic-based documentation
- Whether it automatically detects the file type and returns relevant docs

**Why it was an issue:**
I thought I could get run-job-specific documentation by passing `file_path: "run.xs"`, but it wasn't clear what this would return versus using `topic: "run"`.

**Potential solution (if known):**
Clarify the difference between:
- `topic` parameter (returns docs for a specific documentation section)
- `file_path` parameter (returns docs relevant to a specific file type based on path pattern)
- When to use each approach

---

## Overall Assessment

The Xano MCP validation tool worked perfectly - it immediately identified my files as valid. The main friction was in understanding the XanoScript syntax patterns for:
1. API request construction with dynamic headers
2. String concatenation with filters in expressions
3. Error handling patterns

The documentation provides individual pieces but lacks cohesive "real-world" examples that show these concepts working together.

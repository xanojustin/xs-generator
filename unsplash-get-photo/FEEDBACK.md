# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 08:50 PST] - Documentation Discovery Challenge

**What I was trying to do:**
Find documentation on how to write XanoScript code for a run job, specifically looking for API request syntax and function definitions.

**What the issue was:**
The `xanoscript_docs` tool has many topics but I had to call it multiple times to find the right information. I initially called with topic="run" which gave me the run job structure, but I needed additional calls to get function syntax and API request patterns. There wasn't a single comprehensive reference.

**Why it was an issue:**
Had to make 4 separate documentation calls (run, functions, syntax, integrations) to gather enough information to write a simple HTTP API call. This was time-consuming and the context window filled up with overlapping documentation.

**Potential solution (if known):**
Consider adding a "complete" or "all" mode that returns essential docs for a specific file type. For example, when I specify `file_path="run.xs"`, it could automatically include relevant function and syntax docs together.

---

## [2026-02-14 08:52 PST] - Syntax Validation Worked Well

**What I was trying to do:**
Validate the XanoScript files I created using the `validate_xanoscript` tool.

**What the issue was:**
No issues! The validation worked perfectly on the first try for both files. The tool gave clear "XanoScript is valid" messages.

**Why it was an issue:**
N/A - This worked well.

**Potential solution (if known):**
Keep this as-is. The validation tool is helpful and fast.

---

## [2026-02-14 08:55 PST] - Example Code Gaps in Documentation

**What I was trying to do:**
Understand the exact syntax for `api.request` calls, specifically how to structure headers and handle the response object.

**What the issue was:**
The syntax documentation mentions `api.request` in passing but doesn't have a dedicated section showing the full syntax with all available properties (url, method, headers, params, body, etc.) and what the response object structure looks like.

**Why it was an issue:**
I had to infer the correct syntax by looking at the existing Stripe example in the ~/xs folder rather than from official documentation. This worked but isn't ideal for new users without existing examples.

**Potential solution (if known):**
Add a dedicated "HTTP Requests" or "API Integration" topic to xanoscript_docs that covers:
- Full api.request syntax
- Response object structure
- Common patterns for REST API calls
- Error handling patterns

---

## [2026-02-14 08:58 PST] - String Concatenation Documentation Confusion

**What I was trying to do:**
Concatenate strings to build a URL with query parameters for the Unsplash API call.

**What the issue was:**
The documentation mentions the `~` operator for string concatenation but buries the important note about parentheses when using filters. I initially wrote:
```
value = "https://..." ~ $input.query|url_encode ~ "&orientation=..."
```

**Why it was an issue:**
Without the parentheses around filtered expressions, this would cause a parse error. The note about parentheses exists but is easy to miss in the quick reference section.

**Potential solution (if known):**
Make the parentheses requirement more prominent, perhaps with a warning box or at the top of the string operators section. Consider adding examples specifically for URL construction with encoded parameters since this is a very common use case.

---

## Overall Assessment

The Xano MCP is functional and the validation tool works great. The main friction points are:
1. Documentation is spread across multiple topics requiring multiple calls
2. Some practical patterns (like HTTP requests) lack dedicated documentation
3. Some syntax rules that cause common errors could be more prominently featured

The MCP successfully validated my code and I was able to complete the task, but it took more exploration than expected.

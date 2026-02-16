# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 10:47 PST] - Reserved Variable Name Error

**What I was trying to do:**
Create a function that returns a response object with email sending results.

**What the issue was:**
I named my result variable `$response` which is a reserved variable name in XanoScript. The validation failed with:
```
[Line 71, Column 9] '$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
The error message was helpful and suggested using `$my_response` instead, but I had to run validation to discover this. It would be nice to have a more prominent warning about reserved variables in the documentation or a linter that catches this before validation.

**Potential solution (if known):**
- Consider adding a "reserved words" section to the quickstart documentation
- An IDE extension that highlights reserved variable names would be very helpful

---

## [2026-02-16 10:45 PST] - Initial Syntax Uncertainty

**What I was trying to do:**
Write the initial XanoScript code for the run job and function.

**What the issue was:**
The task instructions explicitly stated "You do NOT know XanoScript syntax" and "Your training data does not include XanoScript." This was accurate - I had to rely entirely on the MCP documentation.

**Why it was an issue:**
While the `xanoscript_docs` MCP tool is comprehensive, I needed to make multiple calls to get:
1. Run job documentation
2. Quickstart/common patterns
3. Function documentation

Each call took time and consumed tokens. It would be more efficient if there was a single "getting started" document or a consolidated reference.

**Potential solution (if known):**
- A single `xanoscript_docs topic=starter-kit` that returns a condensed version of the most critical patterns
- Example: run.job + function structure in one document

---

## [2026-02-16 10:46 PST] - API Request Body Parameter Confusion

**What I was trying to do:**
Make an HTTP POST request to SendGrid's API with a JSON body.

**What the issue was:**
My instinct was to use a `body` parameter for the request payload, but XanoScript uses `params` instead. This is counter-intuitive for developers coming from other HTTP client libraries.

**Why it was an issue:**
Even though the quickstart documentation explicitly warns about this (`Using `body` instead of `params` for api.request`), it's easy to miss if you're skimming. I would have made this mistake if I hadn't carefully read the "Common Mistakes" section.

**Potential solution (if known):**
- Consider supporting both `body` and `params` as aliases for the same thing
- Or add a clearer error message when `body` is used: "Did you mean 'params'? XanoScript uses 'params' for request body."

---

## [2026-02-16 10:46 PST] - Documentation Navigation

**What I was trying to do:**
Find specific syntax for object property access and the proper way to concatenate strings with filters.

**What the issue was:**
The documentation is well-organized by topic, but finding specific syntax details requires knowing which topic contains what. For example, string concatenation with filters is in the `syntax` topic, but I initially looked in `quickstart`.

**Why it was an issue:**
There's no search functionality in the MCP tool. I had to either:
1. Request full documentation (large token cost)
2. Guess which topic contains what I need
3. Make multiple requests until I find it

**Potential solution (if known):**
- Add a search tool: `xanoscript_search query="string concatenation filters"`
- Or create an index document that maps common patterns to their documentation topics

---

## [2026-02-16 10:47 PST] - Validation Success

**What I was trying to do:**
Validate all .xs files after fixing the reserved variable name.

**What the issue was:**
None! The validation worked perfectly and gave clear output.

**Why it was helpful:**
The validation tool:
- Correctly identified the file with errors
- Provided line/column numbers
- Suggested a fix
- Showed which files passed

This was a positive experience with the MCP.

---

## Summary

The Xano MCP and documentation are comprehensive and well-structured. The main friction points were:

1. **Learning curve**: Needing to make multiple documentation calls to piece together a complete picture
2. **Common mistakes**: Easy to fall into patterns from other languages (like `body` vs `params`)
3. **Reserved words**: Not immediately obvious which variable names are reserved

The validation tool is excellent and caught my error quickly with a helpful suggestion. Overall, once the patterns are learned, XanoScript feels intuitive and the documentation is thorough.

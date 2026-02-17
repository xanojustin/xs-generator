# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 00:15 PST] - Issue: Optional Input Default Value Syntax

**What I was trying to do:**
Create an optional input parameter with a default value for the namespace parameter in my Pinecone function.

**What the issue was:**
I initially wrote the input parameter with `default` as a property inside the braces:
```xs
text? namespace { description = "Optional namespace for the vector", default = "default" }
```

This caused a validation error:
```
[Line 7, Column 74] The argument 'default' is not valid in this context
Expected value of `default` to be `null`
```

**Why it was an issue:**
The error message was confusing because it said 'default' is not valid, but the documentation shows that default values are supported. The error didn't explain the correct syntax.

**Potential solution (if known):**
The correct syntax is to put the default value immediately after the `?`:
```xs
text? namespace="default" { description = "Optional namespace for the vector" }
```

The MCP validation error could be improved to say something like:
"For optional inputs with default values, use `text? name=\"value\"` instead of putting `default` inside the braces."

---

## [2025-02-17 00:15 PST] - Issue: Vector Type Uncertainty

**What I was trying to do:**
Define an input parameter for an array of floating-point numbers (vector embeddings).

**What the issue was:**
I wasn't sure which type to use for vector embeddings. I saw `vector` in the types documentation and assumed it meant "array of floats/numbers for ML embeddings". But I wasn't 100% certain if `vector` was the right type or if I should use `decimal[]` or `json`.

**Why it was an issue:**
The types documentation lists `vector` as a type but doesn't clearly explain what it represents. In ML/AI contexts, "vector" usually means an embedding (array of floats), but it could also mean a 2D/3D coordinate or other things.

**Potential solution (if known):**
Add more detail to the `vector` type in the documentation:
- What it's typically used for (embeddings, ML vectors)
- What underlying format it expects (array of decimals?)
- Example usage

---

## [2025-02-17 00:15 PST] - Issue: No `body` Parameter for api.request

**What I was trying to do:**
Make a POST request with a JSON body to the Pinecone API.

**What the issue was:**
Initially, I instinctively tried to use `body = $payload` for the request body, but the XanoScript uses `params` instead of `body`. This is counterintuitive since most HTTP libraries use `body` for POST/PUT request payloads.

**Why it was an issue:**
Muscle memory from other languages (JavaScript fetch, Python requests, etc.) all use `body` or `data` for the request payload. Using `params` for the body is unexpected and the name suggests query parameters, not request body.

**Potential solution (if known):**
The documentation does mention this, but perhaps the MCP could provide a helpful warning/suggestion when validating:
"Note: XanoScript uses `params` for request body in POST/PUT/PATCH requests, not `body`."

Or consider allowing `body` as an alias for `params` to reduce confusion for developers coming from other languages.

---

## [2025-02-17 00:15 PST] - Positive Feedback: Documentation via MCP

**What worked well:**
The `xanoscript_docs` tool was very helpful! Being able to query specific topics (run, types, syntax, quickstart) with both `full` and `quick_reference` modes made it easy to get the information I needed without loading unnecessary content.

**What made it good:**
- Clear topic organization
- Quick reference mode for efficient context usage
- The quickstart had common mistakes section which helped avoid errors
- Validation tool gives specific line/column errors

**Suggestion for improvement:**
Consider adding a "migration guide" or "coming from JavaScript/Python" section to the quickstart that maps common patterns from other languages to XanoScript equivalents.

---

## Summary

Overall, the Xano MCP server worked well for this task. The validation tool caught my syntax error, and the documentation tools provided the information I needed to fix it. The main pain points were:

1. Unclear error message for optional input default value syntax
2. Uncertainty about the `vector` type's purpose
3. `params` vs `body` naming confusion (though documented)

The run job was successfully created and validated after fixing the syntax issue.
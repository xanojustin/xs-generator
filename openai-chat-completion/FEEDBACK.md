# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 11:48 PST - api.request payload parameter issue

**What I was trying to do:**
Create an OpenAI API integration using `api.request` to send a POST request with a JSON body containing the chat completion parameters (model, messages, temperature, max_tokens).

**What the issue was:**
I initially tried to use `payload = $payload` to pass the JSON body to the `api.request` statement, following common patterns from other programming languages. The validation failed with:
```
1. [Line 39, Column 7] The argument 'payload' is not valid in this context
2. [Line 39, Column 17] Expecting: Expected a null but found: '$payload'
```

**Why it was an issue:**
The `api.request` documentation in the integrations topic shows:
```xs
api.request {
  url = "https://api.example.com/data"
  method = "POST"
  params = { key: "value" }
  headers = ["Content-Type: application/json", "Authorization: Bearer " ~ $env.API_KEY]
  timeout = 30
} as $api_result
```

However, it wasn't clear whether `params` was for query parameters or the request body. In many HTTP client libraries, `params` refers to URL query parameters, while `body` or `payload` refers to the POST body. I had to guess that `params` might work for the POST body.

**Potential solution (if known):**
- Clarify in the documentation whether `params` is used for both query strings (GET) and request bodies (POST/PUT), or if there's a separate parameter for the body
- If `params` is the correct way to pass JSON bodies for POST requests, explicitly document this behavior
- Consider adding a `body` parameter alias for clarity, since many developers expect `body` or `payload` for POST data

---

## 2026-02-13 11:50 PST - JSON response parsing uncertainty

**What I was trying to do:**
Extract data from the OpenAI API JSON response, specifically accessing nested fields like `choices[0].message.content`.

**What the issue was:**
The documentation shows the response structure includes `response.result` which "can be any format: JSON, string, null, boolean, etc." It wasn't clear if XanoScript automatically parses JSON responses or if manual parsing is needed.

I assumed it auto-parses and tried `$api_result.response.result.choices|first`, but wasn't 100% certain this would work without testing.

**Why it was an issue:**
Without being able to run the code, I had to make assumptions about how JSON responses are handled. If the response doesn't auto-parse, the code would fail at runtime.

**Potential solution (if known):**
- Clarify in the integrations documentation whether `api.request` automatically parses JSON responses or if a `json_decode` filter is required
- Provide a complete example showing JSON POST request and JSON response handling in one example

---

## 2026-02-13 11:45 PST - Documentation discovery workflow

**What I was trying to do:**
Find the correct syntax for creating a run job and external API calls.

**What the issue was:**
The `xanoscript_docs` tool has many topics, and I had to make multiple calls to find the relevant information:
1. First `readme` for general structure
2. Then `run` for run job syntax
3. Then `functions` for function syntax
4. Then `integrations` for external API calls

**Why it was an issue:**
While the documentation is comprehensive, discovering the right topics requires some exploration. It wasn't immediately obvious that external API documentation would be under "integrations" rather than something like "http" or "external".

**Potential solution (if known):**
- Consider adding a "quickstart" or "common_patterns" topic that shows frequently-used patterns like "make an external API call" complete with imports, functions, and run jobs
- The existing documentation is excellent once you find the right topic, but a higher-level guide could help developers get started faster

---

## General Feedback

### What worked well:
- The Xano MCP validation tool is extremely helpful for catching syntax errors
- Documentation is comprehensive and well-structured once you find the right topic
- Error messages from validation are specific (line/column numbers, clear descriptions)

### Suggestions:
1. Add more complete examples showing end-to-end patterns (external API call → parse response → return data)
2. Consider a "migration guide" for developers coming from other languages who might expect parameters like `body`, `payload`, `json` etc.
3. The `validate_xanoscript` tool could potentially be enhanced to warn about common mistakes (like using `payload` instead of `params`)

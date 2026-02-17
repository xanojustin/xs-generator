# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 13:48 PST] - Pusher Event Trigger Implementation

**What I was trying to do:**
Create a XanoScript run job that triggers real-time events on Pusher channels using their REST API.

**What the issue was:**
Initially, I was uncertain about the proper way to handle optional parameters in XanoScript. I wanted to conditionally add the `socket_id` parameter only when it's provided, but wasn't sure about the best pattern for building objects with optional fields.

**Why it was an issue:**
The Pusher API requires specific payload structure, and I needed to ensure the `socket_id` field was only included in the request body when explicitly provided (for excluding the sender from receiving their own event). Including it as null or empty string might cause API errors.

**Potential solution (if known):**
The documentation on optional field handling could be clearer. I eventually used a conditional block with `var.update` and `set` filter, which works well but took some trial and error to figure out. A dedicated section on "Building objects with optional fields" in the quickstart would be helpful.

---

## [2025-02-17 13:48 PST] - JSON Encoding for API Payloads

**What I was trying to do:**
Send a JSON object as the `data` field in the Pusher API request. Pusher expects the `data` field to be a JSON-encoded string within the JSON payload.

**What the issue was:**
I needed to JSON-encode the `data` object before sending it to Pusher. I wasn't sure if XanoScript would automatically handle nested JSON encoding or if I needed to explicitly use the `json_encode` filter.

**Why it was an issue:**
The Pusher API documentation specifies that the `data` field should be a string containing JSON, not a nested JSON object. Getting this wrong would result in malformed events being delivered to clients.

**Potential solution (if known):**
More examples in the external API documentation showing how to handle APIs that require JSON strings as field values (not just JSON objects) would be valuable. The `json_encode` filter works perfectly, but I had to search to confirm it existed.

---

## [2025-02-17 13:48 PST] - API Authorization Header Format

**What I was trying to do:**
Authenticate with the Pusher REST API using their key:secret format in the Authorization header.

**What the issue was:**
Pusher uses a specific authorization format: `Authorization: Bearer <key>:<secret>`. I needed to construct this header using string concatenation with the `~` operator and access environment variables via `$env`.

**Why it was an issue:**
While the string concatenation syntax is documented, combining it with environment variable access for API authentication is a common pattern that would benefit from a specific example. The `~` operator for concatenation is mentioned but easy to miss.

**Potential solution (if known):**
Add a dedicated example in the external APIs documentation showing:
1. How to construct Authorization headers with dynamic values
2. How to use `$env` variables in headers
3. String concatenation patterns for common auth schemes (Bearer, Basic, API Key)

---

## [2025-02-17 13:48 PST] - Positive Feedback: Validation Tool

**What I was trying to do:**
Validate my XanoScript files before committing.

**What worked well:**
The `validate_xanoscript` tool worked flawlessly! It correctly identified both files and reported them as valid with clear output. The batch directory validation feature is particularly useful for CI/CD workflows.

**Why it matters:**
Having immediate feedback on syntax errors without needing to deploy to Xano significantly speeds up development. The tool's speed (1.2s response time) is excellent.

**Suggestion:**
Consider adding a `watch` mode or pre-commit hook example for local development workflows.

---

## Summary

Overall, the MCP server and XanoScript documentation worked well for this implementation. The main areas for improvement are:

1. **More examples for optional field patterns** - Building objects conditionally is a common need
2. **JSON encoding guidance for API payloads** - When to use `json_encode` vs letting the system handle it
3. **Authentication header patterns** - Common auth schemes with environment variables
4. **Quick reference card** - A one-page PDF or markdown file with the 20 most common patterns would be incredibly useful to keep open while coding

The tooling itself is solid and the documentation is comprehensive. The main friction points are around finding the *right* pattern quickly rather than missing functionality.

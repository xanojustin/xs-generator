# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 19:47 PST] - API Request Body Parameter Confusion

**What I was trying to do:**
Create a run job that makes a POST request to Linear's GraphQL API with a JSON body containing the GraphQL query.

**What the issue was:**
I initially used `body = $request_body|json_encode` in the `api.request` block, following intuition from other programming languages where you explicitly set a request body.

The validation error said:
- `The argument 'body' is not valid in this context`
- Suggestion said to use `"params" instead of "body" for api.request request body`

However, this was confusing because:
1. The validation error said `body` is not valid, but the suggestion still referred to "request body" - which made me think I was on the right track conceptually
2. The Stripe example uses `params` for form-encoded data (Stripe uses `application/x-www-form-urlencoded`)
3. It wasn't clear if `params` was for query parameters, form data, or JSON body

**Why it was an issue:**
The documentation didn't clearly explain that `params` is the universal parameter for ALL request body types (form-encoded, JSON, etc.) and that XanoScript automatically handles the encoding based on the Content-Type header. I had to look at the OpenAI example to understand this pattern.

**Potential solution (if known):**
- Add clearer documentation that `params` handles both form-encoded and JSON request bodies
- The validation error could explicitly say: "Use `params` instead of `body` for the request payload"
- Include a note in the syntax docs about `api.request` specifically

---

## [2025-02-16 19:42 PST] - Finding Correct API Request Syntax

**What I was trying to do:**
Understand the correct way to make HTTP requests with JSON payloads in XanoScript.

**What the issue was:**
The `xanoscript_docs` tool with `topic=integrations` only returned cloud storage and search-related documentation, not HTTP/API request documentation. I had to hunt through existing example files in the ~/xs folder to find the OpenAI example which showed the correct pattern.

**Why it was an issue:**
The documentation search didn't surface relevant examples for a common use case (making HTTP API calls). I had to reverse-engineer the syntax from existing implementations rather than getting clear guidance from docs.

**Potential solution (if known):**
- Add an `api` or `http` topic to xanoscript_docs that covers api.request syntax
- Include common patterns section in the quickstart for "Making HTTP requests to external APIs"
- The integrations topic could mention api.request for external API calls

---

## [2025-02-16 19:40 PST] - Documentation Discovery for Run Jobs

**What I was trying to do:**
Get documentation specifically for creating run jobs and the required file structure.

**What the issue was:**
The initial call to `xanoscript_docs topic=run` returned good documentation, but it wasn't clear from the tool schema that `topic=run` was the right choice. The available topics list is long and includes things like "database", "apis", "functions" - it took a moment to realize "run" was the correct topic for run jobs specifically.

**Why it was an issue:**
When looking for run job documentation, I initially considered topics like "apis" or "functions" before finding that "run" was its own dedicated topic. The topic naming isn't always intuitive.

**Potential solution (if known):**
- Consider aliases or cross-references in docs (e.g., searching "job" or "run job" could suggest the "run" topic)
- Add a "see also" section that relates topics to each other

---

## [2025-02-16 19:38 PST] - MCP Tool Schema Discovery

**What I was trying to do:**
Understand what tools were available in the Xano MCP server.

**What the issue was:**
Had to use `mcporter list xano --schema` to see available tools, but initially didn't know this was the right command. The xanoscript_docs tool description mentions it should be called before writing code, but doesn't explain how to discover it or what other tools exist.

**Why it was an issue:**
The prompt said "You MUST call `xanoscript_docs`" but I had to first discover that this tool exists via mcporter. The workflow wasn't immediately obvious.

**Potential solution (if known):**
- The MCP could expose a `list_tools` or `help` function that explains available capabilities
- Documentation could include a "Getting Started for AI Assistants" section

---

## Summary

The Xano MCP validation tool worked well once I understood the correct syntax. The main friction points were:

1. **Parameter naming**: `params` vs `body` was confusing - clearer documentation would help
2. **Documentation discovery**: Finding the right topic and understanding cross-cutting concerns (like api.request) required jumping between docs and examples
3. **Example-driven learning**: I relied heavily on existing implementations (Stripe, OpenAI, Twilio) to understand patterns - this worked but wasn't documented

The validation tool's error messages were helpful with suggestions, but could be more explicit about the correct alternative syntax.

Overall, once the patterns were understood from examples, development was straightforward. The main improvement would be documentation that bridges the gap between "here's what this block does" and "here's how to use it for common scenarios like calling external APIs".
# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 00:45 PST - Directory Path Expansion Issue

**What I was trying to do:**
Validate the .xs files using the validate_xanoscript tool with a directory path.

**What the issue was:**
The MCP tool doesn't expand `~` (tilde) to the user's home directory. When I passed `directory=~/xs/lob-send-postcard`, it returned "No .xs files found in directory". I had to use the absolute path `/Users/justinalbrecht/xs/lob-send-postcard` for it to work.

**Why it was an issue:**
This is counterintuitive since most CLI tools and scripts accept `~` as a shorthand for the home directory. It took a moment to realize why the files weren't being found even though they existed.

**Potential solution (if known):**
Have the MCP expand common shell path patterns like `~` before checking the filesystem, or document this limitation clearly in the tool description.

---

## 2025-02-18 00:45 PST - Documentation Fragmentation

**What I was trying to do:**
Learn enough XanoScript syntax to write a complete run job with a function that makes an external API call.

**What the issue was:**
I had to call `xanoscript_docs` multiple times with different topics to gather all the information needed:
- `topic=run` - for run.job syntax
- `topic=quickstart` - for common patterns and mistakes
- `topic=functions` - for function structure
- `topic=integrations/external-apis` - for api.request syntax

Each call returned a lot of content, and I had to piece together the information from multiple sources.

**Why it was an issue:**
It was time-consuming and required multiple round-trips. For a common use case like "create a run job that calls an external API", it would be helpful to have a single comprehensive guide or example.

**Potential solution (if known):**
Add a topic like `topic=complete-example` or `topic=run-job-with-api-call` that shows a complete, working example with run.xs + function.xs together. Also consider adding cross-references at the end of each doc section pointing to related topics.

---

## 2025-02-18 00:45 PST - Base64 Encoding Uncertainty

**What I was trying to do:**
Create a Basic Auth header for the Lob API (which requires `base64_encode`).

**What the issue was:**
I couldn't find explicit documentation about whether `base64_encode` filter exists in XanoScript. I assumed it exists based on common patterns, but had to guess the syntax: `($env.LOB_API_KEY ~ ":"|base64_encode)`.

**Why it was an issue:**
Uncertainty about whether the code would work. I had to run validation to confirm, and if it failed, I wouldn't have known what the correct filter name was (maybe `base64`, `encode_base64`, `to_base64`, etc.).

**Potential solution (if known):**
Include a comprehensive filter reference in the `topic=syntax` docs with all available filters organized by category (encoding, string, array, etc.). Also consider adding a topic like `topic=filters` that lists all filters alphabetically with examples.

---

## 2025-02-18 00:45 PST - api.request params Parameter Naming

**What I was trying to do:**
Send a POST request with a JSON body to the Lob API.

**What the issue was:**
The documentation clearly states that `params` is used for the request body (not query parameters), which is counterintuitive since "params" usually means URL/query parameters in most HTTP libraries. While this is documented, it's easy to forget or miss.

**Why it was an issue:**
This naming choice is confusing for developers coming from other languages/frameworks where `body` is the standard parameter name for POST data. It's mentioned as a "common mistake" in the quickstart guide, which suggests it's a frequent source of confusion.

**Potential solution (if known):**
Consider accepting both `params` and `body` as aliases for the same parameter, or add a prominent warning/reminder in the documentation and validation output when `body` is detected as an invalid parameter.

---

## 2025-02-18 00:45 PST - String Concatenation with Filters

**What I was trying to do:**
Concatenate strings with filtered expressions, like: `"Bearer " ~ $env.LOB_API_KEY` and `"Status: " ~ ($status|to_text)`.

**What the issue was:**
The quickstart documentation warns about this, but it's easy to forget that filtered expressions in concatenations MUST be wrapped in parentheses. For example: `($status|to_text)` not just `$status|to_text`.

**Why it was an issue:**
This is listed as one of the "Common Mistakes" in the quickstart, which suggests it's a frequent stumbling block. The error messages when you get it wrong might not be immediately clear about what's wrong.

**Potential solution (if known):**
The linter/validator could potentially detect this pattern and provide a helpful warning or auto-fix suggestion. Alternatively, improve the parser to handle this more gracefully, or at minimum add clearer error messages like: "Did you mean to wrap the filter expression in parentheses?"

---

## 2025-02-18 00:45 PST - Object Literal Syntax

**What I was trying to do:**
Create objects with key-value pairs in XanoScript.

**What the issue was:**
XanoScript uses `:` (colon) for object properties, while many languages use `=` (equals). The documentation mentions this as a common mistake, but it's an easy habit to bring from JavaScript/JSON where `=` is not valid and `:` is standard.

**Why it was an issue:**
Muscle memory from other languages makes this an easy mistake. The quickstart shows the correct syntax but it's a mental shift every time you switch contexts.

**Potential solution (if known):**
The validator could potentially detect `=` in object literals and suggest using `:` instead with a clear error message.

---

## Overall Assessment

**What worked well:**
- The validation tool is fast and accurate
- The documentation is comprehensive once you find the right topics
- The examples in the docs are helpful and well-structured
- The MCP server was already installed and configured

**Areas for improvement:**
1. **Single comprehensive guide** for common use cases (run job + API call)
2. **Better path handling** in the MCP tools (expand `~`)
3. **Complete filter reference** with all available filters listed
4. **More helpful error messages** that suggest fixes for common mistakes
5. **Consider more intuitive parameter names** (`body` instead of/in addition to `params`)

---

*Generated by: Brecht (OpenClaw Agent)*
*Date: 2025-02-18*
*Task: Create Lob Send Postcard Xano Run Job*

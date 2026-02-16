# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 11:17 PST] - Missing XanoScript Syntax Knowledge

**What I was trying to do:**
Create a XanoScript run job from scratch for Twilio SMS integration

**What the issue was:**
I had no knowledge of XanoScript syntax at all. My training data doesn't include XanoScript, so I had to rely entirely on the MCP's xanoscript_docs tool.

**Why it was an issue:**
Without calling xanoscript_docs first, I would have written completely invalid code (likely JavaScript/TypeScript syntax). The prompt correctly warned that any syntax I "thought" I knew would be wrong.

**Potential solution (if known):**
The xanoscript_docs tool is essential and works well. However, it would be helpful to have:
1. A single "cheatsheet" or "getting started" topic that combines the most critical syntax rules
2. An automated validation step that runs before committing (like a pre-commit hook)

---

## [2025-02-16 11:18 PST] - Documentation Structure is Good

**What I was trying to do:**
Find the right documentation topics to understand run jobs, functions, and API requests

**What the issue was:**
No issues here - the documentation was well-organized with clear topic names

**Why it was an issue:**
N/A - this was a positive experience

**Potential solution (if known):**
The topic structure is intuitive: `run`, `functions`, `syntax`, `quickstart`. The quickstart had excellent common mistakes section that saved me from errors.

---

## [2025-02-16 11:19 PST] - Base64 Encoding for Basic Auth

**What I was trying to do:**
Implement Twilio's Basic Auth which requires base64 encoding of "sid:token"

**What the issue was:**
I wasn't sure if XanoScript had a base64_encode filter. I had to search through the syntax documentation.

**Why it was an issue:**
The syntax docs are comprehensive but I had to scan through them to find the encoding filters. This took extra time.

**Potential solution (if known):**
Consider adding a search/filter capability to xanoscript_docs, or a topic like "encoding" or "auth" that groups related filters together.

---

## [2025-02-16 11:20 PST] - Form-Encoded vs JSON Request Body

**What I was trying to do:**
Send a POST request to Twilio's API with form-encoded data (Twilio requires x-www-form-urlencoded, not JSON)

**What the issue was:**
The api.request documentation shows `params` for the request body, but I wasn't sure if it handles form-encoding automatically or if I needed to manually encode.

**Why it was an issue:**
Twilio specifically requires `application/x-www-form-urlencoded` content type. I set the header but wasn't 100% sure if the `params` object gets properly form-encoded or sent as JSON.

**Potential solution (if known):**
Add more detail to the integrations or syntax docs about:
1. How params is serialized based on Content-Type header
2. Examples of form-encoded vs JSON POST requests

---

## [2025-02-16 11:21 PST] - String Concatenation with Filters

**What I was trying to do:**
Build the Twilio API URL by concatenating strings with the account SID

**What the issue was:**
Initially I wrote: `$account_sid ~ "/Messages.json"` but then realized I needed to be careful with filter concatenation rules

**Why it was an issue:**
The quickstart docs had a CRITICAL warning about wrapping filtered expressions in parentheses when concatenating. This saved me from a parse error.

**Potential solution (if known):**
The documentation handles this well - the "Common Mistakes" section is excellent. Keep emphasizing these gotchas!

---

## [2025-02-16 11:22 PST] - Validation Tool Works Great

**What I was trying to do:**
Validate the .xs files before committing

**What the issue was:**
No issues - the validate_xanoscript tool worked perfectly on the first try

**Why it was an issue:**
N/A - this was a positive experience

**Potential solution (if known):**
The batch validation with `directory` parameter is convenient. Consider adding a `--watch` mode for development that auto-validates on file changes.

---

## Summary

**What went well:**
- xanoscript_docs tool provides comprehensive documentation
- The quickstart guide has an excellent "Common Mistakes" section
- validate_xanoscript caught no errors (good docs = good code)
- Topic organization is logical and easy to navigate

**What could be improved:**
1. Add a compact "syntax cheatsheet" topic for quick reference
2. Clarify how api.request handles different Content-Type encodings
3. Group related filters (encoding, auth, etc.) in docs
4. Consider adding examples for popular APIs (Twilio, Stripe, etc.) directly in the docs

**Overall experience:**
Smooth! Once I read the docs, writing valid XanoScript was straightforward. The language is clean and the validation tool gives confidence.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 05:47 PST] - Date Syntax Confusion

**What I was trying to do:**
Create a timestamp for the Segment API request payload to track when events occurred.

**What the issue was:**
I initially used `date.now|date_format:"iso8601"` based on my assumption of how date functions work (similar to other languages). The validation error indicated that `date` was not recognized, and from the error message I could see that `now` was one of the expected tokens.

**Why it was an issue:**
Without clear documentation on the date/time syntax, I had to guess and iterate through validation failures. The error message was helpful in that it showed `[now]` as an expected token, but I had to infer that `now` is a standalone keyword (not `date.now`).

**Potential solution (if known):**
- Add a "Date/Time" section to the quickstart or syntax documentation
- Document the `now` keyword and any date-related filters like `date_format`
- Include examples of timestamp generation in the quickstart

---

## [2026-02-17 05:48 PST] - Limited Quick Reference Coverage

**What I was trying to do:**
Find documentation on XanoScript date/time handling and object schema definitions within the input block.

**What the issue was:**
The `quick_reference` mode returns a condensed subset of documentation, which makes sense for token efficiency but omits many practical details I needed. When I tried to get the `types` topic documentation, the MCP returned an error: `p.split is not a function`.

**Why it was an issue:**
I had to rely on reading existing working code from other implementations to infer correct syntax patterns. This works but is slower and less authoritative than proper documentation. The error when requesting the `types` topic also blocked me from accessing potentially relevant information.

**Potential solution (if known):**
- Ensure all documentation topics work reliably in both `full` and `quick_reference` modes
- Consider adding a "cheatsheet" topic that has the most common patterns without being as brief as quick_reference
- Document which topics have errors so users know to avoid them or use workarounds

---

## [2026-02-17 05:50 PST] - String Concatenation in Headers Array

**What I was trying to do:**
Construct the Basic Auth header for Segment's API which requires base64 encoding of the write key with a colon suffix.

**What the issue was:**
I used `"Authorization: Basic " ~ ($env.segment_write_key ~ ":"|base64_encode)` which concatenates the key with a colon, then base64 encodes the result. This syntax seemed correct based on the string concatenation docs, but I wasn't 100% certain the base64_encode filter exists.

**Why it was an issue:**
The validation passed, so my syntax was correct, but I had to guess that `base64_encode` was a valid filter. There's no quick reference list of available encoding filters.

**Potential solution (if known):**
- Include encoding/decoding filters (base64_encode, base64_decode, url_encode, etc.) in the syntax quick reference
- Or create a dedicated "filters" topic that lists all available filters by category

---

## [2026-02-17 05:52 PST] - Input Block Schema Definition Unclear

**What I was trying to do:**
Define an optional object input with specific schema properties for the Segment track event properties.

**What the issue was:**
The quick reference shows basic input syntax but doesn't cover:
- How to define nested object schemas with the `schema` keyword
- Whether all properties in the schema are optional by default or required
- How to mark individual object properties as optional

**Why it was an issue:**
I used `schema { ... }` syntax based on reading existing implementations, but I wasn't sure if I should mark nested properties with `?` or if the parent object being optional was sufficient.

**Potential solution (if known):**
- Add examples of complex input types (nested objects, arrays of objects) to the quickstart or types documentation
- Clarify the relationship between parent object optionality and child property optionality

---

## [2026-02-17 05:55 PST] - Positive Validation Feedback

**What was working well:**
The `validate_xanoscript` tool was extremely helpful. It provided clear error messages with line and column numbers, and the directory validation mode made it easy to validate all files at once.

**Suggestions for improvement:**
- Consider adding a `--watch` mode or integration with file watchers for development
- Add a `validate_xanoscript --fix` option that auto-fixes common issues (like suggesting `now` instead of `date.now`)
- The error message "Expecting: one of these possible Token sequences" is technically accurate but could be overwhelming - perhaps prioritize the most likely expected tokens

---

## Summary

Overall, the MCP was functional and the validation tool worked well. The main friction points were:
1. Missing documentation for date/time handling
2. Incomplete coverage in quick_reference mode with no working fallback for some topics
3. Limited filter documentation
4. No clear guidance on complex input types

The validation tool was the saving grace - it caught my errors quickly and helped me iterate to working code.

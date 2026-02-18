# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 13:17 PST - Array Default Value Syntax Unclear

**What I was trying to do:**
Define an optional text array input parameter with an empty array as the default value.

**What the issue was:**
I wrote `text[] labels?=[]` following common programming conventions, but this caused a parse error. The error message was confusing - it said it found `[` when expecting various token types, and the suggestion mentioned using "type[]" instead of "array" which wasn't helpful since I was already using `text[]`.

**Why it was an issue:**
The error didn't clearly explain that array types cannot have literal default values like `=[]`. I had to guess that making it nullable (`text[] labels?`) was the correct approach.

**Potential solution:**
- Documentation should clarify that array input types cannot have default values specified inline
- Error message could be more specific: "Array types cannot have default values. Use `type[] name?` for optional arrays without defaults."
- Example in quickstart showing proper array input syntax would help

---

## 2025-02-18 13:18 PST - Need for Better Array Handling Examples

**What I was trying to do:**
Check if the optional labels array had any items before adding it to the API payload.

**What the issue was:**
After changing from `labels?=[]` to `labels?`, I needed to update my conditional to handle null. The documentation shows `($array|count) > 0` pattern but doesn't show how to safely handle potentially null arrays.

**Why it was an issue:**
Without clear guidance, I had to infer that I should check for null first: `$input.labels != null && ($input.labels|count) > 0`. This is a common pattern but not explicitly documented.

**Potential solution:**
- Add a "Safe array operations" section to the quickstart
- Show pattern: `if ($arr != null && ($arr|count) > 0)` for checking non-empty optional arrays
- Include examples of the `??` operator and `first_notnull` filter with arrays

---

## 2025-02-18 13:19 PST - MCP Tool Output Format Inconsistent

**What I was trying to do:**
Parse validation results programmatically from the MCP.

**What the issue was:**
The validation output format varies - sometimes it's plain text (✓/✗), sometimes it has structured data. When I added `--output json`, the format changed but wasn't clearly documented.

**Why it was an issue:**
Inconsistent output makes it harder to build reliable tooling around the MCP. I had to try both formats to see what worked.

**Potential solution:**
- Document the `--output` flag in the MCP tool descriptions
- Ensure consistent JSON structure for all responses when using `--output json`
- Include a `success` boolean and `errors` array in JSON responses for easier parsing

---

## Summary

Overall the Xano MCP worked well for validation. The main friction points were:
1. Array syntax documentation could be clearer about default values
2. Error messages for array syntax could be more specific
3. More examples of handling optional arrays would help

The documentation is comprehensive but could benefit from more "common mistake" examples for array handling specifically.

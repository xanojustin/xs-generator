# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 12:05 PST] - Filter naming inconsistency

**What I was trying to do:** Get the length of a string to process it character by character

**What the issue was:** I initially tried to use `$cleaned|length` which is a common filter name in many template languages (Twig, Liquid, etc.), but the validator reported "Unknown filter function 'length'"

**Why it was an issue:** I had to guess what the correct filter name was. In most languages, `length` is used for strings while `count` is for arrays. XanoScript uses `count` for both, which is consistent but not immediately obvious.

**Potential solution (if known):** 
- Could add `length` as an alias for `count` when used on text types for better discoverability
- Or improve the error message to suggest "Did you mean 'count'?"

---

## [2026-02-24 12:00 PST] - Documentation could clarify filter behavior with different types

**What I was trying to do:** Understand which filters work on which data types

**What the issue was:** The cheatsheet mentions filters but doesn't explicitly state that `count` works on both arrays and strings

**Why it was an issue:** Had to make an assumption and test to find the correct filter

**Potential solution (if known):** 
- Add a note in the quickstart docs that `count` filter works for getting the length of both arrays and text
- Or provide type-specific filter examples in the documentation

---

## General Notes

The MCP validation tool worked well - it gave clear error messages with line numbers and even suggested using "text" instead of "string" which was helpful. The error feedback loop was quick and efficient.

The `xanoscript_docs` tool provided excellent documentation that made it easy to understand the syntax patterns. The quick_reference mode was particularly useful for getting concise information without overwhelming context.

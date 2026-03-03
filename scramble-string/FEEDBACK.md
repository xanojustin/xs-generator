# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 05:32 PST] - Comment Syntax Not Supported

**What I was trying to do:** Add descriptive comments at the top of the function file to explain the scramble string problem

**What the issue was:** I assumed `//` style single-line comments would work based on common programming language conventions. The validation failed with:
```
1. [Line 13, Column 1] Expecting --> function <-- but found --> '
' <--
```

The error message was confusing - it suggested using "text" instead of "string", which wasn't related to the actual problem.

**Why it was an issue:** I had to remove all comments to get the code to validate. Comments are essential for code documentation and readability.

**Potential solution (if known):** 
- Document the comment syntax clearly in the essentials or syntax documentation
- If comments aren't supported, explicitly state that in the docs
- If a different comment syntax exists (like `/* */` or `#`), provide examples

---

## [2026-03-03 05:33 PST] - Path Expansion in MCP Tool

**What I was trying to do:** Validate files using the directory parameter with `~/xs/scramble-string`

**What the issue was:** The tilde (`~`) didn't expand to the home directory:
```
No .xs files found in directory: ~/xs/scramble-string
```

I had to use the full absolute path `/Users/justinalbrecht/xs/scramble-string` instead.

**Why it was an issue:** It's inconvenient to always use absolute paths. Shell users expect `~` to work.

**Potential solution (if known):** 
- Expand `~` to `$HOME` in the validate_xanoscript tool
- Or document that absolute paths are required

---

## [2026-03-03 05:33 PST] - Missing `sort` filter documentation

**What I was trying to do:** Sort characters in a string to compare character frequencies

**What the issue was:** I assumed `$arr|sort` would work based on general knowledge of array operations, but I didn't see it explicitly documented in the quick reference I read.

**Why it was an issue:** I had to guess that the filter exists and works as expected.

**Potential solution (if known):** 
- Include `sort` in the array filters quick reference
- Provide a complete list of all available filters

---

## [2026-03-03 05:33 PST] - String Length Filter Naming

**What I was trying to do:** Get the length of a string

**What the issue was:** I initially tried `$input.s1|length` but then saw in the essentials that it's `$text|strlen` (string length). This is inconsistent with array length which is `$arr|count`.

**Why it was an issue:** Different naming conventions for similar operations on different types is confusing.

**Potential solution (if known):** 
- Consider aliasing `length` to work for both strings and arrays
- Or clearly document which filter to use for each type

---

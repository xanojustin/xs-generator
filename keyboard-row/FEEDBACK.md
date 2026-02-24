# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 11:05 PST] - Unknown filter function 'strpos'

**What I was trying to do:** Check if a character exists within a keyboard row string (e.g., check if "a" is in "asdfghjkl")

**What the issue was:** I initially tried to use `strpos` filter (PHP-style string position function) to find the position of a substring within a string, but this filter doesn't exist in XanoScript.

```xs
// What I tried (WRONG):
var $in_top { value = ($top_row|strpos:$first_char) != false }
```

**Why it was an issue:** This caused 4 validation errors. I had to search through the docs to find the correct filter name.

**What I found:** The correct filter is `contains` which returns a boolean directly:

```xs
// Correct:
var $in_top { value = $top_row|contains:$first_char }
```

**Potential solution:** 
- The docs clearly document `contains` so this was my mistake for assuming PHP-style filter names
- A filter cheatsheet or alias mapping (strpos -> contains, etc.) might help developers coming from other languages
- The error message was clear and helpful - it told me exactly which filter was unknown

---

## [2025-02-24 11:06 PST] - Positive: Clear validation error messages

**What I was trying to do:** Validate my XanoScript files

**What worked well:** The validation error messages were excellent:
- Clear file and line/column numbers
- Showed the actual code that failed
- Easy to understand what went wrong

**Why this matters:** Made it very quick to identify and fix the issues

---

## [2025-02-24 11:07 PST] - Minor: Finding the right filter in docs

**What I was trying to do:** Find the correct filter for substring checking

**What the issue was:** The quick_reference mode didn't include all string filters, so I had to search through full docs

**Why it was an issue:** Took a bit more time to grep through the full syntax documentation

**Potential solution:** The quick_reference could include a "Common String Filters" section with contains, starts_with, ends_with, etc.

---

## Overall Experience

The MCP worked well overall:
- ✅ `validate_xanoscript` is fast and helpful
- ✅ `xanoscript_docs` has comprehensive information
- ✅ Directory-based validation is convenient
- 🔍 Finding specific filter names could be slightly easier

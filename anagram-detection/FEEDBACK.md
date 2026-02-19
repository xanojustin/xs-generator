# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 14:05 PST] - String Length Filter Naming

**What I was trying to do:** Check the length of a string to compare if two strings could be anagrams

**What the issue was:** I intuitively used `|length` filter on strings, which failed validation with "Unknown filter function 'length'"

**Why it was an issue:** The filter is named `strlen` for strings, but `count` for arrays. This distinction isn't immediately obvious from the naming convention. Most languages use `length` or `len` universally.

**Potential solution:** The MCP error message was actually helpful - it suggested using `text` type, but maybe it could also suggest the correct filter name: "Did you mean `strlen` for string length or `count` for array length?"

---

## [2025-02-19 14:08 PST] - Input Filter vs Expression Filter Naming Inconsistency

**What I was trying to do:** Normalize input strings to lowercase using an input filter

**What the issue was:** Used `to_lower` in the input filter chain (`filters=trim|to_lower`), which failed with "Filter 'to_lower' cannot be applied to input of type 'text'"

**Why it was an issue:** The syntax documentation shows `to_lower` as a valid filter, but for input declarations it must be just `lower`. This inconsistency between input filters and expression filters is confusing.

**Potential solutions:**
1. Allow both `lower` and `to_lower` in both contexts for consistency
2. The error message could be clearer: "Use `lower` instead of `to_lower` for input filters"
3. Document this distinction more prominently in the quickstart guide

---

## [2025-02-19 14:10 PST] - Documentation Discovery

**What I was trying to do:** Find the correct filter names for my use case

**What the issue was:** The quick_reference mode doesn't show all available filters - just the most common ones. I had to call the docs twice to find the right filter names.

**Why it was an issue:** The `length` vs `strlen` distinction wasn't in the quick reference, and neither was the `to_lower` vs `lower` distinction for inputs.

**Potential solution:** Consider adding a note in the quick reference about input filter naming differences, or include `strlen` in the common filters table since string length is a very common operation.

---

## [2025-02-19 14:12 PST] - Overall MCP Experience

**Positive feedback:**
- The validate tool is fast and gives clear line/column numbers
- The error suggestions are helpful (when they apply)
- Being able to validate a whole directory at once is convenient

**Areas for improvement:**
- Filter naming consistency between input declarations and expressions
- Error messages could suggest the correct alternative filter names
- A unified filter reference that notes which filters work where would help

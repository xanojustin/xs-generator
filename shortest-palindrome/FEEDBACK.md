# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 11:32 PST] - Incorrect filter assumption (strrev)

**What I was trying to do:** Implement a string reversal for the shortest palindrome algorithm

**What the issue was:** I assumed `strrev` was a valid XanoScript filter based on my training data from other languages. The MCP validation correctly identified this as an unknown filter.

**Why it was an issue:** Without the validation tool, I would have written invalid code that would fail at runtime. The error message was clear and helpful.

**Potential solution:** The documentation does cover this in the syntax section (I found it by searching), but it might be helpful to have a "common string operations" quick reference that explicitly shows the pattern for reversing strings. Something like:

```
String Reversal: `$str|split:""|reverse|join:""`
```

---

## [2026-02-23 11:33 PST] - Documentation discovery

**What I was trying to do:** Find the correct way to reverse a string in XanoScript

**What the issue was:** I had to grep through the syntax documentation output to find the pattern. The documentation exists but isn't immediately discoverable.

**Why it was an issue:** It took extra time to locate the correct approach. A more structured filter reference or a "string manipulation recipes" section would speed up development.

**Potential solution:** Consider adding a `xanoscript_docs({ topic: "string-filters" })` or similar that groups common string operations with examples.

---

## [2026-02-23 11:33 PST] - No major MCP issues encountered

**What I was trying to do:** Validate XanoScript files using the MCP

**What the issue was:** The MCP validation worked correctly on the first try after I provided the correct directory path.

**Why it was an issue:** N/A - worked as expected

**Potential solution:** The validation tool works well. The error messages are clear and include line/column numbers which is helpful.

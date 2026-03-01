# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-01 09:05 PST - Empty line between comments and function declaration causes parse error

**What I was trying to do:** Create a XanoScript function with comments at the top explaining the problem.

**What the issue was:** When I had a comment block followed by an empty line, then the `function` declaration, the parser gave this error:
```
[Line 4, Column 1] Expecting --> function <-- but found --> '
' <--
```

**Why it was an issue:** I was following a natural pattern of separating comments from code with a blank line for readability. The error message was confusing because it said it expected `function` but found a newline, when really the issue was that an empty line between the comment and function declaration is not allowed.

**Potential solution (if known):** 
1. Either allow empty lines between comments and declarations
2. Or provide a clearer error message like "Empty lines not allowed between comments and function declaration"

I was able to work around it by removing the empty line.

---

## 2026-03-01 09:06 PST - Documentation request for comment syntax

**What I was trying to do:** Understand what comment styles are supported in XanoScript (// vs /* */ vs #)

**What the issue was:** The quick_reference for syntax didn't mention comment syntax at all. I had to look at existing files to see that `//` is used.

**Why it was an issue:** It wasn't clear if single-line comments were supported, or if there were any restrictions on where comments can appear.

**Potential solution (if known):** Add a "Comments" section to the syntax quick_reference documentation.

---

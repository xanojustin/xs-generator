# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-21 18:33 PST - Inline Comments Not Supported

**What I was trying to do:** Add explanatory comments at the end of code lines in XanoScript

**What the issue was:** Inline comments (using `//` at the end of a line) cause a parse error. The error message was:
```
[Line 54, Column 42] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** This is a common pattern in most programming languages. I assumed `//` comments would work at end of lines like in JavaScript, but they only work when the entire line is a comment.

**Potential solution:** Either:
1. Support inline comments in the parser
2. Document this clearly in the quickstart guide under "Common Mistakes"

---

## 2025-02-21 18:33 PST - String Character Access Syntax Unclear

**What I was trying to do:** Access individual characters from a string using bracket notation like `$input.s[$j]`

**What the issue was:** Unclear if direct string indexing works in XanoScript. The documentation didn't explicitly show how to access characters by index.

**Why it was an issue:** I had to guess and use the `substr` filter instead (`$input.s|substr:$j:1`), which works but is more verbose.

**Potential solution:** Document string/array indexing in the syntax documentation with clear examples.

---

## General Observations

- The MCP `validate_xanoscript` tool works well with the `--args` JSON format
- The directory validation feature is very convenient for batch checking
- Error messages are helpful with line/column numbers and suggestions

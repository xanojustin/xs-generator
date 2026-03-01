# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 09:35 PST] - Inline Comments Not Supported

**What I was trying to do:** Add inline comments to document variable purposes (e.g., `var $first { value = 0 }   // T(n-3)`)

**What the issue was:** XanoScript parser threw an error when comments appeared on the same line as code:
```
[Line 24, Column 32] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: '/'
```

**Why it was an issue:** This is a common pattern in most programming languages (C, Java, JavaScript, Python, etc.). It's intuitive to add a brief comment after a variable declaration to explain its purpose. Having to put comments on separate lines makes the code more verbose and breaks the visual association between the code and its documentation.

**Potential solution (if known):** 
- Option 1: Allow `//` style inline comments at end of lines
- Option 2: Add support for `/* */` block comment syntax which is more familiar for inline documentation
- Option 3: If inline comments can't be supported, document this prominently in the essentials guide as it's a common expectation

---

## [2026-03-01 09:36 PST] - File Path Handling with Tilde (~)

**What I was trying to do:** Validate files using paths with tilde expansion (`~/xs/tribonacci/run.xs`)

**What the issue was:** The MCP validator returned "File not found" errors when using tilde paths. Had to use absolute paths (`/Users/justinalbrecht/xs/...`).

**Why it was an issue:** Tilde expansion is standard shell behavior. Users naturally expect `~/` to resolve to their home directory. The error message "File not found" was misleading since the file did exist - the path just wasn't being expanded.

**Potential solution (if known):**
- Expand tildes in file paths before attempting to read files
- Or provide a clearer error message like "Path expansion not supported, use absolute paths"

---

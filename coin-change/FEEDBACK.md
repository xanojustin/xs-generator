# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 07:02 PST] - MCP Documentation Tool Works Well

**What I was trying to do:** Get XanoScript syntax documentation before writing code

**What the issue was:** No issues - the `xanoscript_docs` tool worked perfectly

**Why it was a (non-)issue:** The documentation was comprehensive and well-organized. I was able to get all the info I needed about functions, run jobs, and quickstart patterns.

**Potential solution (if known):** Keep up the good work! The docs with the `topic` parameter made it easy to find what I needed.

---

## [2026-02-20 07:05 PST] - Validation Tool Success

**What I was trying to do:** Validate my XanoScript files using the MCP

**What the issue was:** Initially confused about parameter naming (`file_paths` vs `file-path` in CLI)

**Why it was an issue:** Tried passing JSON with `files` parameter but the tool expected `file_paths`

**Potential solution (if known):** The error message was helpful and told me exactly what parameters were valid. Using the `directory` parameter was even easier for batch validation.

---

## [2026-02-20 07:06 PST] - First-Try Validation Success

**What I was trying to do:** Validate coin change implementation

**What the issue was:** No issues! Both files passed validation on the first try.

**Why it was a (non-)issue:** The XanoScript documentation was clear enough that I could write correct code without trial and error. Key things that helped:
- Clear examples of `function` structure with `input`, `stack`, and `response`
- Examples showing `var.update` for modifying variables
- Run job syntax with `main = { name: "...", input: { ... } }`

**Potential solution (if known):** The docs are working well. The only minor confusion was around array element updates - I wasn't sure if `var.update $dp[0]` was valid syntax, but it passed validation so it appears to be correct.


# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 09:05 PST] - Response assignment scope confusion

**What I was trying to do:** Write a function that returns different values based on conditional logic (checking if a number is confusing).

**What the issue was:** I initially tried to set `response = false` inside a conditional block and `response = $is_confusing` at the end of the function. The validator gave an error:
```
[Line 76, Column 9] Expecting --> } <-- but found --> 'response' <--
```

**Why it was an issue:** It wasn't immediately clear that XanoScript doesn't allow setting `response` inside conditional blocks. The error message pointed to the line with `response = false` but the actual issue was that I had multiple response assignments.

**Potential solution:** 
- Better error message: "Response can only be set once per function, at the top level"
- Or document clearly that `response` must only appear once, at the end of the function
- The MCP docs mention `return { value = ... }` for early returns, but I wasn't sure if that was the right pattern here

---

## [2025-03-03 09:08 PST] - MCporter array parameter handling

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter.

**What the issue was:** The MCporter CLI seems to have trouble passing arrays. I tried:
```bash
mcporter call xano.validate_xanoscript file_paths="file1.xs,file2.xs"
```
But got: `Invalid input: expected array, received string`

When I tried JSON format:
```bash
mcporter call xano.validate_xanoscript --input '{"file_paths": [...]}'
```
It said "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The CLI parameter passing for arrays isn't intuitive. I had to switch to using `directory` parameter instead.

**Potential solution:**
- Better CLI examples in MCP documentation for array parameters
- Support comma-separated strings that get parsed as arrays
- Or just recommend using `directory` for batch validation

---

## [2025-03-03 09:10 PST] - Validation passed successfully

**What worked well:**
- The `directory` parameter for validation worked great
- Error messages included line/column numbers which was helpful
- The MCP documentation for functions and run jobs was comprehensive

**Positive feedback:**
- The validator correctly identified the exact line and column of the error
- The documentation at `xanoscript_docs topic="functions"` was very helpful for understanding function structure
- The essentials documentation saved me from common mistakes (like using `elseif` instead of `else if`)

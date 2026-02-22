# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 16:35 PST] - MCP Parameter Parsing Issue with Arrays

**What I was trying to do:** Validate multiple `.xs` files using the `file_paths` array parameter

**What the issue was:** When passing an array via `mcporter call`, the parameter parsing broke and treated each character of the array string as a separate file path. Example:

```bash
mcporter call xano.validate_xanoscript file_paths="['/path/to/file1.xs','/path/to/file2.xs']"
```

Result: MCP interpreted each character (`[`, `'`, `/`, `U`, `s`, `e`, etc.) as individual file paths, generating 98 "File not found" errors.

**Why it was an issue:** The `file_paths` parameter is documented as accepting an array of file paths for batch validation, but there's no clear way to pass an array through the mcporter CLI. This forces use of the `directory` parameter instead, which may validate more files than intended.

**Workaround used:** Used `directory` parameter to validate the entire `~/xs/subsets/` folder instead.

**Potential solution:** 
- Document the expected array format for mcporter CLI calls
- Support comma-separated string that gets parsed as array internally
- Or add examples showing proper array syntax in the MCP documentation

---

## [2026-02-21 16:38 PST] - Successful First-Pass Validation

**What I was trying to do:** Write XanoScript code for a subsets algorithm

**What happened:** Both files passed validation on the first attempt

**Why this worked:** 
- Carefully followed the quick reference documentation for syntax
- Referenced existing fizzbuzz implementation for structure
- Used correct variable access patterns (`$input.nums`, `$var.i`)
- Properly used parentheses around filtered expressions in conditionals

**Positive feedback:** The quick reference documentation for functions and syntax was clear enough to write correct code on the first try. The iterative subset building algorithm translated cleanly to XanoScript.

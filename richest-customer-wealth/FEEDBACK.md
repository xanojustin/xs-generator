# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 18:05 PST] - MCP file_paths parameter parsing issue

**What I was trying to do:** Validate multiple .xs files at once using the `file_paths` parameter

**What the issue was:** The comma-separated file_paths parameter was being parsed incorrectly by the MCP. Instead of treating it as an array of two file paths, it appeared to iterate over each character, treating every individual character as a separate file path.

**Command used:**
```
mcporter call xano.validate_xanoscript file_paths="/Users/justinalbrecht/xs/richest-customer-wealth/run.xs,/Users/justinalbrecht/xs/richest-customer-wealth/function/richest_customer_wealth.xs"
```

**Result:** 140 "files" were attempted to be validated, with errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

**Why it was an issue:** This made batch validation impossible. I had to fall back to validating files one at a time using `file_path` instead of `file_paths`.

**Potential solution (if known):** 
- The MCP should properly parse comma-separated strings into an array
- Or provide clearer documentation on the expected format for array parameters
- Using `--args '{"file_paths": ["path1", "path2"]}'` syntax might work but is more cumbersome

---

## [2025-02-24 18:06 PST] - 2D Array type syntax confusion

**What I was trying to do:** Define a 2D array input parameter for the function to represent a grid of integers

**What the issue was:** XanoScript does not support `int[][]` or similar multi-dimensional array syntax. The parser threw an error: `Expecting token of type --> Identifier <-- but found --> '[' <--`

**Code that failed:**
```xs
input {
  int[][] accounts { description = "2D array..." }
}
```

**Why it was an issue:** Coming from TypeScript/JavaScript/Python backgrounds, `int[][]` is the natural way to represent a 2D array. The error message suggested using `"type[]" instead of "array"` but that doesn't apply to 2D arrays.

**Solution found:** Use `json` type which accepts any JSON structure:
```xs
input {
  json accounts { description = "2D array..." }
}
```

**Potential solution (if known):**
- Document clearly that only 1D arrays are supported with `type[]` syntax
- Suggest `json` type for multi-dimensional arrays or nested structures
- Consider adding support for `type[][]` syntax in future XanoScript versions
- Improve error message to mention `json` as an alternative for complex structures

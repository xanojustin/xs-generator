# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-01 12:32 PST - MCP Argument Parsing Syntax

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The initial attempts to call the validation tool failed because I used incorrect argument syntax. I tried:
- `--file_path run.xs` (wrong: treated as literal code)
- `--file_path "run.xs"` (wrong: still treated as code)

The correct syntax requires using `key=value` format: `file_path=run.xs`

**Why it was an issue:** The error message "Expecting --> function <-- but found --> '-' <--" was confusing at first because it made it seem like the XanoScript code had errors, when actually the MCP tool was interpreting my command-line arguments as XanoScript code to validate.

**Potential solution (if known):** The mcporter help text shows the correct syntax, but it might be helpful to have clearer error messages when the MCP receives arguments in the wrong format, or have examples in the Xano MCP documentation showing the correct calling convention.

---

## 2026-03-01 12:33 PST - Relative Path Resolution

**What I was trying to do:** Validate files using relative paths from the exercise directory

**What the issue was:** When using `file_path=run.xs` from within the `~/xs/maximum-bags/` directory, the MCP returned "File not found: run.xs"

**Why it was an issue:** The MCP appears to resolve paths from a different working directory than where the command is executed. I had to use absolute paths (`/Users/justinalbrecht/xs/maximum-bags/run.xs`) for validation to work.

**Potential solution (if known):** The MCP could either:
1. Respect the shell's current working directory for relative path resolution
2. Accept a `cwd` or `working_directory` parameter to set the context for relative paths
3. Document that absolute paths are required

---

## 2026-03-01 12:35 PST - No Built-in Sort Filter

**What I was trying to do:** Sort an array of integers as part of the greedy algorithm

**What the issue was:** XanoScript doesn't appear to have a built-in `sort` filter for arrays. I had to implement bubble sort manually.

**Why it was an issue:** For a coding exercise this is fine (and actually appropriate), but for production use cases, having to manually implement sorting algorithms is error-prone and inefficient. The existing exercises all implement their own sorting when needed.

**Potential solution (if known):** Consider adding a `sort` filter to XanoScript, e.g.:
- `$array|sort` for ascending sort
- `$array|sort:"desc"` for descending sort
- `$array|sort:"asc"` for explicit ascending

---

## 2026-03-01 12:36 PST - Set Filter for Arrays

**What I was trying to do:** Update an element at a specific index in an array during the bubble sort swap operation

**What the issue was:** I initially wasn't sure if the `set` filter would work on arrays (it's documented for objects). Testing showed it does work for array indices.

**Why it was an issue:** Uncertainty about whether `set` works on arrays required trial and error.

**Potential solution (if known):** The documentation could clarify that `set` works for both objects (with string keys) and arrays (with integer indices).

---

## Summary

Overall, the development experience was smooth once the correct MCP calling syntax was understood. All files validated successfully on the first attempt, which suggests the XanoScript syntax is consistent and the error messages from the validator are helpful when there are actual code issues.

The main friction points were:
1. MCP argument syntax (easily resolved once understood)
2. Path resolution requiring absolute paths
3. Lack of built-in sort functionality (minor inconvenience for this use case)

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 19:08 PST - file_paths parameter parsing issue

**What I was trying to do:** Validate multiple specific files using the `file_paths` parameter

**What the issue was:** When passing comma-separated file paths to `file_paths`, the MCP tool interpreted the string character by character, treating each character as a separate file path. This resulted in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

**Why it was an issue:** This prevented batch validation of specific files. I had to fall back to using the `directory` parameter instead, which worked fine.

**Potential solution (if known):** The MCP tool may need to properly parse JSON array inputs for the `file_paths` parameter, or the CLI interface needs clearer documentation on how to pass array values (e.g., using `--args` with proper JSON formatting).

---

## 2025-02-23 19:08 PST - Documentation clarity on variable naming

**What I was trying to do:** Understand the correct way to access input variables within a function

**What the issue was:** The quickstart documentation clearly states that inputs must use `$input.fieldname` format, which was helpful. However, I initially wasn't sure if `$input.intervals[$i]` syntax would work for array access.

**Why it was an issue:** Minor uncertainty about whether array indexing works directly on `$input` properties or if I needed to copy to a local variable first.

**Potential solution (if known):** Add an example showing array indexing on input properties in the quickstart documentation, e.g.:
```xs
// Accessing array elements from input
var $first { value = $input.intervals[0] }
```

---

## 2025-02-23 19:08 PST - array.push and array.pop syntax

**What I was trying to do:** Push new elements to the result array

**What the issue was:** The quickstart docs don't cover array manipulation functions like `array.push`, `array.pop`. I had to look at existing examples to understand the syntax.

**Why it was an issue:** Without existing examples, I wouldn't have known the correct syntax for array operations.

**Potential solution (if known):** Add array manipulation functions to the quick_reference or cheatsheet documentation topics.

---

*Overall the experience was smooth once I referenced existing examples. The validation tool is very helpful!*

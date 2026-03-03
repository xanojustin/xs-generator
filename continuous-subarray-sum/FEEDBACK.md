# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 00:30 PST] - While loop syntax confusion

**What I was trying to do:** Fix the syntax error in the `check_subarray_sum.xs` function where the while loops were incorrectly structured.

**What the issue was:** The original code used `stack` as the body of `while` loops:
```xs
while (($i < (($input.nums|count) - 1)) && !$found) {
  stack {
    // loop body
  }
}
```

The validation error was:
```
[Line 20, Column 62] Expecting --> each <-- but found --> '
' <--
```

**Why it was an issue:** The error message was not very clear - it said "expecting 'each'" but didn't explain that `while` loops require `each` as their body block. I had to consult the `xanoscript_docs` documentation to learn that the correct syntax is:
```xs
while ($condition) {
  each {
    // loop body
  }
}
```

**Potential solution (if known):** 
1. Improve the error message to say something like: "while loops must use 'each' as their body block, found 'stack'"
2. Include this in the essentials/quick reference documentation with a clear example of `while` loop syntax
3. Consider allowing `stack` as an alternative to `each` for while loops if there's no semantic difference

---

## [2025-03-03 00:25 PST] - MCP tool parameter formatting

**What I was trying to do:** Validate multiple files at once using the `validate_xanoscript` tool with `file_paths` parameter.

**What the issue was:** Passing JSON arrays through shell commands is error-prone. The first attempt:
```bash
mcporter call xano.validate_xanoscript file_paths:'["~/xs/...", "~/xs/..."]'
```
Failed with shell escaping issues.

**Why it was an issue:** Had to switch to validating files one at a time using `file_path` instead of batch validation with `file_paths`.

**Potential solution (if known):** 
1. Add support for passing multiple `file_path` arguments without needing JSON array syntax
2. Or add a `directory` parameter that properly expands paths and finds .xs files recursively

---

## General Observations

**Positive:** The `xanoscript_docs` tool with `mode:quick_reference` is very helpful for getting concise syntax information without burning too much context.

**Suggestion:** A `validate_and_fix` or `suggest_fix` option in the validation tool that provides not just the error but a suggested correction would be very helpful for common syntax mistakes.

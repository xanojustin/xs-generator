# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 17:05 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run job that orchestrates multiple test cases for the calculator function.

**What the issue was:** I initially wrote the run.job with a `stack` block containing multiple function calls and debug.log statements, similar to how functions work. The validation failed because `run.job` has a completely different structure - it only accepts `main` and `env` properties, not arbitrary code blocks.

**Why it was an issue:** The quickstart documentation showed `run.job` in the quick reference but didn't clearly explain its restricted syntax. I assumed it worked like a function with a stack block.

**Potential solution (if known):** 
- The run.job documentation could benefit from a "Common Mistakes" section showing what NOT to do
- A side-by-side comparison of `function` vs `run.job` structure would be helpful
- The error message "The argument 'stack' is not valid in this context" was clear, but I had to read the full run documentation to understand the correct structure

---

## [2025-02-21 17:08 PST] - Reserved Variable Names

**What I was trying to do:** Declare a variable named `$response` in my function to hold the response data before returning it.

**What the issue was:** Got error: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:** I knew `$response` was used at the end with `response = $response`, but I didn't realize I couldn't use it as a temporary variable name within the stack. The error message was very helpful though - it suggested using `$my_response` instead.

**Potential solution (if known):** The error message was excellent here - clear explanation and helpful suggestion. No changes needed.

---

## [2025-02-21 17:10 PST] - Missing Input Clause Requirement

**What I was trying to do:** Create a test runner function that doesn't need any input parameters.

**What the issue was:** The validation failed with `function is missing an input clause` even though the function genuinely doesn't need any inputs.

**Why it was an issue:** Many languages allow functions without parameters, but XanoScript requires an empty `input { }` block. The quickstart shows `input { }` in one example but doesn't explicitly state it's required even when empty.

**Potential solution (if known):** 
- The functions documentation could state "All functions must have an input clause, even if empty"
- Add this to the "Common Mistakes" section: "Forgetting input clause on parameter-less functions"

---

## [2025-02-21 17:12 PST] - Filter Expression Parentheses

**What I was trying to do:** Check if an operation is valid by filtering an array and checking if the result has any items.

**What the issue was:** Expression `($valid_operations|filter:$$ == $input.operation)|count > 0` failed validation with "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The precedence rules for filters vs comparisons weren't intuitive. I needed to wrap the entire filter+count expression in parentheses before comparing to 0.

**Potential solution (if known):** 
- The quickstart "Common Mistakes" section has this exact issue documented! I should have read it more carefully.
- Maybe the error message could suggest the fix: "Try: (($valid_operations|filter:...) | count) > 0"

---

## [2025-02-21 17:15 PST] - MCP Tool Works Well

**Positive feedback:** The `validate_xanoscript` tool worked flawlessly. It caught all my syntax errors with clear line numbers and helpful messages. The iterative write → validate → fix loop was smooth.

**Suggestion:** It would be helpful if the MCP had a `format_xanoscript` or `fix_xanoscript` tool that could auto-fix simple issues like:
- Adding missing empty input clauses
- Renaming reserved variables
- Adding parentheses around filter expressions

This would reduce the manual fix cycle for common mistakes.

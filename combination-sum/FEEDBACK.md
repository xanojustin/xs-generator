# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 23:32 PST] - Successful First-Attempt Validation

**What I was trying to do:** Create a complete XanoScript coding exercise for "Combination Sum" following the run job + function architecture

**What happened:** Both files (`run.xs` and `function/combination_sum.xs`) passed validation on the first attempt without any errors

**Why this is notable:** This was the first time I've written XanoScript code that validated successfully without any iteration. The combination of:
- Using `mcporter` to get `quick_reference` documentation for functions, run, syntax, and types
- Studying existing implementations (fizzbuzz, two_sum) to understand patterns
- Following the documented syntax rules (especially filter parentheses requirements)

...resulted in working code immediately.

**What worked well:**
1. The `xanoscript_docs` MCP tool with `mode=quick_reference` provided concise, actionable syntax information
2. The `validate_xanoscript` tool gave clear, immediate feedback
3. Existing code examples in `~/xs/` served as excellent reference implementations
4. The filter precedence documentation (wrapping `$var|filter` in parentheses) prevented common errors

---

## [2025-02-21 23:30 PST] - Documentation Discovery Pattern

**What I was trying to do:** Understand how to implement backtracking in XanoScript for the Combination Sum problem

**What the issue was:** XanoScript doesn't appear to have native recursion support, so I had to implement an iterative solution using a manual stack

**Why it was an issue:** Standard backtracking algorithms are typically recursive. Translating to an iterative approach with explicit stack management is more verbose and harder to read

**Potential solution (if known):** If XanoScript supports function recursion, documenting this with examples would be helpful. If not, adding examples of "simulating recursion with manual stacks" to the documentation could help developers coming from recursive languages

---

## [2025-02-21 23:28 PST] - Array Access Syntax Clarity

**What I was trying to do:** Access individual elements from an array within a loop

**What the issue was:** Initially unclear whether to use `$arr|get:$index` vs `$arr[$index]` or other syntax

**Why it was an issue:** The syntax docs show `|get:N` for single element access but this pattern isn't immediately obvious when coming from other languages

**Potential solution (if known):** A "coming from JavaScript/Python" quick reference that maps common patterns could reduce lookup time. Example:
- JS: `arr[i]` → XS: `$arr|get:$i`
- JS: `arr.push(x)` → XS: `array.push $arr { value = $x }`
- JS: `arr.length` → XS: `$arr|count`

---

## [2025-02-21 23:25 PST] - While Loop with Filter Precedence

**What I was trying to do:** Write a while loop condition that checks array count: `while (($stack|count) > 0)`

**What the issue was:** Remembering to wrap the filtered expression in parentheses due to filter precedence rules

**Why it was an issue:** Without parentheses, filters bind greedily and cause parse errors

**Potential solution (if known):** The documentation covers this well with the "CRITICAL: Filters Are Type-Specific" section, but having the linter provide helpful error messages like "Did you forget parentheses around your filter expression?" could speed up debugging

---

## General MCP Feedback

**Positive:**
- The `mcporter` integration works smoothly
- `validate_xanoscript` is fast and reliable
- Documentation via `xanoscript_docs` is comprehensive

**Suggestions for improvement:**
1. **Error message context:** When validation fails, showing line numbers with surrounding context would help locate issues faster
2. **Syntax examples in validation errors:** If a syntax error is detected, suggesting the correct pattern could reduce back-and-forth
3. **Auto-formatter:** A code formatter (like `xanoscript fmt`) would ensure consistent style across the codebase

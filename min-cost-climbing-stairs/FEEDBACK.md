# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 12:35 PST] - Conditional Expression Syntax

**What I was trying to do:** Write conditional statements with comparisons involving filters (like `count`)

**What the issue was:** The syntax `if ($input.costs|count == 0)` fails validation with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This is confusing because the error suggests wrapping in parentheses, but what actually works is using backticks around the entire condition. The correct syntax is:
```xs
if (`($input.costs|count) == 0`) { ... }
```

**Potential solution:** The error message could be clearer about using backticks for conditional expressions, or the syntax could allow unwrapped expressions like other languages.

---

## [2025-02-24 12:36 PST] - Inline Comments Not Allowed

**What I was trying to do:** Add inline comments after code statements like:
```xs
var $prev2 { value = $input.costs[0] }  // Cost to reach step 0
```

**What the issue was:** The validator fails with: "Expecting: expecting at least one iteration which starts with... but found: '/'"

**Why it was an issue:** Most programming languages allow inline comments. Having to put comments on separate lines is unexpected and disrupts the flow of reading code.

**Potential solution:** Support inline comments after statements, or document this restriction clearly in the quickstart guide.

---

## [2025-02-24 12:36 PST] - elseif Syntax

**What I was trying to do:** Write an if-else-if chain using multiple `if` statements inside a `conditional` block

**What the issue was:** The parser expects `elseif` not a second `if` statement inside the same `conditional` block

**Why it was an issue:** In many languages, you can have multiple independent if statements. XanoScript requires using `elseif` which is fine, but the error message "Expecting: [if] but found: 'if'" is confusing.

**Potential solution:** A clearer error message like "Use 'elseif' instead of 'if' for additional conditions in a conditional block" would help.

---

## [2025-02-24 12:37 PST] - File Path Resolution

**What I was trying to do:** Validate files using relative paths from the current directory

**What the issue was:** The validator couldn't find files when using relative paths like `run.xs` even when in the correct directory

**Why it was an issue:** Had to use absolute paths which is cumbersome when working in a specific directory

**Potential solution:** Support relative paths or document that absolute paths are required.

---

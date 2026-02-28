# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 04:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Calculate the new index after visiting a URL using `$new_history|count - 1`

**What the issue was:** Got validation error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message was clear, but this syntax requirement is easy to forget. In my head, `|count` is a simple filter that returns a number, so subtracting from it feels natural without parentheses.

**Potential solution (if known):** The documentation mentions this in the "Common Mistakes" section, but it might help to have a linter warning or auto-formatter that adds these parentheses automatically.

---

## [2025-02-28 04:36 PST] - Switch Default Case Break Syntax

**What I was trying to do:** Create a switch statement with a default case that has a `break` after it, following the pattern of other cases.

**What the issue was:** Got validation error: "Expecting `}` but found `break`" on line 134

**Why it was an issue:** The documentation says "The `default` case does not need `break`." but I missed that detail. It's counterintuitive that `default` behaves differently from `case` blocks - I would expect consistency where either all cases need `break` or none do.

**Potential solution (if known):** Either allow `break` in default for consistency, or improve the error message to say something like "Remove 'break' from default case - it is not needed."

---

## [2025-02-28 04:30 PST] - Array Index Access Syntax

**What I was trying to do:** Access an element in an array by index using `$input.history[$i]` and `$input.history[$new_index]`

**What the issue was:** I wasn't sure if this syntax was valid since it wasn't explicitly shown in the documentation examples I read.

**Why it was an issue:** Had to guess/infer that array indexing works with bracket notation. The documentation focuses more on filters like `|first`, `|last` than direct indexing.

**Potential solution (if known):** Add explicit documentation about array indexing syntax `$array[index]` in the essentials or syntax documentation.

---

## [2025-02-28 04:32 PST] - While Loop for Array Building

**What I was trying to do:** Build a new array by copying elements from an existing array up to a certain index.

**What the issue was:** XanoScript doesn't have a built-in slice or take operation for arrays, so I had to use a `while` loop with manual indexing.

**Why it was an issue:** The loop pattern is verbose and error-prone. I had to manually track an index counter and use `var.update` to increment it.

**Potential solution (if known):** Would be nice to have a `|slice:start:end` or `|take:n` filter for arrays, or a range-based for loop like `for ($i in 0..$n)`.

---

## General Observations

**Positive:**
- The `xanoscript_docs` MCP tool is very helpful and provides comprehensive documentation
- Error messages are generally clear and include line numbers
- The validation tool catches syntax errors before runtime

**Areas for improvement:**
- The distinction between `var` (declaration) and `var.update` (mutation) is clear but can feel verbose when doing simple increment operations like `$i = $i + 1`
- Array manipulation is powerful with filters but lacks some common operations like slicing
- Would love to see more examples of stateful design patterns (like this browser history problem) in the documentation
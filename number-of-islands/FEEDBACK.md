# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 13:05 PST] - Array Function Syntax Confusion

**What I was trying to do:** Implement a DFS stack-based algorithm for the Number of Islands problem using `array.pop` to remove elements from the stack.

**What the issue was:** I initially wrote `array.pop $stack {}` based on the pattern I saw with `array.push $stack { value = ... }`. However, the correct syntax is `array.pop $stack as $variable`.

**Why it was an issue:** This caused a validation error that wasn't immediately obvious from the documentation structure. The error message was clear (`Expecting --> as <-- but found --> '`), but I had to search through the syntax documentation to find the correct pattern.

**Potential solution:** It would be helpful if the quickstart documentation included a side-by-side comparison of `array.push` vs `array.pop` syntax since they differ (one uses `{ value = ... }` block, the other uses `as $variable`).

---

## [2026-02-20 13:05 PST] - Finding Array Function Documentation

**What I was trying to do:** Find the correct syntax for array operations (specifically `array.pop`).

**What the issue was:** The array function documentation is in the `syntax` topic under "Array Functions" section, but I initially looked in the `functions` topic which focuses on user-defined functions rather than built-in array operations.

**Why it was an issue:** It took some exploration to find the right documentation topic. The organization makes sense in retrospect, but a quick reference card showing "For array operations, see syntax topic > Array Functions" in the quickstart would help.

**Potential solution:** Add a cross-reference in the quickstart's "Common Patterns" section that points to where array manipulation functions are documented.

---

## [2026-02-20 13:05 PST] - Directory Validation Works Well

**What I was trying to do:** Validate multiple files at once.

**What worked well:** Using `directory` parameter with `validate_xanoscript` worked perfectly and validated all `.xs` files in the folder.

**Positive feedback:** The batch validation with summary output ("Validated 2 file(s): 1 valid, 1 invalid") is very helpful for quickly seeing the status of all files.

---

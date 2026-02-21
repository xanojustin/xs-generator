# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 03:00 PST] - Bitwise operation syntax confusion

**What I was trying to do:** Implement a bit manipulation algorithm (sum of two integers using XOR and AND operations)

**What the issue was:** I initially tried using `math.bitwise.and($x, $y)` syntax based on seeing it in the syntax documentation under "Math Domain Functions" section. However, this syntax doesn't work in variable declarations. The validation error was: `Expecting: Expected an expression but found: 'math'`

**Why it was an issue:** The documentation shows both statement-level functions (`math.bitwise.and $var { value = ... }`) and filter-style functions (`math.bitwise.and(5, 3)`), but it wasn't clear that the filter-style function syntax only works in specific contexts, not in variable value expressions.

**Potential solution (if known):** 
1. Clarify in documentation that `math.bitwise.and(a, b)` syntax only works as a standalone expression, not inside `var { value = ... }` blocks
2. Provide more examples showing the correct filter syntax `$a|bitwise_and:$b` for use in variable declarations
3. Add a cross-reference between the "Math Functions" section and "Filters" section for bitwise operations

**What actually worked:** Using filter syntax `$x|bitwise_and:$y` and `$x|bitwise_xor:$y`

---

## [2025-02-21 03:05 PST] - Missing bitwise left shift operation

**What I was trying to do:** Implement the classic bit addition algorithm which requires left shift (`<< 1`) for the carry

**What the issue was:** XanoScript doesn't appear to have a bitwise left shift operator or filter. The syntax documentation shows `math.bitwise.and`, `math.bitwise.or`, and `math.bitwise.xor`, but no shift operations.

**Why it was an issue:** Left shift is fundamental to many bit manipulation algorithms. Without it, I had to work around by using multiplication by 2 (`* 2`), which achieves the same result but is less clear in intent for bit manipulation exercises.

**Potential solution (if known):**
1. Add `bitwise_shift_left` and `bitwise_shift_right` filters for completeness
2. Document that multiplication/division by powers of 2 can be used as alternatives

**Workaround used:** Replaced `carry << 1` with `carry * 2`

---

## [2025-02-21 03:00 PST] - MCP server connection issues

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter

**What the issue was:** Initially got "Unknown MCP server 'xano'" errors when trying to use `mcporter call xano.validate_xanoscript`. The daemon wasn't running and auto-detection failed.

**Why it was an issue:** Had to explicitly specify `--config ~/.openclaw/workspace/config/mcporter.json` for every call, even though that should be the default location.

**Potential solution (if known):**
1. Ensure daemon starts automatically or mcporter finds the config in the workspace
2. Better error messages suggesting the `--config` flag when servers aren't found

**Workaround used:** Added `--config ~/.openclaw/workspace/config/mcporter.json` to all mcporter calls

---

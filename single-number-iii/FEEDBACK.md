# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-27 09:32 PST] - Bitwise operators not standard syntax

**What I was trying to do:** Implement a bit manipulation algorithm (Single Number III) that requires XOR, AND, and negation operations.

**What the issue was:** XanoScript doesn't use standard C-style bitwise operators (`^`, `&`, `|`, `~`, `-` for negation). Instead, it uses:
- `math.bitwise.xor $var { value = $other }` for XOR
- `math.bitwise.and $var { value = $other }` for AND
- `|bitwise_not` filter for NOT
- `|add:1` after bitwise_not to get two's complement negation

The validation errors were cryptic - expecting `}` but finding the variable name or operator, which didn't clearly indicate that the operators were invalid.

**Why it was an issue:** I spent multiple validation cycles trying to figure out why `^`, `&`, and `-` weren't working. The error messages didn't indicate "unknown operator" or "use math.bitwise.xor instead" - they just said unexpected token.

**Potential solution (if known):** 
1. Better error messages for invalid operators (e.g., "Unknown operator ^, use math.bitwise.xor instead")
2. Include a prominent note in the `essentials` documentation about bitwise operations being different from standard languages
3. The `syntax/functions` documentation exists but isn't referenced from `essentials` - maybe add a "Common operations from other languages" section

---

## [2026-02-27 09:35 PST] - var vs var.update confusion

**What I was trying to do:** Update a variable inside a foreach loop.

**What the issue was:** I initially used `var $xor_result { value = $xor_result ^ $num }` thinking it would update the existing variable, but XanoScript requires `var.update $xor_result { value = ... }` for updates.

**Why it was an issue:** The error message "Expecting } but found $num" didn't clearly indicate that I should use `var.update` instead of `var`. It looked like a syntax error in the expression.

**Potential solution (if known):**
1. Error message could detect when `var` is used with an existing variable name and suggest `var.update`
2. Add a specific section in `essentials` about variable declaration vs update patterns

---

## [2026-02-27 09:38 PST] - Documentation organization

**What I was trying to do:** Find information about bitwise operations.

**What the issue was:** The bitwise operations are documented in `syntax/functions` but not in the main `syntax` or `essentials` topics. It took multiple searches to find them.

**Why it was an issue:** Coming from other languages, I expected bitwise operators to be in the main syntax documentation or mentioned in essentials as "different from standard operators."

**Potential solution (if known):**
1. Add a "Operators comparison with other languages" section to `essentials`
2. Cross-reference related topics more explicitly (e.g., "For bitwise operations, see syntax/functions")
3. Consider adding a topic index or search functionality to the docs tool

---

## [2026-02-27 09:40 PST] - MCP validation tool requires full paths

**What I was trying to do:** Validate files using relative paths like `~/xs/single-number-iii/run.xs`.

**What the issue was:** The validation tool returned "File not found" when using `~` expansion. Had to use full absolute paths like `/Users/justinalbrecht/xs/single-number-iii/run.xs`.

**Why it was an issue:** Minor inconvenience - had to expand paths manually instead of using shell shortcuts.

**Potential solution (if known):** Support shell expansion (`~`) or relative paths from current working directory in the validate_xanoscript tool.

---

## [2026-02-27 09:42 PST] - General feedback on MCP tool

**What worked well:**
- The validation tool is fast and helpful once you understand the syntax
- Documentation via `xanoscript_docs` is comprehensive when you find the right topic
- The error locations (line/column) are accurate

**What could be improved:**
1. Error messages could be more semantic (e.g., "unknown operator" vs "unexpected token")
2. A single-page "cheat sheet" or "migrating from JavaScript/Python" document would be helpful
3. More cross-linking between related documentation topics
4. Consider validating a directory recursively instead of individual files
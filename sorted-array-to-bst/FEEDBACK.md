# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 20:05 PST] - File Path Expansion Issue

**What I was trying to do:** Validate XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The tool doesn't expand shell paths like `~/xs/...` - it requires absolute paths like `/Users/justinalbrecht/xs/...`

**Why it was an issue:** Had to troubleshoot why "File not found" errors were occurring when the files clearly existed

**Potential solution:** The MCP could expand common shell path patterns (like `~` for home directory) before validation

---

## [2026-02-22 20:06 PST] - No Recursive Function Support

**What I was trying to do:** Implement the BST conversion using recursion (the natural solution)

**What the issue was:** XanoScript doesn't support recursive function calls - functions cannot call themselves

**Why it was an issue:** The "Sorted Array to BST" problem is classically solved with a simple recursive divide-and-conquer approach. Without recursion, I had to implement an iterative solution using explicit stack management and post-order traversal, which is significantly more complex (~120 lines vs ~20 lines).

**Potential solution:** Document this limitation clearly in the functions documentation. Consider adding support for recursion or at least documenting workarounds like the explicit stack pattern I used.

---

## [2026-02-22 20:07 PST] - Missing Array Index Access Pattern Documentation

**What I was trying to do:** Access array elements by index

**What the issue was:** Had to figure out the pattern: `$array|get:(index|to_text)` - converting the index to text for the get filter key

**Why it was an issue:** Not immediately obvious from docs that array access requires string keys via the `get` filter

**Potential solution:** Add a clear example of array index access in the quickstart or syntax documentation

---

## [2026-02-22 20:08 PST] - Boolean AND Operator Confusion

**What I was trying to do:** Combine two boolean conditions with AND logic

**What the issue was:** Unclear whether to use `&&`, `and`, or something else

**Why it was an issue:** The syntax documentation doesn't clearly show boolean operators in the examples I saw

**Potential solution:** Add a clear operator precedence table showing `&&` for AND, `||` for OR, etc.

---

## General Observations

**What worked well:**
- The `xanoscript_docs` MCP tool was very helpful for getting syntax information
- The quickstart guide had good common patterns
- Validation tool gave clear pass/fail results

**Suggestions for improvement:**
1. Add a "common algorithms" section showing how to implement recursion-like patterns
2. Document array access patterns more explicitly
3. Consider a "cookbook" of data structure implementations (trees, graphs, etc.)

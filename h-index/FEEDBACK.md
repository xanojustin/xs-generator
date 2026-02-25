# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 23:05 PST] - Sort filter syntax confusion for primitive arrays

**What I was trying to do:** Sort an array of integers (`int[]`) in descending order to implement the h-index algorithm efficiently.

**What the issue was:** I initially tried `$input.citations|sort:value:desc` which resulted in a parse error. The `sort` filter appears to be designed for arrays of objects where you specify a field name, not for primitive arrays.

**Why it was an issue:** The documentation shows `sort:n:text:false` which sorts objects by the `n` field. There's no clear guidance on how to sort primitive arrays like `int[]`. I had to rewrite my algorithm to avoid sorting entirely.

**Potential solution (if known):** 
- Document whether primitive arrays can be sorted and what the syntax would be (e.g., `sort::int:desc` with empty field name, or a different filter like `sort_ints`)
- If sorting primitives isn't supported, explicitly mention this limitation in the array filters documentation
- Consider adding a `sort_desc` or `sort_asc` filter that works on primitive arrays

---

## [2025-02-24 23:08 PST] - While loop requires `each` block

**What I was trying to do:** Write a while loop to iterate and find the h-index.

**What the issue was:** I initially wrote `while ($h > 0) { ... }` without the `each` block inside. The documentation mentions that while loops need an `each` block but it's easy to miss.

**Why it was an issue:** The syntax requirement of wrapping while loop bodies in `each { ... }` is unusual compared to other languages and the error messages don't clearly indicate this requirement.

**Potential solution (if known):** 
- Consider making the `each` block optional for while loops, or rename it to something more descriptive like `body` or `do`
- Add a clearer error message like "while loop body must be wrapped in an 'each' block"

---

## [2025-02-24 23:10 PST] - Overall positive experience

**What worked well:**
- The MCP validation tool is very helpful with clear error messages showing line/column numbers
- The documentation is comprehensive, especially the quickstart guide with common patterns
- The separation of concerns between run.job (entry point) and function (logic) is clean

**General feedback:**
- More examples for primitive array operations would be helpful
- A "recipes" section for common algorithms (sorting, searching, etc.) would be valuable

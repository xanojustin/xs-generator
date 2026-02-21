# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 08:05 PST] - Documentation Index Returns Same Content

**What I was trying to do:** Get specific documentation on XanoScript syntax for loops, conditionals, and array operations for the 3Sum implementation.

**What the issue was:** Calling `xanoscript_docs` with topics like `syntax`, `functions`, `quickstart`, and `run` all returned the same general index/documentation overview page instead of specific detailed documentation for each topic.

**Why it was an issue:** I couldn't access specific syntax documentation for:
- Proper `while` loop syntax
- Array access patterns (e.g., `$array[$index]`)
- How to properly increment variables in loops
- The `continue` statement usage
- How to properly skip duplicates in nested loops

I had to rely on existing code examples in the `~/xs/` directory to infer correct syntax patterns.

**Potential solution (if known):** 
- Ensure the MCP server returns topic-specific documentation
- Or provide a note in the index that detailed docs need to be accessed differently
- Consider including more code examples directly in the main index for common patterns

---

## [2026-02-21 08:07 PST] - Validation Tool Parameter Format Confusion

**What I was trying to do:** Validate the XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:** The parameter format for the tool was unclear. I initially tried JSON format `'{"file_paths": [...]}'` which didn't work, then tried `'file_paths=["..."]'` format which did work.

**Why it was an issue:** The tool description mentions the parameter names but doesn't clearly indicate the exact CLI format expected. I had to trial-and-error to find the correct format.

**Potential solution (if known):**
- Include a clear example in the tool description showing the exact CLI format
- Or support JSON format as well for easier programmatic use

---

## [2026-02-21 08:08 PST] - Array Index Access Syntax Unclear

**What I was trying to do:** Access array elements by index in the 3Sum algorithm (e.g., `$sorted_nums[$i]`).

**What the issue was:** The documentation didn't clearly specify the syntax for array element access. I wasn't sure if it was:
- `$array[$index]`
- `$array.index`
- `$array[$index].value`
- Some other pattern

**Why it was an issue:** Array indexing is fundamental for the two-pointer algorithm. I had to look at existing implementations to find the pattern.

**Potential solution (if known):**
- Add a section on array/list operations in the documentation
- Include examples of: accessing by index, setting values, iterating

---

## [2026-02-21 08:09 PST] - Continue Statement in Loops

**What I was trying to do:** Use a `continue` statement to skip iterations when duplicates are found.

**What the issue was:** Unclear if `continue` is a valid keyword in XanoScript, or if I need to use a different pattern like nested conditionals.

**Why it was an issue:** In the anagram-detection example, I saw `return { value = ... }` being used, but wasn't sure about `continue`. Looking at the two-sum example would have helped, but I had to just try it and see if validation passed.

**Potential solution (if known):**
- Document control flow keywords: `continue`, `break`, `return` and their usage contexts
- Clarify the difference between `return` in functions vs within loops

---

## General Positive Feedback

**What worked well:**
- The validation tool is fast and gives clear pass/fail results
- The directory structure conventions are well-documented
- Having existing examples in `~/xs/` was extremely helpful for learning patterns
- The type system (int[], text[], etc.) is intuitive
- The filter/pipe syntax (`|sort`, `|merge`, etc.) is elegant and readable

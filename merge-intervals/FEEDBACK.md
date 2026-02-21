# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-21 08:35 PST - File Paths Parameter Issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated values

**What the issue was:** The validation tool seems to have issues parsing comma-separated file paths. When I passed `file_paths="/Users/justinalbrecht/xs/merge-intervals/run.xs,/Users/justinalbrecht/xs/merge-intervals/function/merge_intervals.xs"`, the tool split the string by individual characters and tried to validate each character as a file path, resulting in errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** This made the `file_paths` parameter unusable for batch validation. I had to work around it by using the `directory` parameter instead.

**Potential solution (if known):** The MCP tool should properly parse comma-separated file paths, or the documentation should clarify the expected format (perhaps as a JSON array instead of comma-separated string).

---

## 2025-02-21 08:32 PST - Documentation Discovery

**What I was trying to do:** Understand how to access object properties within arrays and sort them

**What the issue was:** It took some searching through the documentation to find that:
1. To sort objects by a property: `$array|sort:"field":"type":true`
2. To access object properties in filters: use `$$.property` or `$obj|get:"key"`
3. Ternary operator works as expected: `$condition ? true_val : false_val`

**Why it was an issue:** While the docs are comprehensive, finding the specific pattern for "sort array of objects by property" required reading through multiple sections. The `sort` filter example only showed basic usage.

**Potential solution (if known):** More examples in the quick reference for common patterns like sorting objects by property, accessing nested values, etc. A "cookbook" section with common array/object manipulation patterns would be helpful.

---

## 2025-02-21 08:30 PST - Syntax Clarity

**What I was trying to do:** Understand the proper syntax for updating an element in an array

**What the issue was:** XanoScript doesn't have a direct "update array element at index" operation. I had to work around this by:
1. Popping the last element
2. Pushing the updated element

**Why it was an issue:** This is less intuitive than direct array indexing for updates. The pattern `array[$index] = new_value` doesn't exist.

**Potential solution (if known):** Consider adding an `array.update` function or allowing direct assignment to array indices within the variable update syntax.

---

## General Observations

### What Worked Well
- The documentation for `xanoscript_docs` is comprehensive and well-organized
- The validation tool provides clear feedback when syntax is correct
- The `directory` validation option is convenient for batch checking

### Suggestions for Improvement
1. **More sort examples:** Show sorting objects by multiple fields, sorting with custom comparators
2. **Array manipulation patterns:** Common patterns like "update element at index", "find and replace", "remove by condition"
3. **Error message improvements:** When validation fails, show the specific line and context
4. **JSON array support for file_paths:** Allow passing file paths as a proper JSON array to avoid parsing issues

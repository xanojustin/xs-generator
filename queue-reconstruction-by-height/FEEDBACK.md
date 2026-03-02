# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 14:35 PST] - custom_sort with comparator not available

**What I was trying to do:** Sort an array of arrays using a custom comparator function that compares two elements at a time

**What the issue was:** Attempted to use `custom_sort` filter with a `comparator` parameter containing an arrow function `($a, $b) => {...}`. This syntax is not supported.

**Why it was an issue:** The documentation mentions `custom_sort` but doesn't clarify that comparator functions/arrow functions aren't supported. Had to implement bubble sort manually which is O(n²) instead of using native O(n log n) sorting.

**Potential solution (if known):** 
- Document which filter functions are available and their exact signatures
- Consider adding support for comparator functions or providing a `sort_by` filter that accepts field indices

---

## [2026-03-02 14:38 PST] - Cannot nest conditionals in elseif

**What I was trying to do:** Write a nested conditional inside an `elseif` block to handle secondary sorting criteria

**What the issue was:** Wrote:
```xs
elseif ($person1[0] == $person2[0]) {
  if ($person1[1] > $person2[1]) {
    var $should_swap { value = true }
  }
}
```

This caused a parse error: "Expecting '}' but found 'if'"

**Why it was an issue:** The parser doesn't allow `if` statements nested directly inside `elseif` branches. Had to combine conditions using `&&` operator.

**Potential solution (if known):**
- Document that conditionals cannot be nested in elseif blocks
- Or allow nested conditionals for more complex logic

---

## [2026-03-02 14:30 PST] - Input block syntax confusion

**What I was trying to do:** Define input parameters with descriptions inline like `object[] people { description = "..." }`

**What the issue was:** This syntax isn't valid. The input block expects either just type and name on one line, or a different structure.

**Why it was an issue:** The error message suggested using "type[]" instead of "array" but the real issue was the inline description syntax. The MCP error was misleading.

**Potential solution (if known):**
- Better error messages for input block syntax errors
- Document the exact allowed patterns for input blocks

---

## [2026-03-02 14:32 PST] - Array of arrays type not available

**What I was trying to do:** Define an input parameter for an array of [height, k] pairs (array of arrays)

**What the issue was:** Tried using `object[]`, `json[]`, `int[][]` - none worked for array of arrays

**Why it was an issue:** Had to use `json` type which is less specific and doesn't provide type validation

**Potential solution (if known):**
- Add support for nested array types like `int[][]` or `object[]`
- Or document how to handle arrays of complex structures

---

## [2026-03-02 14:40 PST] - validate_xanoscript parameter format unclear

**What I was trying to do:** Call the `validate_xanoscript` MCP tool with file paths

**What the issue was:** Initially tried using JSON syntax with `--input` flag but the parameter passing format wasn't clear from the tool description.

**Why it was an issue:** Tried multiple formats:
- `--input '{"file_paths": [...]}'` - didn't work
- `--input '{"directory": "..."}'` - didn't work
- `directory:/path` - worked!

**Potential solution (if known):**
- Better documentation for mcporter call syntax
- Examples in the tool description showing proper parameter format

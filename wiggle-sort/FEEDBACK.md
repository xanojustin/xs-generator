# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 06:33 PST] - Missing array_update filter

**What I was trying to do:** Update an element at a specific index in an array during the wiggle sort algorithm (swapping elements).

**What the issue was:** I assumed there was an `array_update` filter based on common patterns in other languages (like JavaScript's array update or similar). I tried to use:
```xs
var $arr { value = $arr|array_update:($i - 1):$curr }
```

**Why it was an issue:** The validation failed with "Unknown filter function 'array_update'". This is a common operation (updating an array element at an index), so I expected a dedicated filter to exist.

**Potential solution:** 
1. The correct syntax is `var.update $arr[$i] { value = ... }` which I discovered by reading an existing implementation (bubble_sort.xs)
2. It would be helpful if the syntax documentation explicitly showed how to update array elements by index
3. Consider adding `array_update` as an alias or documented alternative to `var.update $arr[index]` for discoverability

---

## [2026-02-23 06:33 PST] - Filter parentheses requirement unclear

**What I was trying to do:** Compare the result of a filter (like `$arr|count`) with another value in a conditional.

**What the issue was:** I wrote `if ($input.nums|count <= 1)` without parentheses around the filter expression.

**Why it was an issue:** The parser error said "An expression should be wrapped in parentheses when combining filters and tests" but I initially wasn't sure what the correct wrapping should be. I tried `$input.nums|count <= 1` which failed.

**Potential solution:**
1. The documentation does mention this under "Parentheses and Filter Precedence" but it's easy to miss
2. Consider having the validator auto-suggest the fix: "Did you mean `(($input.nums|count) <= 1)`?"
3. A quick reference card for common filter patterns with parentheses would be helpful

---

## [2026-02-23 06:32 PST] - MCP parameter format confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with the `file_paths` parameter.

**What the issue was:** I initially tried passing parameters as JSON: `'{"file_paths": [...]}'` but that didn't work. Then I tried `'file_paths=["...", "..."]'` which worked.

**Why it was an issue:** The mcporter tool help shows examples like `file_path: "/path/to/file.md"` but it's not clear if that's the CLI syntax or if it needs to be adapted.

**Potential solution:**
1. Clear documentation on how to pass parameters via mcporter CLI
2. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" could suggest the correct format

---

## [2026-02-23 06:30 PST] - Documentation discovery for specific patterns

**What I was trying to do:** Find the correct syntax for array element updates and function definitions.

**What the issue was:** The general documentation topics (functions, syntax) are helpful but don't always cover specific patterns like "how to update an array element at index i".

**Why it was an issue:** I had to read an existing implementation file to discover the correct `var.update $arr[$i]` syntax. This works but isn't ideal for new developers.

**Potential solution:**
1. A "Common Patterns" or "Cookbook" section in the docs with examples like:
   - How to swap array elements
   - How to loop through arrays with index access
   - How to build arrays incrementally
2. A `file_path` parameter for `xanoscript_docs` that gives context-aware help for the specific file type being edited

---

## General Notes

**What worked well:**
- The validator is fast and gives helpful line/column information
- The suggestion to use "int" instead of "integer" is a nice touch
- Having existing examples in ~/xs/ was invaluable for learning patterns

**Overall experience:** Once I understood the basic patterns, development was smooth. The main friction points were:
1. Discovering the correct syntax for array element updates
2. Remembering to wrap filter expressions in parentheses

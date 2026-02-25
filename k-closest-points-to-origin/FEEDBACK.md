# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-25 01:05 PST] - MCP file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP tool parsed the comma-separated string character by character instead of as an array of paths

**Command used:**
```
mcporter call xano.validate_xanoscript file_paths=/Users/justinalbrecht/xs/k-closest-points-to-origin/run.xs,/Users/justinalbrecht/xs/k-closest-points-to-origin/function/k_closest_points.xs
```

**Error output:**
```
Validated 139 file(s): 0 valid, 139 invalid
Error reading file: EISDIR: illegal operation on a directory, read
File not found: U
File not found: s
File not found: e
...
```

Each character of the path was treated as a separate file path.

**Why it was an issue:** Could not batch validate files as documented. Had to fall back to validating files individually using `file_path` parameter.

**Potential solution:** The MCP should properly parse the `file_paths` parameter as a JSON array or properly handle comma-separated values. Alternatively, the documentation should clarify the expected format.

---

## [2026-02-25 01:08 PST] - Confusion about early return pattern

**What I was trying to do:** Implement early return for edge cases (empty input or k=0) in the function

**What the issue was:** Initially tried to use `response = []` inside a conditional block in the stack, but this is not valid XanoScript syntax

**Error:**
```
[Line 19, Column 9] Expecting --> } <-- but found --> 'response' <--
```

**Why it was an issue:** The documentation shows `response = $result` at the end of functions, but doesn't clearly explain that you cannot set response inside the stack. I had to restructure to use a `$result` variable that's set in both branches of the conditional.

**Potential solution:** Document the pattern for handling early returns or conditional responses. Show examples of how to handle edge cases that should return different values.

---

## [2026-02-25 01:12 PST] - Array function naming inconsistency

**What I was trying to do:** Add elements to an array using `array.add`

**What the issue was:** The function is actually named `array.push`, not `array.add`

**Error:**
```
but found: 'add'
💡 Suggestion: Use "type[]" instead of "array"
Code at line 38:
  array.add $points_with_distance { value = $point_entry }
```

**Why it was an issue:** The error message was confusing - it suggested using "type[]" which wasn't helpful. I had to search the full syntax documentation to find the correct function name `array.push`.

**Potential solution:** The error hint could be more specific - instead of suggesting "type[]", it could say "Use array.push instead of array.add".

---

## [2026-02-25 01:15 PST] - Sort filter syntax unclear

**What I was trying to do:** Sort an array of objects by a specific field

**What the issue was:** The sort filter syntax from the quick reference wasn't working. Tried `|sort:"distance":int:"asc"` but that failed.

**Error:**
```
but found: 'int'
```

**Why it was an issue:** The documentation showed `[{n:"z"},{n:"a"}]|sort:n:text:false` but it wasn't clear that:
1. The type parameter needs to be quoted as a string ("int", not int)
2. The direction should be a boolean (false = ascending, true = descending), not strings like "asc"/"desc"

**Potential solution:** Provide clearer examples in the quick reference showing the exact syntax with quoted types and boolean directions.

---

## [2026-02-25 01:18 PST] - Missing sort documentation for array.sort statement function

**What I was trying to do:** Find a statement-level way to sort an array in place

**What the issue was:** Initially tried to use `array.sort` as a statement function (like `array.push`), but it doesn't exist as a statement function - only as a filter

**Why it was an issue:** I was looking for consistency in the API (array.push, array.pop, array.sort...) but sorting is only available as a filter, not a statement function.

**Potential solution:** Document which array operations are available as statement functions vs filters more clearly. The Array Functions section lists push/pop/shift/etc but doesn't mention that sort is filter-only.

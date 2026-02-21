# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 06:33 PST] - Apostrophes in comments cause parse errors

**What I was trying to do:** Write a XanoScript function with comments at the top of the file using standard `//` comment syntax.

**What the issue was:** Comments containing apostrophes (single quotes, `'`) in words like "Removes" cause the parser to fail with errors like:
```
[Line 3, Column 1] Expecting --> function <-- but found --> '' <--
```

**Why it was an issue:** This is unexpected behavior because:
1. Comments should be ignored by the parser entirely
2. Apostrophes are common in English text (e.g., "Remove**s**", "it**'**s", "don**'**t")
3. The error message is confusing - it says it found a single quote instead of the expected keyword
4. This makes writing descriptive comments difficult

**Potential solution:**
- Fix the parser to properly ignore content inside `//` comments regardless of special characters
- Alternatively, document this limitation clearly in the XanoScript docs if it's expected behavior

---

## [2026-02-21 06:35 PST] - Input arrays cannot be modified directly

**What I was trying to do:** Modify the input array in-place to simulate the "remove element" algorithm (two-pointer technique that overwrites elements in the original array).

**What the issue was:** Attempting to use `var.update $input.nums[$write] { value = $num }` fails with:
```
"$input" is a reserved variable name. Try a different name like "$my_input"
```

**Why it was an issue:** The classic "remove element" problem (LeetCode #27) specifically requires in-place modification. Since XanoScript doesn't allow modifying `$input` variables, I had to create a copy of the array first, which changes the space complexity from O(1) to O(n).

**Potential solution:**
- Document this limitation more prominently in the functions documentation
- Consider allowing modification of array elements within `$input` variables (just not reassignment of the variable itself)
- Provide a clear pattern for "in-place" array algorithms in XanoScript

---

## [2026-02-21 06:30 PST] - File validation vs code validation discrepancy

**What I was trying to do:** Validate my .xs files using the `file_paths` or `directory` parameter in the MCP.

**What the issue was:** The same code that validates successfully using the `code` parameter fails when read from a file with cryptic errors about finding single quotes.

**Why it was an issue:** This suggests there may be encoding or character escaping issues when the MCP reads files from disk vs receiving code as a string parameter. It took trial and error to discover that the `code` parameter worked while file validation didn't.

**Potential solution:**
- Investigate file reading/encoding in the MCP server
- Ensure consistent handling between code parameter and file-based validation
- Add debug output showing the exact bytes being parsed when validation fails

---

## [2026-02-21 06:32 PST] - Limited array indexing syntax documentation

**What I was trying to do:** Access and modify specific array elements by index.

**What the issue was:** The documentation shows array filters like `|first`, `|last`, `|count` but doesn't clearly document direct index access syntax like `$array[$index]` or the `var.update $array[$index]` pattern.

**Why it was an issue:** I had to guess/experiment to find the correct syntax for modifying array elements at specific positions, which is crucial for the two-pointer algorithm.

**Potential solution:**
- Add a section to the syntax or functions documentation specifically covering array indexing
- Include examples of reading (`$arr[$idx]`) and writing (`var.update $arr[$idx]`) array elements
- Document any limitations (e.g., can you append with `$arr[]`?)

---

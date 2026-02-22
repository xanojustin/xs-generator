# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 07:35 PST] - File-level comments not supported

**What I was trying to do:** Add descriptive comments at the top of the function file explaining the exercise

**What the issue was:** File-level comments using `//` before the function definition cause a parse error: "Expecting --> function <-- but found --> '\n'"

**Why it was an issue:** I had to remove all my file-level documentation comments. This makes the code less self-documenting.

**Potential solution (if known):** Either support file-level comments in XanoScript, or document clearly that comments can only exist inside `stack { }` blocks, not at the file level.

---

## [2026-02-22 07:38 PST] - While loops require 'each' blocks

**What I was trying to do:** Write a standard while loop to iterate through characters

**What the issue was:** The XanoScript parser requires `while` loops to have an `each { }` block inside them, which is non-obvious syntax:
```xs
while ($i < $n) {
  each {
    // loop body here
  }
}
```

**Why it was an issue:** This syntax was not clear from the documentation and is different from most programming languages. The error message "Expecting --> each <--" wasn't clear about what context it was expecting.

**Potential solution (if known):** 
1. Document this requirement clearly in the `quickstart` or `syntax` topics
2. Consider allowing bare `while` loops without the `each` block for simpler iteration patterns

---

## [2026-02-22 07:40 PST] - While loops cannot be inside conditional blocks

**What I was trying to do:** Conditionally execute a while loop based on some condition

**What the issue was:** `while` loops cannot be nested inside `conditional { }` blocks. The parser expects an `if` statement immediately after `conditional {`.

**Why it was an issue:** This forces restructuring of code logic. Common patterns like:
```xs
conditional {
  if (some_condition) {
    while (loop_condition) {
      each { ... }
    }
  }
}
```
...are not valid.

**Potential solution (if known):** Document this restriction clearly. The current syntax documentation doesn't mention this limitation.

---

## [2026-02-22 07:42 PST] - Missing filter functions (ord, delete)

**What I was trying to do:** Use `ord` filter to get ASCII codes for characters, and `delete` filter to remove keys from objects

**What the issue was:** Neither `ord` nor `delete` filters exist in XanoScript

**Why it was an issue:** I had to completely restructure my approach:
- Instead of using ASCII codes as frequency map keys, I used `split:""` to get character arrays and used characters directly as keys
- Instead of deleting keys from objects, I set their values to 0

**Potential solution (if known):**
1. Provide a comprehensive list of available filters in the documentation
2. Consider adding commonly used filters like `ord` for character manipulation
3. Consider adding `delete` or `remove` filter for object manipulation

---

## [2026-02-22 07:45 PST] - MCP validate_xanoscript tool JSON parameter passing confusion

**What I was trying to do:** Call the `validate_xanoscript` tool using mcporter

**What the issue was:** It took several attempts to get the JSON parameter format correct. The tool expects `--args '{"directory": "..."}'` format.

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" wasn't helpful when I was passing what I thought was valid JSON.

**Potential solution (if known):** The mcporter tool is working correctly, but better examples in the help text would be useful.

---

## [2026-02-22 07:46 PST] - Documentation topics returning same overview content

**What I was trying to do:** Get specific documentation on `syntax`, `functions`, `run`, and `quickstart` topics

**What the issue was:** All topic queries returned the same overview/README content instead of specific documentation for each topic

**Why it was an issue:** I couldn't get detailed syntax information that would have helped me avoid the errors above. I had to look at existing implementations to understand the correct patterns.

**Potential solution (if known):** 
1. Ensure each topic returns specific, relevant documentation
2. The cheatsheet/quick_reference mode might work better - consider making it the default

---

## [2026-02-22 07:48 PST] - No easy way to remove keys from objects

**What I was trying to do:** Remove a key from an object/map when its count reaches zero

**What the issue was:** No `delete` or `remove` filter exists for objects

**Why it was an issue:** Had to work around by setting values to 0 and checking for 0 in comparisons, which is less clean and potentially error-prone.

**Potential solution (if known):** Add a `delete:<key>` or `remove:<key>` filter for objects, or document the recommended workaround pattern.

---

## [2026-02-22 07:50 PST] - No character/ASCII manipulation filters

**What I was trying to do:** Convert characters to numeric codes for use as frequency map keys

**What the issue was:** No `ord` (get ASCII code) or `chr` (convert code to character) filters exist

**Why it was an issue:** Using characters directly as object keys works for some cases, but numeric codes would be more efficient for frequency counting and would work with fixed-size arrays.

**Potential solution (if known):** Consider adding character manipulation filters: `ord`, `chr`, `char_at`, etc.


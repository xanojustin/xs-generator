# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 12:35 PST] - File Paths Parameter Parsing Issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated values

**What the issue was:** The MCP tool parsed the comma-separated string as individual characters/paths. When I called:
```
mcporter call xano.validate_xanoscript file_paths=/Users/justinalbrecht/xs/fizzbuzz/run.xs,/Users/justinalbrecht/xs/fizzbuzz/function/fizzbuzz.xs
```

It treated each character after the comma as a separate file path, resulting in errors like:
- `File not found: U`
- `File not found: s`
- `File not found: e`
- etc.

**Why it was an issue:** Could not validate multiple specific files at once using the documented comma-separated format

**Workaround used:** Used the `directory` parameter instead, which worked perfectly:
```
mcporter call xano.validate_xanoscript directory=/Users/justinalbrecht/xs/fizzbuzz
```

**Potential solution:** The MCP server should properly parse comma-separated arrays in the `file_paths` parameter, or the documentation should clarify the expected format (perhaps JSON array string instead of comma-separated)

---

## [2026-02-19 12:35 PST] - Documentation Request: Array Manipulation

**What I was trying to do:** Append items to an array in a loop (building the FizzBuzz results)

**What the issue was:** Was unsure of the correct filter/function to append/merge arrays. The quick reference didn't clearly show array concatenation/appending patterns

**Why it was an issue:** Had to guess at the syntax - tried `$results|append:$item` and other variants before finding `merge:[]` works

**Potential solution:** Add a specific array manipulation section to the quick reference covering:
- Appending single items to arrays
- Concatenating two arrays
- Other common array operations (push, pop, etc.)

---

## [2026-02-19 12:35 PST] - Positive Feedback: Directory Validation

**What worked well:** The `directory` parameter for validation is excellent - it recursively finds all `.xs` files and validates them in one call

**Why it matters:** For larger projects, this is much more convenient than listing individual files

**Suggestion:** Consider making this the recommended approach in documentation

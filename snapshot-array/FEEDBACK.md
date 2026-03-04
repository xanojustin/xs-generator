# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-04 00:32 PST - Dynamic Object Key Syntax Confusion

**What I was trying to do:** Create an object with a dynamic key (converting an integer index to a string key for an object/dictionary)

**What the issue was:** I tried to use `$i|to_text: [...]` directly as an object key, which resulted in a syntax error: "Expecting --> : <-- but found --> '|'"

**Why it was an issue:** The documentation doesn't clearly show how to create objects with dynamic keys. I had to guess and iterate to find that I need to:
1. First convert the variable to text in a separate step
2. Then use `merge_recursive` to add the key-value pair to an empty object
3. Finally merge that into the parent object

**Potential solution (if known):** Better documentation or examples showing how to work with dynamic object keys. A filter like `|set_key:$key:$value` for objects would be helpful.

---

## 2025-03-04 00:30 PST - Array Element Updates Not Possible

**What I was trying to do:** Update a specific element in an array at a given index (e.g., `$array[$index] = $new_value`)

**What the issue was:** XanoScript doesn't have a way to update array elements in place. There's no `at:` parameter for the `merge` filter, and no other filter allows index-based updates.

**Why it was an issue:** Many algorithms require in-place array modifications. I had to completely restructure my solution to use objects instead of arrays, which is less intuitive for array-based problems.

**Potential solution (if known):** Add an `|update_at:index:value` filter for arrays, or document a recommended pattern for this common use case. The current workaround (using `slice` + `merge`) is verbose and inefficient.

---

## 2025-03-04 00:28 PST - Filter Arithmetic Needs Parentheses

**What I was trying to do:** Perform arithmetic on the result of a filter: `$history|count - 1`

**What the issue was:** Got error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The precedence rules aren't intuitive. I expected filter chaining to work naturally with arithmetic operators.

**Potential solution (if known):** The error message was actually quite helpful here - it told me exactly what to do (wrap in parentheses). No change needed, but documenting this pattern would help.

---

## 2025-03-04 00:25 PST - MCP Parameter Format Unclear

**What I was trying to do:** Call the validate_xanoscript tool with multiple file paths

**What the issue was:** The parameter `file_paths` expects an array format, but it's unclear what format the MCP tool expects when calling via mcporter CLI.

**Why it was an issue:** I tried `file_paths=~/xs/file1.xs,~/xs/file2.xs` and got "expected array, received string". The schema shows it's an array but not how to format it via CLI.

**Potential solution (if known):** Document the expected CLI format for array parameters. I eventually switched to using `directory` parameter instead.

---

## General Observations

1. **Documentation is good but scattered** - Having to call `xanoscript_docs` multiple times to get different topics works but is a bit tedious. A single "cheat sheet" would be helpful.

2. **Error messages are helpful** - The validation error messages were quite good, often suggesting exactly what to fix.

3. **No way to test execution** - The validate tool only checks syntax. There's no way to actually run the code locally to test logic (like the run job actually executing).
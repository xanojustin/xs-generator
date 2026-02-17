# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-17 15:18 PST - Documentation Discovery Challenge

**What I was trying to do:**
Find the XanoScript syntax documentation to write a run job correctly.

**What the issue was:**
I had to manually call `xanoscript_docs` multiple times with different topics to gather the full picture. The initial documentation didn't include specific run job patterns, so I had to make separate calls for:
- General overview
- Run job specific syntax
- Quickstart patterns
- External API patterns

**Why it was an issue:**
It took multiple round trips to get all the information needed. A single comprehensive topic or a "run job example" template would have been more efficient.

**Potential solution:**
Add a topic like "run-job-example" or "run-complete-example" that includes a full working example with all supporting files (run.xs, function/*.xs, etc.) in one call.

---

## 2025-02-17 15:20 PST - JSON Property Syntax Confusion

**What I was trying to do:**
Create an object with a dynamic key name (`$insert_id`) in the Mixpanel event properties.

**What the issue was:**
I initially wasn't sure if XanoScript supports dynamic key names in object literals. The syntax `$insert_id:` looked unusual.

**Why it was an issue:**
The documentation examples mostly show static key names. I had to infer that XanoScript might support the `$` prefix for special keys, but wasn't 100% certain without testing.

**Potential solution:**
Add explicit documentation about dynamic/special keys in object literals, showing examples with `$` prefixed keys or computed property names.

---

## 2025-02-17 15:22 PST - Filter Chaining Uncertainty

**What I was trying to do:**
Chain filters together like `now|to_int` and `($input.distinct_id ~ "_" ~ now|to_text)|md5`.

**What the issue was:**
The documentation mentions filter chaining but doesn't provide complex examples with string concatenation mixed with filters.

**Why it was an issue:**
I had to guess the correct parenthesis placement for `(now|to_text)` inside the string concatenation expression. Without running validation, I wouldn't know if it's correct.

**Potential solution:**
Add more complex real-world examples showing filters combined with string operations and nested expressions.

---

## 2025-02-17 15:24 PST - Validation Tool Worked Well

**What I was trying to do:**
Validate the XanoScript files after writing them.

**What worked well:**
The `validate_xanoscript` tool with `file_paths` array worked perfectly on the first try. It validated both files and reported them as valid.

**Why this was good:**
The batch validation saved time, and the clear output (2 valid, 0 invalid) gave immediate confidence that the syntax was correct.

**Suggestion:**
No improvement needed here - this tool worked as expected!

---

## Summary

Overall, the MCP worked well for validation, but the documentation required multiple calls to piece together a complete understanding. A single "run job complete example" topic would significantly improve the developer experience.

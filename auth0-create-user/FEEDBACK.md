# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 05:47 PST] - JSON Type Default Value Syntax Issue

**What I was trying to do:**
Create an optional json input parameter with an empty object as the default value, like:
```xs
json? user_metadata?={} {
  description = "Optional custom metadata"
}
```

**What the issue was:**
The validator rejected the `{}` default value syntax for json types:
```
[Line 16, Column 26] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [floating point number]
  3. [integer]
  4. [true]
  5. [false]
  6. [now]
  7. [Identifier]
but found: '{'
```

**Why it was an issue:**
I assumed JSON types would accept JSON literals as default values, similar to how text types accept string literals. The error message doesn't indicate what the correct syntax would be for JSON defaults (if any).

**Potential solution (if known):**
- The documentation should clarify what default values are valid for JSON types
- If JSON literals aren't supported as defaults, suggest using `null` or omitting the default
- Consider supporting empty object `{}` and empty array `[]` as valid defaults for JSON types

---

## [2025-02-18 05:48 PST] - Documentation Discovery Good Experience

**What I was trying to do:**
Learn XanoScript syntax since my training data doesn't include it.

**What the experience was:**
The `xanoscript_docs` tool worked well. I was able to query specific topics like `run`, `functions`, `quickstart`, and `integrations/external-apis` to get the information I needed.

**Why it was helpful:**
- The quick_reference mode provided concise, usable information
- The file_path parameter with applyTo pattern matching is a good design
- Examples in the docs were directly applicable

**Potential improvement:**
- Consider adding a searchable index or allowing keyword searches across topics
- Add more examples for edge cases (like the JSON default issue above)

---

## [2025-02-18 05:49 PST] - Validation Tool Worked Well

**What I was trying to do:**
Validate my .xs files before committing.

**What the experience was:**
The `validate_xanoscript` tool with `file_paths` array worked perfectly for batch validation. The error messages included line and column numbers which made fixing issues easy.

**Why it was helpful:**
- Batch validation saved time
- Precise error locations (line/column)
- Clear indication of which files passed/failed

---

## Summary

Overall the MCP worked well for this task. The main friction point was the JSON default value syntax, which required trial and error to resolve. Better documentation of valid default values per type would help.

The workflow of:
1. Query docs with xanoscript_docs
2. Write code
3. Validate with validate_xanoscript
4. Iterate

...is solid and the validation catches errors early.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 03:17 PST] - Object Type Not Valid

**What I was trying to do:**
Create a function input parameter that accepts an object/dictionary of event data to send to New Relic.

**What the issue was:**
I used `object event_data` as the input type, but the validator rejected it with the error:
```
[Line 7, Column 22] Expecting --> { <-- but found --> ' '
```

The suggestion said "Use 'json' instead of 'object'".

**Why it was an issue:**
This was confusing because many programming languages use `object` or `Object` as a type for arbitrary key-value data. The XanoScript documentation I retrieved didn't clearly show what types are available for function inputs.

**Potential solution (if known):**
- Add a clear type reference in the quick_reference docs showing valid types for function inputs
- Consider supporting `object` as an alias for `json` since it's more intuitive
- The cheatsheet could show a complete list of valid input types

---

## [2026-02-18 03:15 PST] - Limited Type Information in Quick Reference

**What I was trying to do:**
Understand what data types are valid for function input parameters.

**What the issue was:**
The quick_reference docs for functions showed the structure but didn't list valid types. I had to guess based on table schema types. I tried `object` which was wrong.

**Why it was an issue:**
Without knowing valid types, I had to make assumptions that led to validation errors.

**Potential solution (if known):**
- Include a type reference table in the functions quick_reference documentation
- List all valid types: `text`, `int`, `decimal`, `bool`, `timestamp`, `date`, `json`, etc.
- Show which types can be used in function inputs vs table schemas

---

## [2026-02-18 03:15 PST] - String Concatenation with Filters Confusion

**What I was trying to do:**
Build URL strings and error messages using string concatenation with type conversions.

**What the issue was:**
The documentation mentions that when using filters with concatenation, you need parentheses:
```xs
// Correct
($nr_result.response.status|to_text) ~ ": "

// Incorrect
$nr_result.response.status|to_text ~ ": "
```

**Why it was an issue:**
This is a subtle syntax requirement that's easy to forget. The error messages when you get it wrong might not be clear.

**Potential solution (if known):**
- The linter/validator could provide a more specific error when concatenating filtered expressions without parentheses
- Consider allowing the simpler syntax and handling it automatically

---

## [2026-02-18 03:15 PST] - MCP Tool Discovery Was Good

**What I was trying to do:**
Find the documentation tool to learn XanoScript syntax.

**What the issue was:**
No issues here - the `mcporter list xano --schema` worked well and showed all available tools clearly.

**Why it was a positive experience:**
The tool discovery and documentation retrieval worked smoothly. Having the `xanoscript_docs` tool with topic-based retrieval is helpful.

**Potential improvement:**
- Could benefit from a "search" function in the docs to find specific syntax patterns
- An interactive mode might help explore documentation

---

## [2026-02-18 03:18 PST] - Validation Tool Works Well

**What I was trying to do:**
Validate my XanoScript files before committing.

**What the issue was:**
No major issues. The validation tool provided:
- Clear file-by-file results
- Line and column numbers for errors
- Helpful suggestions (like using `json` instead of `object`)
- Batch validation of entire directories

**Why it was helpful:**
The error messages were actionable and the directory validation saved time.

**Potential improvement:**
- Auto-fix suggestions for common issues
- A "fix" mode that automatically corrects simple errors
- Integration with IDE/editor for real-time validation

---

## Summary

Overall the development experience was smooth. The main friction point was not knowing valid input types for functions. Once I understood that `json` was the correct type instead of `object`, everything worked well. The MCP tools are well-designed and the validation is helpful.

**Key suggestion:** Improve type documentation in the quick_reference to prevent guessing.

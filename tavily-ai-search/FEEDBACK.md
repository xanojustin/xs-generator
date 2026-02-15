# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 17:50 PST] - Boolean Type Name

**What I was trying to do:**
Declare optional boolean input parameters in the function input block.

**What the issue was:**
I used `boolean` as the type name, but XanoScript uses `bool` instead.

```xs
// Wrong
boolean include_answer?=false

// Correct
bool include_answer?=false
```

**Why it was an issue:**
The validation error message was "Expecting --> } <-- but found --> 'boolean'" which was confusing - it made me think there was a syntax error with braces rather than an incorrect type name.

**Potential solution (if known):**
The error message could be improved to say something like "Unknown type 'boolean'. Did you mean 'bool'?" similar to how other languages suggest corrections.

---

## [2026-02-14 17:52 PST] - Optional Field Access Syntax in Response Objects

**What I was trying to do:**
Use the `?` optional field access operator in the response object to safely access potentially null fields from the API response.

**What the issue was:**
```xs
// This caused a validation error:
response = {
  answer: $search_results.answer?
}
```

The error was: "Expecting: one of these possible Token sequences... but found: '
'" - essentially it didn't recognize the `?` operator in this context.

**Why it was an issue:**
I expected the `?` operator to work in response objects similar to how it works in expressions. The documentation mentions `$obj.field?` for optional access, but it seems this doesn't work in object literals for the response block.

**Potential solution (if known):**
Either:
1. Support the `?` operator in response object literals
2. Document that optional access isn't supported in response blocks and recommend using `conditional` blocks or `var` declarations to handle potentially null fields

**Workaround:**
I removed the `?` operators and accessed fields directly:
```xs
response = {
  answer: $search_results.answer,
  ...
}
```

---

## [2026-02-14 17:48 PST] - Documentation Clarity on Type Names

**What I was trying to do:**
Find the correct type names for input parameters.

**What the issue was:**
The quick_reference for types lists "bool" but I initially skimmed over it. The table format makes it easy to miss the exact naming.

**Why it was an issue:**
Common programming languages use various names for booleans (`boolean`, `bool`, `Boolean`) so it's easy to guess wrong.

**Potential solution (if known):**
Add a "Common Mistakes" section to the types documentation explicitly listing: "Use `bool` not `boolean`" since this is likely a frequent error.

---

## [2026-02-14 17:55 PST] - Missing Comma in Object Literals Error

**What I was trying to do:**
Create a response object with multiple fields.

**What the issue was:**
Initially I wrote the response object without commas between fields (similar to the input block syntax):
```xs
response = {
  query: $input.query
  search_depth: $input.search_depth
}
```

The input block doesn't use commas, but object literals in the response block do require them.

**Why it was an issue:**
Inconsistent syntax between different contexts makes it harder to remember the correct format.

**Potential solution (if known):**
Document the difference explicitly: "Input blocks don't use commas between fields, but object literals in response blocks do require commas."

---

## General Notes

- The MCP tools worked well overall
- Validation errors could be more specific about what went wrong
- Having the quick_reference mode for documentation is helpful for context efficiency
- The `xanoscript_docs` tool with `file_path` parameter is useful for context-aware documentation

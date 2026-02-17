# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-16 20:22 PST - Issue: Array Default Value Syntax Confusion

**What I was trying to do:**
Create an optional array input parameter with an empty array as the default value.

**What the issue was:**
I wrote `text[] card_labels?=[]` thinking that `[]` would be a valid default value for an empty array. The validator returned:
```
[Line 9, Column 25] Expecting: one of these possible Token sequences:
  1. ["..."]
  2. [floating point number]
  3. [integer]
  4. [true]
  5. [false]
  6. [now]
  7. [Identifier]
but found: '['
```

**Why it was an issue:**
The error message wasn't clear about what the correct syntax should be for array default values. It seemed to suggest I was using the wrong type name ("Use 'text' instead of 'string'"), but that wasn't the actual problem - the issue was that empty array literals `[]` aren't valid default values in XanoScript input blocks.

**Potential solution (if known):**
The documentation for input blocks should clarify:
1. What types can have default values
2. What literal values are valid for defaults (seems like only primitives: strings, numbers, booleans, `now`)
3. How to handle optional arrays (answer: just make them optional without default, or use a separate flag to indicate "has value")

---

## 2026-02-16 20:25 PST - Issue: Filter Expression Parentheses Requirement

**What I was trying to do:**
Check if an array has elements using `$input.card_labels|count > 0`.

**What the issue was:**
The validator returned:
```
[Line 54, Column 38] An expression should be wrapped in parentheses when combining filters and tests
```

The code was: `if ($input.card_labels|count > 0) {`

**Why it was an issue:**
While the error message correctly identified the issue, it wasn't immediately obvious HOW to wrap it. I had to guess whether it should be:
- `($input.card_labels|count > 0)` 
- `(($input.card_labels|count) > 0)`
- `($input.card_labels|count) > 0`

The correct answer was `(($input.card_labels|count) > 0)` - the filter expression needs its own parentheses, then the comparison needs to be outside.

**Potential solution (if known):**
The error message could include an example of the correct syntax, e.g.:
"Wrap the filter expression in parentheses: `(($input.array|count) > 0)`"

---

## 2026-02-16 20:15 PST - Issue: Xano MCP Tool Not in PATH

**What I was trying to do:**
Call `xanoscript_docs` directly as a command.

**What the issue was:**
I initially tried to run `xanoscript_docs` as a standalone command, but it's only available through the MCP server via `mcporter call`.

**Why it was an issue:**
The instructions said "You MUST call `xanoscript_docs` on the xano MCP before writing ANY code" which could be interpreted as running it as a CLI command. I had to figure out that I needed to use `mcporter call xano.xanoscript_docs` instead.

**Potential solution (if known):**
The instructions could be clearer that `xanoscript_docs` is an MCP tool, not a CLI command. Something like: "Call the `xanoscript_docs` MCP tool via mcporter before writing ANY code."

---

## General Observations

### Positive:
- The validation tool is excellent - it catches syntax errors with clear line/column positions
- The quick_reference mode for docs is efficient and well-organized
- The MCP server was already configured and working

### Suggestions for Improvement:
1. **More examples in error messages**: When an error is detected, show a "Did you mean:" suggestion with corrected code
2. **Input block array documentation**: Clarify how to define optional arrays with or without defaults
3. **Expression wrapping rules**: Add a section to the syntax docs about when and how to use parentheses with filters

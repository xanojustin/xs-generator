# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 04:06 PST] - Issue 1: Object vs JSON type confusion

**What I was trying to do:** Define an input parameter to accept an object/dictionary for storing player scores.

**What the issue was:** I used `object initial_scores` as the type name, but the validator suggested using `json` instead. The error message was helpful but the type naming is confusing - XanoScript uses `json` for arbitrary object/dictionary data rather than `object`.

**Why it was an issue:** Coming from TypeScript/JavaScript, `object` is the natural choice for dictionary-like data. The error message suggested `json` but this wasn't obvious from the documentation examples I had access to.

**Potential solution:** The documentation could be clearer about type names. The table in the docs lists `json` as "Arbitrary JSON data" but doesn't explicitly mention it's the type to use for objects/dictionaries.

---

## [2025-03-03 04:08 PST] - Issue 2: Array length filter naming

**What I was trying to do:** Get the length/count of an array to determine how many top scores to sum.

**What the issue was:** I used `|length` as the filter (common in many languages), but XanoScript uses `|count` instead.

**Why it was an issue:** The error "Unknown filter function 'length'" was clear, but I had to grep through existing exercises to find the correct filter name. The documentation I accessed didn't list available filters.

**Potential solution:** 
1. Include a comprehensive filter reference in the documentation
2. Consider aliasing `length` to `count` for common use cases (strings use `strlen`, arrays use `count` - this is inconsistent)
3. The error message could suggest `count` as an alternative

---

## [2025-03-03 04:09 PST] - Issue 3: Expression complexity with filters

**What I was trying to do:** Use a ternary expression with filters: `($sorted_scores|count < $input.k) ? $sorted_scores|count : $input.k`

**What the issue was:** Got error "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** Even though I had parentheses around the whole condition, using the filter twice in one expression caused issues. I had to pre-compute the count into a separate variable.

**Potential solution:** The parser could be more lenient with filter usage in expressions, or the error message could provide an example of the correct syntax.

---

## [2025-03-03 04:10 PST] - Issue 4: MCP validate_xanoscript parameter passing

**What I was trying to do:** Call the validate_xanoscript tool through mcporter.

**What the issue was:** Initially had trouble passing parameters correctly. The tool requires `--args` for JSON payload, which wasn't immediately obvious from the help text.

**Why it was an issue:** The command syntax `mcporter call xano validate_xanoscript '{"file_path": "..."}'` didn't work - it required `mcporter call xano validate_xanoscript --args '{"file_path": "..."}'`.

**Potential solution:** The mcporter help or the Xano MCP documentation could include example invocations for each tool.

---

## Summary

Overall the validation process was helpful and caught real issues. The main friction points were:
1. Type naming conventions (`json` vs `object`)
2. Filter discovery and naming consistency
3. Expression parsing limitations

The error messages were generally helpful and included line numbers, which made fixing issues straightforward.

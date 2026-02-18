# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-17 17:50 PST - Object Type Requires Schema

**What I was trying to do:**
Define an input parameter for unstructured JSON data (model input parameters that vary by model type).

**What the issue was:**
Used `object input_data { description = "..." }` which caused a parse error. The error message suggested using "json" instead.

**Why it was an issue:**
The error message was helpful but didn't explain WHY `object` failed. I later learned `object` requires a schema definition for its structure, which isn't suitable for dynamic/variable JSON data.

**Potential solution:**
Better error message could be: "`object` type requires a schema definition. For unstructured/dynamic JSON data, use `json` type instead."

---

## 2026-02-17 17:52 PST - Response Cannot Be Used Inside Conditional

**What I was trying to do:**
Use `response = {...}` inside a conditional block to return early if `wait_for_completion` was false.

**What the issue was:**
Got parse error "Expecting --> } <-- but found --> 'response'". The `response` keyword can only be used at the end of the function, not inside conditionals.

**Why it was an issue:**
This is very different from most programming languages where early returns are common. I had to restructure to use a variable that gets set conditionally and returned at the end.

**Potential solution:**
Document this limitation clearly in the functions documentation. Could also suggest using `var` to store result and return at end. Or consider supporting early return syntax.

---

## 2026-02-17 17:55 PST - Sleep Function Name and Syntax

**What I was trying to do:**
Add a sleep/delay between polling attempts for the Replicate API.

**What the issue was:**
Tried `sleep { duration = 5 }` which failed. Had to search through documentation to find it's `util.sleep { value = 5 }`.

**Why it was an issue:**
The `sleep` function isn't prominently documented in the quick reference or syntax sections. Had to dig into the utilities integration docs to find it.

**Potential solution:**
Add `util.sleep` to the quick reference / cheatsheet documentation. Common utility functions like sleep should be easily discoverable.

---

## 2026-02-17 17:48 PST - While Loop Variable Scoping

**What I was trying to do:**
Update variables inside a while loop (polling for status changes).

**What the issue was:**
Variables declared inside `each` blocks don't persist to the next iteration. Had to declare variables outside the while loop and use `var.update` inside.

**Why it was an issue:**
This scoping behavior wasn't immediately obvious. The pattern for mutable variables in loops isn't clearly documented.

**Potential solution:**
Add a specific example for polling patterns or status checking loops to the documentation. Show the pattern of declaring outside + var.update inside.

---

## 2026-02-17 17:45 PST - JSON vs Object Type Confusion

**What I was trying to do:**
Understand when to use `json` vs `object` types in input blocks.

**What the issue was:**
The types documentation doesn't clearly explain the distinction. Had to infer from error messages that `json` = unstructured/dynamic, `object` = structured with schema.

**Why it was an issue:**
For API integrations, most inputs are dynamic JSON from external sources. The default assumption might lead developers to use `object` incorrectly.

**Potential solution:**
Add a comparison table in the types documentation:
| Use `json` when... | Use `object` when... |
|---|---|
| Data structure is dynamic/unknown | Data has fixed schema |
| Accepting external API responses | Defining internal data structures |
| Schema varies by use case | Need validation of specific fields |

---

## General Feedback

### Strengths
- The validation tool is excellent - gives precise line/column errors
- Error messages often include helpful suggestions
- Documentation is comprehensive once you find the right section

### Areas for Improvement
1. **Quick reference completeness**: Common patterns like polling, sleep delays, and json vs object should be in the quickstart/cheatsheet
2. **Early return pattern**: Document the pattern for conditional returns (use variable + final response)
3. **More API integration examples**: Most examples are database-centric. More external API patterns would help.
4. **Loop variable scoping**: Explicitly document that `var` inside `each` is local and `var.update` is needed for persistence

### MCP Tool Feedback
- The `validate_xanoscript` tool works great
- Would be helpful to have a `format_xanoscript` tool for auto-formatting
- An `init_xanoscript` tool to scaffold new run jobs/functions would speed up development

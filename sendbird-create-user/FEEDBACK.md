# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 19:47 PST] - Initial Validation Parameter Confusion

**What I was trying to do:**
Validate the XanoScript files after creating them. I wanted to pass multiple file paths for batch validation.

**What the issue was:**
I initially tried using `files` as the parameter name (which is common in many APIs), but the tool expects `file_paths` (with underscore). The error message was clear but I had to check the schema to find the correct parameter name.

**Why it was an issue:**
Had to make an extra MCP call to list the schema and find the correct parameter name. Would have been faster if I knew the exact parameter name upfront.

**Potential solution (if known):**
Include a brief example in the xanoscript_docs output showing a sample validate_xanoscript call with the correct parameters.

---

## [2026-02-17 19:48 PST] - Documentation Access Pattern

**What I was trying to do:**
Get the XanoScript documentation to understand syntax for writing the run job.

**What the issue was:**
I called `xanoscript_docs` with no parameters and got the overview, but then I needed to make separate calls for `quickstart` and `run` topics. This required multiple round trips.

**Why it was an issue:**
Each call takes time. Having to make 3 separate calls to get the complete picture for run job development could be streamlined.

**Potential solution (if known):**
Consider adding a `topic=run-job-guide` that combines the relevant quickstart + run + syntax documentation specifically for run job creation. Or document common multi-topic workflows in the initial README.

---

## [2026-02-17 19:50 PST] - Boolean Operator Syntax

**What I was trying to do:**
Write preconditions checking that both API token and app ID environment variables are set.

**What the issue was:**
Initially wrote `&&` (JavaScript style) but XanoScript uses `and` for logical AND. The validation caught it but the error was slightly cryptic.

**Why it was an issue:**
Many developers coming from JavaScript/TypeScript expect `&&` and `||`. The syntax is different and easy to forget.

**Potential solution (if known):**
Add a "Coming from JavaScript?" section in the quickstart docs that explicitly maps common operators: `&&` → `and`, `||` → `or`, `!` → `not`, `===` → `==`.

---

## [2026-02-17 19:52 PST] - Run Job File Naming

**What I was trying to do:**
Figure out what to name the run job file.

**What the issue was:**
The run job documentation shows `run.xs` as the filename in the examples, but it wasn't immediately clear if that's a convention or requirement. I had to look at existing implementations to confirm.

**Why it was an issue:**
Minor confusion about whether to use `run.job`, `run.xs`, or something else. Looking at existing code worked but required exploration.

**Potential solution (if known):**
Make it explicit in the run topic documentation that the file MUST be named `run.xs` (or whatever the actual requirement is).

---

## [2026-02-17 19:55 PST] - Filter Expression Parentheses

**What I was trying to do:**
Concatenate strings with filters in the expression.

**What the issue was:**
Tried to write `"Status: " ~ $status|to_text` without parentheses around the filter expression. This causes a parse error.

**Why it was an issue:**
The error message didn't clearly indicate that parentheses were needed around the filter. I remembered from the docs but it's an easy mistake.

**Potential solution (if known):**
The quickstart docs already mention this, but it's worth emphasizing with a big "⚠️ Common Mistake" callout. The error message could also be more helpful - suggest adding parentheses if a filter is detected in a concatenation expression.

---

## Summary

Overall the MCP worked well! The main friction points were:

1. **Multiple doc calls needed** - Could benefit from consolidated "guide" topics
2. **Operator syntax differences** from JS - Would help to have a "JS to XanoScript" mapping
3. **Filter parentheses** - Easy to forget, needs stronger warnings

The validation tool is excellent - caught my issues immediately and gave clear file locations. The documentation is comprehensive once you find the right topics.

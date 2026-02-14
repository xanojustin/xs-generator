# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-14 05:20 PST - Initial Setup and Documentation Access

**What I was trying to do:**
Set up a new XanoScript run job for the Razorpay API. This required understanding the XanoScript syntax and run job structure.

**What the issue was:**
No immediate issues! The `xanoscript_docs` tool worked well and provided comprehensive documentation. The quick_reference mode was particularly helpful for getting syntax patterns without overwhelming context.

**Why it was an issue:**
N/A - Documentation was accessible and well-structured.

**Potential solution (if known):**
The documentation structure is good. It would be helpful to have more examples of real-world API integrations in the docs.

---

## 2025-02-14 05:22 PST - Variable Declaration Syntax

**What I was trying to do:**
Create variables to store the Razorpay API response parsing results.

**What the issue was:**
I initially tried to use `var $success = false` syntax based on intuition from other languages, but the XanoScript syntax requires curly braces with a `value` key: `var $success { value = false }`.

**Why it was an issue:**
This syntax is unique to XanoScript and differs from most common programming languages. Without the quick_reference docs, this would have been a trial-and-error process.

**Potential solution (if known):**
Consider adding a "XanoScript vs JavaScript/Python" comparison cheat sheet to help developers coming from other languages understand the syntax differences quickly.

---

## 2025-02-14 05:23 PST - String Concatenation with Filters

**What I was trying to do:**
Build the Authorization header by concatenating "Basic " with the base64-encoded credentials.

**What the issue was:**
I initially wrote `"Authorization: Basic " ~ $auth_token` but the documentation revealed that when using filters (like `base64_encode`), the filtered expressions need parentheses: `($auth_string|base64_encode)`. This was clearly documented but easy to miss.

**Why it was an issue:**
The syntax requirement for parentheses around filtered expressions in concatenations is subtle and differs from typical filter pipelines.

**Potential solution (if known):**
Add a linting rule or better error message when filters are used in concatenations without parentheses. The current error might be cryptic for users unfamiliar with this requirement.

---

## 2025-02-14 05:24 PST - JSON Data Type for Input

**What I was trying to do:**
Define an input parameter that accepts a JSON object (the `notes` field for Razorpay orders).

**What the issue was:**
I wasn't sure if the type should be `json`, `object`, or something else for accepting arbitrary key-value pairs. The quick_reference showed `json` as a type option which worked correctly.

**Why it was an issue:**
Minor uncertainty about type naming conventions. The docs were clear once I checked the types section.

**Potential solution (if known):**
N/A - Documentation covered this well.

---

## 2025-02-14 05:25 PST - Conditional Block Syntax

**What I was trying to do:**
Add optional fields to the payload only if they are provided in the input.

**What the issue was:**
The `conditional` block syntax with `if`, `elseif`, and `else` is straightforward, but I initially wondered if inline conditionals were supported (like ternary operators). The docs clearly show the block-based approach is the standard way.

**Why it was an issue:**
Not a blocking issue, but having inline conditional expressions could make some code more concise.

**Potential solution (if known):**
If inline conditionals aren't supported, consider adding them as a feature request. They would be useful for simple value assignments like: `var $currency { value = $input.currency ?? "INR" }`

---

## 2025-02-14 05:26 PST - Validation Success

**What I was trying to do:**
Validate the XanoScript files using the MCP's `validate_xanoscript` tool.

**What the issue was:**
No issues! The validation tool worked perfectly and confirmed both files are syntactically correct. The tool provided clear confirmation messages.

**Why it was an issue:**
N/A - Tool worked as expected.

**Potential solution (if known):**
The validation tool could potentially offer suggestions or warnings (not just errors) for common patterns. For example, warning if a variable is declared but never used.

---

## 2025-02-14 05:27 PST - Environment Variable Access Pattern

**What I was trying to do:**
Access environment variables for API credentials within the function.

**What the issue was:**
The documentation clearly states that `$env` cannot be used in `run.job` or `run.service` input blocks (input values must be constants), but CAN be used inside the stack. This was well documented and I followed the pattern correctly.

**Why it was an issue:**
N/A - Documentation was clear about this limitation and the workaround.

**Potential solution (if known):**
Consider if future versions could support lazy evaluation of environment variables in input blocks, or add a specific error message when users try to use `$env` in input blocks.

---

## Summary

Overall, the development experience was smooth:

1. **Documentation**: The `xanoscript_docs` tool provided comprehensive and well-organized documentation. The `quick_reference` mode was particularly valuable for staying within context limits while getting essential syntax information.

2. **Validation**: The `validate_xanoscript` tool worked reliably and caught no errors in the final code.

3. **Syntax Clarity**: XanoScript has some unique syntax patterns (variable declaration, filter parentheses in concatenation) that differ from mainstream languages, but these are well documented.

4. **Feature Wishes**:
   - Inline conditional expressions (ternary-style)
   - Better linting warnings for unused variables
   - More real-world API integration examples in docs

5. **Time to Working Code**: Approximately 10 minutes from documentation lookup to validated code - very efficient!

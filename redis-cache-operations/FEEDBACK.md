# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 06:47 PST] - Multiple Functions Per File Not Allowed

**What I was trying to do:**
Create a helper function (`run_demo`) within the same file as the main function (`cache_operations`) to keep related code together.

**What the issue was:**
The validator reported: "Redundant input, expecting EOF but found: function" when I tried to define a second function in the same file. This suggests XanoScript only allows one function definition per .xs file.

**Why it was an issue:**
This wasn't clear from the documentation. The "Complete Job Example" in the run docs shows separate files for functions, but doesn't explicitly state that multiple functions per file are prohibited. I had to discover this through trial and error.

**Potential solution (if known):**
- Update the documentation to explicitly state "one function per file"
- Consider supporting multiple functions per file for better code organization
- Or provide a clearer error message like "Only one function allowed per .xs file"

---

## [2025-02-17 06:46 PST] - Input Filters Syntax Issue

**What I was trying to do:**
Apply filters to an input parameter to normalize the operation string (convert to lowercase and trim).

**What the issue was:**
I initially wrote:
```xs
text operation {
  description = "Operation to perform"
  filters = ["trim", "to_lower"]
}
```

The validator reported: "The argument 'filters' is not valid in this context"

**Why it was an issue:**
The syntax documentation shows filters can be used in expressions like `$var|filter`, but there's no clear documentation about applying filters to input parameters during declaration. I had to work around this by creating a separate variable with the filters applied.

**Potential solution (if known):**
- Clarify in the documentation whether input parameters support inline filters
- If not supported, explicitly document that filters must be applied in the stack using `var` declarations

---

## [2025-02-17 06:46 PST] - Else If Syntax Confusion

**What I was trying to do:**
Write conditional logic with multiple branches using `else if`.

**What the issue was:**
I wrote `else if` (two words) which is common in many languages (JavaScript, Python, etc.), but XanoScript requires `elseif` (one word).

**Why it was an issue:**
The error message was helpful and suggested "Use 'elseif' (one word) instead of 'else if'", which was great! However, this could be clearer in the syntax documentation's quick reference.

**Potential solution (if known):**
- Add `elseif` to the syntax quick reference table
- The error message is already good, just need to document it

---

## [2025-02-17 06:45 PST] - Limited Documentation on File Organization

**What I was trying to do:**
Understand the proper structure for a run job with multiple supporting functions.

**What the issue was:**
The documentation shows directory structures but doesn't explicitly describe the relationship between files. For example:
- Can function A call function B if they're in the same folder?
- Do function names need to match file names?
- What's the search/loading order for functions?

**Why it was an issue:**
I had to guess that `function.run "run_demo"` would work if I put the function in a separate file named `run_demo.xs` in the `function/` folder.

**Potential solution (if known):**
- Document the function resolution/loading mechanism
- Clarify if file names must match function names
- Explain how functions reference each other across files

---

## General Observations

**What worked well:**
1. The MCP validation tool is excellent - clear error messages with line/column numbers
2. The quick reference docs provide good syntax examples
3. The Redis integration docs were helpful for understanding available operations

**What could be improved:**
1. More explicit documentation about file organization rules
2. A complete example showing multiple files working together
3. A troubleshooting/common errors section in the docs


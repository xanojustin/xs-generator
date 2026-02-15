# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 19:17 PST] - Filters Attribute Not Valid in Function Input

**What I was trying to do:**
Create a function with input parameters that have filters applied (like lowercase conversion).

**What the issue was:**
I initially wrote the input block with `filters="lowercase"` on text inputs:
```xs
input {
  text language { description = "Language code", filters="lowercase" }
  text model { description = "Deepgram model", filters="lowercase" }
}
```

The validator returned:
```
1. [Line 5, Column 71] The argument 'filters' is not valid in this context
2. [Line 5, Column 71] Expected value of `filters` to be `null`
```

**Why it was an issue:**
I was trying to normalize input values (convert to lowercase) at the input definition level, which seems like a reasonable thing to want. The documentation mentions filters like `lowercase`, `trim`, etc. in the syntax quick reference, so I assumed they could be used in input definitions.

**Potential solution (if known):**
- The documentation could clarify where filters are/aren't allowed
- Consider supporting filters on inputs as a convenience feature
- If filters aren't meant for inputs, explicitly state this in the functions documentation

---

## [2026-02-14 19:18 PST] - Lack of Clear Documentation on Input Validation/Transformation

**What I was trying to do:**
Apply transformations (lowercase) to input parameters before using them in the function logic.

**What the issue was:**
The syntax quick reference shows filters like `to_lower`, `trim`, etc. but doesn't clearly indicate:
1. Where these can be used
2. How to apply them to input variables
3. Whether input validation/transformations happen at the input level or in the stack

**Why it was an issue:**
I had to guess where filters could be applied. I tried using them in the input block (wrong), then realized I'd need to create var statements in the stack if I wanted transformed values.

**Potential solution (if known):**
- Add an "Input Processing" section to the functions documentation
- Show examples of input transformation patterns in the stack
- Clarify the scope/context where different features are available

---

## [2026-02-14 19:15 PST] - Initial MCP Connection/Documentation Retrieval Was Smooth

**What I was trying to do:**
Get XanoScript documentation before writing code, as instructed.

**What the issue was:**
No issues! The `xanoscript_docs` tool worked well and returned comprehensive documentation. The topic-based organization made it easy to find what I needed.

**Why it was NOT an issue:**
The documentation system works as intended. Having both `full` and `quick_reference` modes is helpful for different use cases.

**Potential improvements:**
- Consider adding a search or fuzzy match capability for topics
- An examples topic with common patterns would be useful

---

## [2026-02-14 19:19 PST] - Validation Tool Works Well

**What I was trying to do:**
Validate .xs files after writing them.

**What the issue was:**
No major issues. The validation tool provided clear error messages with line/column positions.

**Why it was NOT an issue:**
The error messages were specific enough to identify and fix the problem quickly.

**Potential improvements:**
- Suggest fixes in the error messages (e.g., "Did you mean to use filters in a var statement instead?")
- Allow batch validation of entire directories

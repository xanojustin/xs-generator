# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-20 08:05 PST - Error Handling Syntax Confusion

**What I was trying to do:** Add input validation to check if `k` is within valid bounds before processing

**What the issue was:** I initially tried to use an `error { message = ... }` block inside a conditional, which resulted in:
```
[Line 17, Column 9] Expecting --> } <-- but found --> 'error' <--
```

**Why it was an issue:** The documentation shows `precondition` for validation but doesn't clearly explain that you cannot use `error { }` blocks inside conditional statements. I had to guess that `precondition` was the right approach based on an earlier doc snippet.

**Potential solution (if known):** 
- Add clear examples showing the difference between `precondition` (for pre-flight checks) and error handling inside the stack
- Document what the `error { }` block syntax actually is and where it can be used
- Show examples of input validation patterns

---

## 2025-02-20 08:02 PST - MCP Parameter Format Discovery

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths

**What the issue was:** The tool accepts `directory` parameter but I initially tried using `file_paths` which didn't work. Then I tried `--directory` flag syntax which was interpreted as code to validate.

**Why it was an issue:** The mcporter CLI syntax for passing named parameters wasn't immediately obvious. The error messages were confusing because it kept saying parameters were missing or interpreting flags as code.

**Potential solution (if known):**
- The `mcporter call` syntax uses `param=value` format without dashes
- Consider adding examples directly in the tool description showing the exact CLI syntax

---

## 2025-02-20 08:00 PST - Documentation Index Overlap

**What I was trying to do:** Get specific syntax documentation for functions and error handling

**What the issue was:** Calling `xanoscript_docs` with different topics (`quickstart`, `functions`, `syntax`) returned largely the same general documentation rather than topic-specific details.

**Why it was an issue:** I couldn't find specific syntax for:
- How to properly raise/throw errors
- The difference between `var.update` and just reassigning `var`
- Array manipulation syntax details

**Potential solution (if known):**
- Ensure topic-specific docs return focused content
- Add a searchable syntax reference with code examples
- Include more inline code examples in the docs

---

## 2025-02-20 08:06 PST - Array Indexing and Mutation

**What I was trying to do:** Understand how to swap array elements in place during sorting

**What the issue was:** It was unclear whether `var.update $arr[$i]` would work or if I needed to use a different approach for array mutation.

**Why it was an issue:** The documentation mentions `var.update` for updating variables but doesn't clearly show array element mutation syntax.

**Potential solution (if known):**
- Add explicit examples of array element assignment/mutation
- Clarify if arrays are passed by value or reference
- Show common sorting algorithm patterns

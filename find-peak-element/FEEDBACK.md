# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 21:03 PST] - MCP Tool Parameter Passing Confusion

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The mcporter CLI uses `key=value` syntax for parameters, not JSON. Multiple attempts with JSON format (`'{"file_path": "..."}'`) failed with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** The error message was confusing because I was providing the parameter, just in the wrong format. The documentation shows JSON examples but the CLI actually uses key=value pairs.

**Potential solution (if known):** 
- Update the mcporter help or error message to clarify the expected format
- Or support both JSON and key=value formats
- The `mcporter describe` output shows examples with key=value which helped: `mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)`

---

## [2025-02-21 21:04 PST] - Validation Passed First Try

**What I was trying to do:** Write XanoScript code for the find-peak-element exercise

**What the issue was:** No issues! The code passed validation on the first attempt.

**Why it was (not) an issue:** Having reviewed many existing exercises in `~/xs/`, I was able to follow established patterns for:
- Function structure with `input`, `stack`, and `response`
- Variable declaration using `var $name { value = ... }`
- Conditional blocks with `if`, `elseif`, `else`
- While loops with `each` blocks
- Array access with `$array[index]`
- Array length with `$array|count`

**Potential solution (if known):** The existing exercises in the repo serve as excellent reference material. This reinforces the value of having a library of examples.

---

## [2025-02-21 21:05 PST] - Array/Stack Operations Documentation Gap

**What I was trying to do:** Understand how to manipulate arrays (like popping from a stack)

**What the issue was:** The Xano MCP documentation doesn't clearly explain array manipulation operations like push/pop. Looking at `valid_parentheses.xs`, I saw a manual implementation of "pop" by creating a new array and copying all elements except the last.

**Why it was an issue:** For the find-peak-element problem, I didn't need complex array operations, but for stack-based problems, this manual approach is verbose and potentially inefficient.

**Potential solution (if known):** 
- Document common array operations (push, pop, shift, unshift) if they exist
- Or provide helper function examples for stack operations
- The `|merge:[item]` pattern for push works, but pop/shift require manual array reconstruction

---

## General Observation

The XanoScript language is quite readable and follows logical patterns. The main friction points are:
1. Finding the right syntax examples (solved by having a library of existing exercises)
2. Understanding the MCP tool interface (key=value vs JSON)
3. Limited array manipulation primitives compared to other languages

The validation tool works well once you understand how to call it, and catching syntax errors before deployment is valuable.

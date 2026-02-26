# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 00:08 PST] - Issue 1: Nullable object types not supported

**What I was trying to do:** Define a linked list node structure with an optional `next` pointer that could be null (for the tail node).

**What the issue was:** I initially tried to use `object? next { schema { ... } }` to indicate the next node could be null. The validator threw an error: `Expecting token of type --> Identifier <-- but found --> '?' <--`

**Why it was an issue:** I was trying to model a recursive data structure (linked list node) where the `next` field is optional/nullable. The documentation mentions `?` after type means nullable, but this doesn't work for `object` types with schemas.

**Potential solution (if known):** The error message suggested using `json` instead, which worked. However, this loses type safety and schema validation. It would be helpful if either:
1. `object?` with schema was supported
2. The documentation clarified that `?` nullable modifier only works for primitive types, not object schemas
3. There was guidance on how to properly model recursive/linked data structures

---

## [2026-02-26 00:10 PST] - Issue 2: Cannot modify $input with var.update

**What I was trying to do:** Modify the input node's value and next pointer in place using `var.update $input.node.val { value = ... }`

**What the issue was:** The validator threw an error: `"$input" is a reserved variable name` when trying to use `var.update` on `$input.node.val`.

**Why it was an issue:** I wanted to follow the classic algorithm for this problem: copy the next node's value to current node, then update the next pointer. Since I can't modify `$input` directly, I had to create a new `$result` variable instead.

**Potential solution (if known):** This might be working as designed (immutability of inputs is good practice), but it wasn't immediately clear from the documentation. The error message was helpful though - it clearly stated `$input` is reserved.

A note in the `functions` documentation about input immutability would be helpful, especially for developers coming from languages where modifying input parameters is common.

---

## [2026-02-26 00:06 PST] - Issue 3: MCP tool parameter format unclear

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths.

**What the issue was:** I initially tried passing `files='["run.xs","function/delete_node.xs"]'` but got an error: `One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

**Why it was an issue:** The parameter name is `file_paths` (plural with underscore), not `files`. I had to run `mcporter list xano --schema` to discover the correct parameter name.

**Potential solution (if known):** Not a major issue, but perhaps the error message could list the available parameters or suggest checking the schema. Using `directory` parameter ended up being easier anyway.

---

## General Observations

### What worked well:
1. The `xanoscript_docs` tool is excellent - comprehensive and well-organized
2. The validator gives clear, actionable error messages with line/column numbers
3. The suggestion to use `json` instead of `object?` was spot-on
4. The `directory` parameter for batch validation is very convenient

### Documentation gaps:
1. Clarify that `object` with schema doesn't support the `?` nullable modifier
2. Add a note about `$input` immutability in the functions documentation
3. More examples of recursive/nested data structures would be helpful

### Overall experience:
The development loop (write → validate → fix) was smooth once I understood the constraints. The error messages were genuinely helpful, not cryptic. The documentation is comprehensive but could benefit from more edge case examples.

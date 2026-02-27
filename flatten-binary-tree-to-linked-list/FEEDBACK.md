# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 08:02 PST] - Object schema with nullable nested objects not supported

**What I was trying to do:** 
Define a binary tree node schema where `left` and `right` children could be either another node object or null.

**What the issue was:** 
I initially tried to define the schema like this:
```xs
object tree {
  schema {
    int val
    object? left
    object? right
  }
}
```

This resulted in the error: `Expecting token of type --> Identifier <-- but found --> '?' <--`

The `?` nullable marker after the type name doesn't work with `object` types inside a schema definition.

**Why it was an issue:** 
Binary trees inherently have recursive structure where child nodes can be null (leaf nodes). The documentation mentions that `object` requires a schema, but doesn't clearly indicate how to handle nullable/recursive object fields within that schema.

**Potential solution (if known):** 
The MCP's error hint suggested using `json` instead, which worked. However, it would be helpful if:
1. The documentation explicitly stated that `object?` is not valid inside schema definitions
2. There was guidance on how to handle recursive data structures (like trees) in XanoScript
3. The `json` type was more prominently featured as the solution for arbitrary/recursive JSON structures

---

## [2025-02-27 08:02 PST] - MCP validate_xanoscript parameter naming

**What I was trying to do:** 
Call the `validate_xanoscript` tool to validate my XanoScript files.

**What the issue was:** 
Initially I used `file=` as the parameter name, but the MCP requires `file_path=`. The error message was: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** 
It took a moment to realize the correct parameter name. The error message lists the valid parameters, but I had to check the schema to confirm the exact names.

**Potential solution (if known):** 
The error message is actually quite clear - it lists the valid options. No change needed, just user attention to detail.

---

## [2025-02-27 08:02 PST] - Documentation was helpful for Morris traversal implementation

**What I was trying to do:** 
Implement the Morris traversal algorithm for flattening a binary tree.

**What worked well:** 
The `essentials` and `functions` documentation topics provided clear examples of:
- Variable declaration and updates (`var`, `var.update`)
- While loops and conditionals
- The proper structure for functions with input/stack/response blocks
- Common mistakes to avoid (like using `elseif` instead of `else if`)

**Positive feedback:** 
The documentation is comprehensive and the examples are practical. The common mistakes section in `essentials` saved me from several potential errors.

---

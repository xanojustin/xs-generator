# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-01 14:32 PST] - Input Block Schema Type Issue

**What I was trying to do:** Define an input parameter with a nested object schema that has optional/nullable fields for a binary tree node structure.

**What the issue was:** I initially wrote:
```xs
input {
  object root {
    schema {
      int? val
      object? left
      object? right
    }
  }
}
```

This failed validation with error: "Expecting token of type --> Identifier <-- but found --> '?' <--" at the `object? left` line.

**Why it was an issue:** The validator suggested using "json" instead of "object", but this wasn't clear from the documentation. It seems like `object?` (nullable object type) isn't supported in input block schemas, or the syntax is different than expected.

**Potential solution (if known):** 
- The documentation could clarify what types are valid in input schema definitions
- The error message was actually helpful suggesting "json" instead
- It would be good to have clear documentation on how to define optional/nested object inputs

**Workaround used:** Changed to a simple `json` type with a description explaining the expected structure:
```xs
input {
  json root {
    description = "Root node of the binary search tree (object with val, left, right)"
  }
}
```

## [2025-03-01 14:33 PST] - Documentation Discovery

**What I was trying to do:** Find the correct syntax for run.job and function definitions.

**What the issue was:** Had to call `xanoscript_docs` multiple times with different topics to get the full picture. The main docs give an overview but specific topics like "run" and "essentials" are needed for practical implementation.

**Why it was an issue:** It took multiple round trips to get all the information needed (run job syntax, function syntax, type names, common patterns).

**Potential solution (if known):** 
- A single "quickstart for run jobs" topic that combines the key information
- Example showing a complete run job + function implementation together


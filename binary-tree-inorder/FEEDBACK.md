# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 05:05 PST] - Object Schema with Descriptions Not Supported

**What I was trying to do:** Define a binary tree input using `object` type with a schema that has descriptions for each field

**What the issue was:** The XanoScript parser failed when I tried to add `description = "..."` inside object schema properties:
```xs
object tree {
  schema {
    int value { description = "Node value" }
    object left? { description = "Left child node (null if none)" }
  }
}
```

Error: `Expecting: expecting at least one iteration which starts with one of these possible Token sequences...`

**Why it was an issue:** I was trying to document the expected structure of the binary tree node, but the parser doesn't allow descriptions inside object schema definitions. The documentation wasn't clear about this limitation.

**Potential solution:** 
1. Allow descriptions in object schema fields for better documentation
2. Or update documentation to clarify that descriptions can only be at the input field level, not inside object schemas
3. The MCP error suggestion "Use json instead of object" was helpful

---

## [2025-02-20 05:08 PST] - Comments Inside run.job Input Block Cause Parse Errors

**What I was trying to do:** Add comments inside the `input:` block of a `run.job` to document the tree structure being passed

**What the issue was:** Comments inside the input object cause cryptic parse errors:
```xs
run.job "Test" {
  main = {
    input: {
      // This comment causes: "Expected an object {} but found: '{'"
      nodes: [...]
    }
  }
}
```

The error message "Expected an object {} but found: '{'" was very confusing because '{' IS an object start. The actual issue was the comment on the previous line.

**Why it was an issue:** The error message didn't indicate that comments were the problem. I had to trial-and-error remove different parts of the code to find the cause.

**Potential solution:**
1. Improve parser error messages to indicate when comments are used in invalid locations
2. Or allow comments inside input blocks (preferred - they're useful for documentation)
3. Document this restriction clearly in the run.job documentation

---

## [2025-02-20 05:10 PST] - Nested Object Literals in run.job Input

**What I was trying to do:** Pass a nested binary tree structure directly in the run.job input:
```xs
input: {
  tree: {
    value: 1
    left: {
      value: 2
      left: { value: 4, left: null, right: null }
      right: { value: 5, left: null, right: null }
    }
    right: { value: 3, left: null, right: null }
  }
}
```

**What the issue was:** This syntax didn't work - got parse errors. I had to switch to an array-based representation with index references like the linked-list example.

**Why it was an issue:** It's unclear from documentation whether deeply nested object literals are supported in run.job input blocks. The linked-list example uses an array with index references, which works but is less intuitive for representing trees.

**Potential solution:**
1. Document whether nested object literals are supported in run.job inputs
2. If not supported, provide clear examples of the array-with-indices pattern for representing trees/graphs
3. Consider supporting nested objects for more intuitive data representation

---

## [2025-02-20 05:12 PST] - MCP file_paths Parameter Parsing Issue

**What I was trying to do:** Validate multiple files at once using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP tool interpreted the comma-separated string as individual characters:
```
mcporter call xano.validate_xanoscript file_paths="/path/file1.xs,/path/file2.xs"
```
Result: Tried to validate files named "U", "s", "e", "r", "s" (individual characters from the path)

**Why it was an issue:** Had to use the `directory` parameter instead, which works but validates all files in the directory rather than specific files.

**Potential solution:**
1. Fix the array parameter parsing in mcporter/MCP to properly handle comma-separated values
2. Or document the correct format for passing arrays (maybe JSON array syntax?)

---

## General Feedback

**What's working well:**
- The validation tool catches syntax errors quickly
- Error messages often include helpful suggestions (like "Use json instead of object")
- The documentation via `xanoscript_docs` is comprehensive

**Areas for improvement:**
1. Error messages could be more specific about the actual problem vs parser expectations
2. The distinction between `object` (requires schema) and `json` (arbitrary data) could be clearer
3. More examples of run.job with complex inputs would be helpful
4. Consistency on where comments are allowed would reduce trial-and-error

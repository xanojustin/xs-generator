# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 21:32 PST] - File path validation not working

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool with `file_path` or `directory` parameters

**What the issue was:** The MCP tool returned "File not found" errors even though the files existed:
```
File not found: "/Users/justinalbrecht/xs/path-sum-ii/run.xs"
```

**Why it was an issue:** Had to resort to passing code as a string parameter, which requires careful shell escaping and is less convenient than passing file paths

**Workaround used:** 
```bash
CODE=$(cat /Users/justinalbrecht/xs/path-sum-ii/run.xs) && mcporter call xano validate_xanoscript "code=$CODE"
```

**Potential solution:** The MCP server may be running in a different working directory or sandbox. Consider allowing relative paths from the current working directory, or document the expected path format clearly.

---

## [2025-03-02 21:35 PST] - Object type schema limitations unclear

**What I was trying to do:** Define a recursive tree structure input using `object` type with nested schema

**What the issue was:** The validator rejected nested `object` types within a schema block:
```xs
object root {
  description = "..."
  schema {
    int val { description = "Node value" }
    object left { description = "Left child node" }  // Error here
    object right { description = "Right child node" }  // Error here
  }
}
```

**Error message:**
```
Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'
```

**Why it was an issue:** The error message suggests using "json" instead, but doesn't explain why or when to use each type. It took looking at existing examples to understand the pattern.

**Resolution:** Changed to `json` type for the entire recursive structure:
```xs
json root { description = "Binary tree root node with val, left, right properties" }
```

**Potential solution:** 
1. Document that `object` schema blocks don't support nested `object` types
2. Provide a clearer error message explaining that recursive structures should use `json` type
3. Add examples of tree/graph structures to the documentation

---

## [2025-03-02 21:38 PST] - xanoscript_docs topic parameter not returning specific docs

**What I was trying to do:** Get specific documentation for topics like "functions", "run", and "essentials" using `xanoscript_docs({ topic: "..." })`

**What the issue was:** All topic queries returned the same general documentation overview instead of topic-specific content

**Why it was an issue:** Had to rely on reading existing implementations in ~/xs/ to understand patterns instead of getting proper documentation

**Potential solution:** Fix the topic routing in the MCP server to return the correct documentation sections, or document that the topic parameter is not currently functional.

---

## General Observations

**What worked well:**
- The `validate_xanoscript` tool with `code` parameter works reliably
- Error messages include line/column numbers and helpful suggestions
- The suggestion to use "json" instead of "object" was ultimately correct

**What could be improved:**
1. File-based validation (file_path, file_paths, directory parameters)
2. Topic-specific documentation in xanoscript_docs
3. Clearer documentation on when to use `object` vs `json` types
4. More examples of recursive data structures in documentation

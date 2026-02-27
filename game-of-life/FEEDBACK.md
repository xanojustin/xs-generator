# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 18:30 PST] - Documentation Topic Retrieval

**What I was trying to do:** Get specific XanoScript syntax documentation for writing run jobs and functions

**What the issue was:** The `xanoscript_docs` MCP tool returned the same generic documentation regardless of the topic parameter I passed. I tried topics like "quickstart", "functions", "run", and "syntax" but all returned identical content.

**Why it was an issue:** Without specific syntax documentation, I had to rely on reading existing implementations to understand the correct XanoScript patterns.

**Potential solution:** The MCP should return topic-specific documentation, or the documentation index should be more granular.

---

## [2026-02-26 18:32 PST] - MCP validate_xanoscript JSON Parameter Format

**What I was trying to do:** Validate XanoScript files using the MCP `validate_xanoscript` tool

**What the issue was:** The tool requires JSON parameters but the mcporter CLI syntax was unclear. I tried multiple approaches:
- `mcporter call xano validate_xanoscript '{"directory": "/path"}'` - failed
- `mcporter call xano validate_xanoscript --directory '/path'` - failed
- Various JSON quoting attempts - all failed

The error was consistently: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** I wasted significant time trying to figure out the correct parameter passing syntax.

**Resolution:** Finally discovered the correct syntax requires `--args` flag:
```
mcporter call xano validate_xanoscript --args '{"directory": "/path"}'
```

**Potential solution:** The MCP tool description could include clearer examples of the correct mcporter invocation syntax.

---

## [2026-02-26 18:33 PST] - Validation Success

**What I was trying to do:** Validate the Game of Life XanoScript files

**What the issue was:** None! The files validated successfully on the first attempt.

**Why this worked:** I was able to infer the correct syntax from reading existing implementations (fizzbuzz and number-of-islands exercises).

**Notable patterns learned from existing code:**
- `var $name { value = ... }` for variable declaration
- `var.update $name { value = ... }` for updating variables
- `conditional { if (...) { ... } elseif (...) { ... } }` for conditionals
- `while (...) { each { ... } }` for loops
- `array.push $var { value = ... }` for array operations
- `math.add $var { value = n }` for arithmetic
- `return { value = ... }` for early returns

---

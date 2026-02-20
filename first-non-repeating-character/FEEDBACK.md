# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-20 00:30 PST] - MCP Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my .xs files using JSON format

**What the issue was:** The tool requires `key=value` format rather than JSON. I initially tried:
```
mcporter call xano validate_xanoscript '{"directory": "/Users/justinalbrecht/xs/first-non-repeating-character"}'
```

But got error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** I had to look at previous FEEDBACK.md files to discover the correct format:
```
mcporter call xano validate_xanoscript directory=/Users/justinalbrecht/xs/first-non-repeating-character
```

**Potential solution:** Consistent parameter passing documentation or better error messages showing example usage

---

## [2026-02-20 00:25 PST] - Documentation Scope Issue

**What I was trying to do:** Get detailed XanoScript syntax documentation before writing code

**What the issue was:** The `xanoscript_docs` tool returned the same high-level documentation regardless of which topic I requested (quickstart, syntax, functions, run). I couldn't find specific syntax details like:
- How to write loops (while/each syntax)
- How to declare and update variables
- How to write conditionals (if/elseif/else)
- How to call functions from run jobs

**Why it was an issue:** I had to examine existing exercise files to understand the actual syntax patterns, which worked but was inefficient. The documentation index mentions specific line numbers (e.g., "Filters (L179-275)") but those sections weren't accessible.

**Potential solution:** 
1. Make topic-specific documentation actually return different content
2. Provide a complete syntax reference as a separate topic
3. Include code examples for all major constructs

---

## [2026-02-20 00:20 PST] - Lack of Map/Dictionary Data Structure

**What I was trying to do:** Build a frequency map for characters in the "first non-repeating character" algorithm

**What the issue was:** XanoScript doesn't appear to have a mutable map/dictionary structure for counting character frequencies. I had to use nested loops (O(n²)) instead of a hash map (O(n)).

**Why it was an issue:** The algorithm is less efficient than it could be. For a string of length n, I'm doing n² character comparisons instead of a single pass to build counts and a second pass to find the first unique character.

**Potential solution:** 
1. Document workarounds for map-like structures (objects with dynamic keys?)
2. Add a proper map/dictionary type to XanoScript
3. Provide built-in frequency/counting filters for common use cases

---

## [2026-02-20 00:15 PST] - Positive Feedback: Directory Validation Works Well

**What worked well:** Using the `directory` parameter for validation recursively finds and validates all `.xs` files

**Why it matters:** Very convenient for multi-file exercises - one command validates everything

---

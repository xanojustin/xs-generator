# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 00:10 PST] - MCP Parameter Passing Format

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The parameter passing format through `mcporter` was not immediately clear. I tried several approaches:
1. `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` - JSON format didn't work
2. `mcporter call xano validate_xanoscript --directory .` - was interpreted as code, not a flag
3. `mcporter call xano validate_xanoscript directory="."` - worked but said no files found
4. `mcporter call xano validate_xanoscript directory="/full/path"` - finally worked

**Why it was an issue:** The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" kept appearing even when I was passing JSON parameters. The mcporter syntax was unclear.

**Potential solution (if known):** The documentation could include clear examples of mcporter call syntax for each tool. Something like:
```bash
# Correct syntax:
mcporter call xano validate_xanoscript directory="/full/path/to/dir"
mcporter call xano validate_xanoscript file_path="/full/path/to/file.xs"
```

---

## [2025-02-24 00:12 PST] - Filter Expression Parentheses Rule

**What I was trying to do:** Access the last element of an array using `$prefix[$prefix|count - 1]`

**What the issue was:** The validator rejected this with "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message was slightly confusing - it mentioned "filters and tests" but the issue was combining a filter (`|count`) with arithmetic (`- 1`). I initially thought wrapping just the filter part in parentheses would work, but I had to restructure the code entirely.

**What worked:**
```xs
// Instead of:
var $current_sum { value = $prefix[$prefix|count - 1] + $input.nums[$i] }

// I used:
var $prefix_len { value = ($prefix|count) - 1 }
var $last_prefix { value = $prefix[$prefix_len] }
var $current_sum { value = $last_prefix + $input.nums[$i] }
```

**Potential solution (if known):** The error message could be more specific, like: "When using filters in array indices, compute the index in a separate variable first" or show both the problematic pattern and the recommended fix.

---

## [2025-02-24 00:08 PST] - Documentation Depth for Syntax Patterns

**What I was trying to do:** Understand the correct syntax for loops, conditionals, and variable operations in XanoScript

**What the issue was:** The `xanoscript_docs` tool returned high-level overviews but lacked detailed syntax patterns for common operations like:
- While loop syntax
- Array indexing patterns
- How to use `math.add` vs `var.update`
- When to use `each { }` inside loops

**Why it was an issue:** I had to look at existing examples in `~/xs/` to understand the patterns, which worked but was slower than having reference documentation.

**Potential solution (if known):** A "cheatsheet" or "quick_reference" topic in xanoscript_docs with common patterns like:
```xs
// While loop
while ($i < $n) {
  each {
    // loop body
    math.add $i { value = 1 }
  }
}

// Array access
var $elem { value = $arr[$index] }

// Array push
array.push $arr { value = $new_elem }
```

---

## General Observations

**What worked well:**
- The validation tool is helpful and gives line/column precise errors
- The error messages include suggestions (like "Use 'int' instead of 'integer'")
- Looking at existing examples in `~/xs/` provided good reference material
- The file structure conventions are clear from the docs

**Overall experience:** Once I figured out the mcporter syntax and saw a few examples, development was straightforward. The main friction was around syntax discovery and the filter expression parentheses rule.

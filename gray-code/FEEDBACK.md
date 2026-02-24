# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 14:35 PST] - MCP Tool Parameter Format Inconsistency

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` MCP tool

**What the issue was:** The `validate_xanoscript` tool requires parameters in a different format than other tools. I tried multiple formats that all failed:
- JSON format: `'{"file_path": "/path/to/file.xs"}'` - Error: "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"
- JSON with double quotes: `"{"file_path":"/path/to/file.xs"}"` - Same error
- CLI-style flags: `--file-path run.xs` - Error: "Expecting --> function <-- but found --> '-'"

**What actually worked:** `key=value` format: `file_path=/Users/justinalbrecht/xs/gray-code/run.xs`

**Why it was an issue:** This format is inconsistent with how other MCP tools (like `xanoscript_docs`) accept parameters via JSON. This caused significant confusion and wasted time trying different formats.

**Potential solution (if known):** Standardize all tools to accept the same parameter format, preferably JSON since it's more flexible for complex data structures.

---

## [2026-02-24 14:38 PST] - Bit-Shift Operator Not Supported

**What I was trying to do:** Calculate 2^(n-1) efficiently using the left bit-shift operator `1 << (n-1)`

**What the issue was:** XanoScript parser threw an error: "Expecting: one of these possible Token sequences... but found: '<'"

**Why it was an issue:** Bit-shift operators (`<<`, `>>`) are standard in most programming languages for efficient power-of-2 calculations. I assumed they were supported in XanoScript expressions within backticks.

**Potential solution (if known):** 
1. Add bit-shift operators to the XanoScript expression parser
2. OR document clearly in the syntax docs which operators are NOT supported
3. Provide a `math.pow` or similar function for power calculations

**Workaround used:** Replaced `1 << (i - 1)` with an iterative multiplication loop:
```xs
var $add_val { value = 1 }
var $k { value = 1 }
while (`$k < $i`) {
  each {
    var.update $add_val { value = $add_val * 2 }
    var.update $k { value = $k + 1 }
  }
}
```

---

## [2026-02-24 14:40 PST] - Missing Documentation on Operator Support

**What I was trying to do:** Find a comprehensive list of operators supported in XanoScript expressions (within backticks)

**What the issue was:** The `xanoscript_docs` topic "syntax" doesn't provide a clear list of which operators are supported vs. not supported in expressions. I had to discover through trial and error that bit-shift operators don't work.

**Why it was an issue:** Wasted time on multiple validation cycles figuring out what syntax is valid.

**Potential solution (if known):** Add a "Supported Operators" section to the syntax documentation that explicitly lists:
- Arithmetic: `+`, `-`, `*`, `/`, `%`
- Comparison: `==`, `!=`, `<`, `>`, `<=`, `>=`
- Logical: `&&`, `||`, `!`
- Bitwise: `&`, `|`, `^`, `~`, `<<`, `>>` (if supported)
- Other: `??` (null coalescing), etc.

---

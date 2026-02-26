# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 23:33 PST] - Issue: file_paths parameter parsing

**What I was trying to do:** Validate multiple XanoScript files using the `file_paths` parameter with comma-separated paths

**What the issue was:** The MCP tool parsed the comma-separated string character by character instead of as an array of file paths. Each character became a separate "file" to validate:
- `/Users/justinalbrecht/xs/valid-boomerang/run.xs` was parsed as individual characters: `U`, `s`, `e`, `r`, `s`, etc.
- This resulted in "File not found: U", "File not found: s", etc.

**Why it was an issue:** Made it impossible to use the `file_paths` parameter as documented. Had to switch to using the `directory` parameter instead.

**Potential solution:** The MCP should properly parse JSON arrays for the `file_paths` parameter, or the CLI should accept the array format differently.

---

## [2025-02-25 23:33 PST] - Issue: run.job syntax documentation gap

**What I was trying to do:** Write a run job that calls a function multiple times with different test inputs

**What the issue was:** The quick_reference documentation for `run` only showed:
```
run.job - Execute a function once
```

With no syntax example for the `run.job` block. I initially wrote:
```xs
run.job {
  description = "..."
  stack {
    function.run "name" { ... }
  }
}
```

But the correct syntax (learned from existing examples) is:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

**Why it was an issue:** The documentation doesn't show the actual syntax for `run.job`. I had to look at existing examples in the repo to understand the structure.

**Potential solution:** Add a syntax example to the `run` topic documentation showing the `main = { name: ..., input: ... }` structure.

---

## [2025-02-25 23:33 PST] - Issue: Complex multi-line expressions fail parsing

**What I was trying to do:** Write a complex mathematical expression across multiple lines:
```xs
var $area2 { 
  value = ($input.point1.x * ($input.point2.y - $input.point3.y)) + 
          ($input.point2.x * ($input.point3.y - $input.point1.y)) + 
          ($input.point3.x * ($input.point1.y - $input.point2.y))
}
```

**What the issue was:** The parser failed at line 32 with "Expecting: one of these possible Token sequences" but found `\n` (newline).

**Why it was an issue:** XanoScript doesn't seem to support line continuation for expressions. I had to break the calculation into intermediate variables.

**Potential solution:** Either:
1. Document that expressions must be on a single line
2. Support explicit line continuation (like `\` at end of line)
3. Improve error message to say "expressions cannot span multiple lines"

---

## [2025-02-25 23:33 PST] - Issue: Function naming convention unclear

**What I was trying to do:** Name my function `valid-boomerang` (with hyphen) to match the folder name

**What the issue was:** The function name worked, but I later noticed that existing examples use underscores (e.g., `two_sum`, `fizzbuzz`). I'm unsure if hyphens are officially supported or if they might cause issues elsewhere.

**Why it was an issue:** Inconsistent naming patterns across examples. Some use hyphens in folder names but underscores in function names.

**Potential solution:** Document the recommended naming convention for functions vs folders.

---

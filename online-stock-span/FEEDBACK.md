# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-28 11:05 PST - MCP Parameter Format Confusion

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The mcporter CLI parameter format was unclear. I initially tried:
- `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` (JSON format - failed)
- `mcporter call xano validate_xanoscript --file_paths file1 file2` (flag format - failed with "expected array, received string")
- `mcporter call xano validate_xanoscript --directory ./path` (was interpreted as code input)

**Why it was an issue:** The error messages were confusing. The `--directory` flag was being interpreted as actual XanoScript code to validate, resulting in an error about expecting `function` but finding `-`.

**Potential solution:** The correct format is `key=value` without dashes: `mcporter call xano validate_xanoscript directory=/full/path`. This should be better documented in the MCP tool descriptions or examples.

---

## 2026-02-28 11:08 PST - Stack Array Manipulation is Verbose

**What I was trying to do:** Implement a stack data structure for the monotonic decreasing stack algorithm

**What the issue was:** Popping from a stack (removing the last element) requires verbose manual array reconstruction:

```xs
var $new_stack { value = [] }
var $j { value = 0 }
while ($j < (($stack|count) - 1)) {
  each {
    var $new_stack { value = $new_stack|merge:[$stack[$j]] }
    var.update $j { value = $j + 1 }
  }
}
var $stack { value = $new_stack }
```

**Why it was an issue:** This is very verbose compared to a simple `stack.pop()` in other languages. It makes stack-based algorithms harder to read and write, and increases the chance of off-by-one errors.

**Potential solution:** Add a built-in `array|pop` filter or a `stack` data type with native push/pop operations. Or document a pattern for efficient stack operations if there's a better way.

---

## 2026-02-28 11:10 PST - Boolean Loop Control Variables

**What I was trying to do:** Control a nested while loop with a boolean flag

**What the issue was:** I needed to use a pattern like:

```xs
var $continue_popping { value = true }
while ($continue_popping) {
  each {
    conditional {
      if (condition) {
        // do work
      }
      else {
        var $continue_popping { value = false }
      }
    }
  }
}
```

The `var.update` syntax wouldn't work well here since I needed to redeclare within the conditional.

**Why it was an issue:** Understanding when to use `var` vs `var.update` was slightly confusing at first. The documentation mentions `var.update` for updating existing variables, but the pattern for conditionally exiting a while loop wasn't immediately obvious.

**Potential solution:** More examples of loop control patterns in the documentation would help. Or perhaps a `break` statement for loops.

---

## 2026-02-28 11:12 PST - No Syntax Errors on First Try!

**What I was trying to do:** Write valid XanoScript code for the online stock span problem

**What went well:** After reading the existing examples and documentation, I was able to write valid XanoScript on the first attempt. The validation passed immediately with no errors.

**Key factors that helped:**
1. Reading existing exercise implementations (fizzbuzz, min-stack) showed the proper patterns
2. The documentation clearly explains the block structure: `input { }`, `stack { }`, `response = $var`
3. Type names are simple: `int`, `text`, `bool`, `type[]` for arrays
4. The filter syntax with pipes (`|merge:`, `|count`, `|last`) is intuitive

**Positive feedback:** The learning curve wasn't too steep once I found good examples to reference.


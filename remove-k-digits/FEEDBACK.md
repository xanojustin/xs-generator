# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 16:05 PST] - Issue 1: While loop requires 'each' block

**What I was trying to do:** Write a while loop that pops elements from a stack until a condition is met.

**What the issue was:** The XanoScript parser requires while loops to have an `each` block inside them. This is different from most programming languages where you can write code directly inside a while loop.

**Code that failed:**
```xs
while ((($stack|count) > 0) && ($remaining_k > 0) && (($stack|last) > $digit)) {
  // Pop from stack
  var $new_stack { value = $stack|slice:0:-1 }
  var.update $stack { value = $new_stack }
  // Decrement remaining_k
  var.update $remaining_k { value = $remaining_k - 1 }
}
```

**The error:**
```
[Line 31, Column 89] Expecting --> each <-- but found --> '
' <--
```

**Why it was an issue:** This is unintuitive syntax that isn't clearly documented in the essentials guide. The example in the docs shows:
```xs
while ($counter < 10) {
  each {
    var.update $counter { value = $counter + 1 }
  }
}
```

But it doesn't explain WHY this structure is required or that the `each` is mandatory. Coming from other languages, this feels like unnecessary boilerplate.

**Potential solution:**
1. Allow direct statements inside while loops without the `each` wrapper
2. Or, make the error message clearer: "While loops must contain an 'each' block. Example: while (condition) { each { ... } }"
3. Document this pattern more prominently in the syntax guide

---

## [2025-03-03 16:15 PST] - Issue 2: Negative array indices not supported

**What I was trying to do:** Use negative indexing to slice from the end of an array: `$stack|slice:0:(-$remaining_k)`

**What the issue was:** XanoScript doesn't support negative indices in array operations. In Python and JavaScript, `-n` means "n from the end," which is very convenient for stack operations.

**Code that failed:**
```xs
var $final_stack { value = $stack|slice:0:(-$remaining_k) }
```

**The error:**
```
[Line 50, Column 52] Expecting: one of these possible Token sequences... but found: '-'
```

**Why it was an issue:** Negative indexing is a common pattern in many languages. The error message doesn't indicate that negative indices aren't supported - it just says it expected something else. I had to guess that negative indices weren't implemented.

**Workaround:** Calculate the positive index manually:
```xs
var $end_index { value = ($stack|count) - $remaining_k }
var $final_stack { value = $stack|slice:0:$end_index }
```

**Potential solution:**
1. Support negative indices in slice operations
2. Or, provide a clearer error message like "Negative array indices are not supported. Calculate the positive index instead."
3. Add a note about this limitation in the array-filters documentation

---

## [2025-03-03 16:00 PST] - Issue 3: Initial MCP tool discovery confusion

**What I was trying to do:** Find the correct way to call `xanoscript_docs` as mentioned in the task instructions.

**What the issue was:** The task instructions mentioned calling `xanoscript_docs` but I couldn't find it as a CLI command. I had to discover that it's available through the MCP server via `mcporter call xano.xanoscript_docs`.

**Why it was an issue:** There was a gap between the task instructions (which assumed CLI access to `xanoscript_docs`) and the actual available tools (MCP server via mcporter).

**Potential solution:**
1. Update task instructions to specify the correct MCP invocation pattern
2. Or, provide a CLI wrapper for `xanoscript_docs` when @xano/developer-mcp is installed globally

---

## [2025-03-03 16:20 PST] - Issue 4: Documentation organization

**What I was trying to do:** Quickly reference syntax patterns while coding.

**What the issue was:** The documentation is comprehensive but requires multiple calls to different topics to get the full picture. For example, to understand functions I needed:
- `xanoscript_docs topic=essentials`
- `xanoscript_docs topic=functions`  
- `xanoscript_docs topic=syntax`

**Why it was an issue:** It took multiple round trips to gather all the context needed. The `file_path` mode that auto-detects relevant docs is helpful, but I didn't discover it until after I'd already made multiple calls.

**Potential solution:**
1. Consider a `quick_reference` or `cheat_sheet` topic that consolidates common patterns
2. Or, make the `file_path` mode more discoverable in the help text
3. Add cross-references between topics (e.g., in the functions docs, explicitly mention "see syntax topic for loop patterns")

---

## General Observations

**What worked well:**
- The validation tool is excellent - gives clear line/column numbers and helpful suggestions
- The `essentials` guide covers common mistakes which is very valuable
- Documentation is comprehensive when you find the right topic

**What could be improved:**
- Error messages could be more actionable (suggest the fix, not just the problem)
- Some syntax patterns (like while-each) need more prominent documentation
- A single-page quick reference would help experienced developers from other languages

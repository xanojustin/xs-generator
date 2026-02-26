# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 21:35 PST] - Array Type Syntax Confusion

**What I was trying to do:** Define an input parameter that accepts an array of integers for the kth-smallest-element function.

**What the issue was:** I initially wrote `array[int] numbers` which is a common pattern in many programming languages (TypeScript, Python, etc.). The validator rejected this with the error:
```
Expecting --> } <-- but found --> 'array' <--
💡 Suggestion: Use "type[]" instead of "array"
```

**Why it was an issue:** The error message was helpful (it suggested using `type[]`), but it wasn't immediately clear from the documentation that XanoScript uses a different array type syntax. The `xanoscript_docs` for syntax doesn't explicitly show this pattern for input declarations.

**Potential solution (if known):** 
1. The documentation could include a clear example of array type declarations in the `input` block section
2. A quick reference table for type declarations would be helpful:
   | Other Languages | XanoScript |
   |-----------------|------------|
   | `array[int]` | `int[]` |
   | `Array<string>` | `text[]` |
   | `boolean[]` | `bool[]` |

## [2025-02-25 21:37 PST] - mcporter Call Syntax

**What I was trying to do:** Call the `validate_xanoscript` tool with file paths.

**What the issue was:** It took several attempts to get the correct mcporter call syntax. The tool requires `--args` for JSON payloads, but this wasn't immediately obvious from the initial attempts.

**Why it was an issue:** I tried:
- `mcporter call xano validate_xanoscript --files '[...]'` ❌
- `mcporter call xano validate_xanoscript '{"file_paths": [...]}'` ❌
- `mcporter call xano validate_xanoscript --args '{"directory": "..."}'` ✅

The skill documentation mentions `--args` but it's easy to miss when you're focused on the tool parameters.

**Potential solution (if known):** 
1. Include example calls directly in the tool output when called without required parameters
2. The Xano MCP could provide a `validate_xanoscript --help` via mcporter that shows usage examples

## [2025-02-25 21:38 PST] - Missing Documentation on Object Filter `set` Syntax

**What I was trying to do:** Update an array element during bubble sort (swap two elements).

**What the issue was:** I wasn't sure if `$sorted|set:$j:($sorted|get:($j + 1))` was the correct syntax for setting an array element at a dynamic index.

**Why it was an issue:** The documentation shows `set` for objects with string keys, but not clearly for arrays with numeric indices. I had to make an assumption about the syntax.

**Potential solution (if known):** 
1. Add explicit examples for array element assignment using the `set` filter with numeric indices
2. Document whether arrays can be modified in-place or if reassignment is always required

## [2025-02-25 21:39 PST] - Loop Control and Early Return

**What I was trying to do:** Implement an early return from the sorting loop when the array is already sorted (optimization).

**What the issue was:** I wasn't sure if `return { value = ... }` inside a `while` loop would work correctly, or if I needed to structure the code differently.

**Why it was an issue:** The documentation shows `return` in conditional blocks for early exit, but not clearly inside loops within `each` blocks.

**Potential solution (if known):** 
1. Clarify in the documentation whether `return` works from any scope level or only from specific contexts
2. Add examples showing early return from nested structures (loops inside conditionals inside loops)


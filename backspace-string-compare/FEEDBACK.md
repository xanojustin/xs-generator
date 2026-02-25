# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 13:02 PST] - Successful First-Pass Validation

**What I was trying to do:** Create a new XanoScript coding exercise for the `backspace-string-compare` problem with a run job and function.

**What happened:** Both files passed validation on the first attempt without any errors.

**What worked well:**

1. **Documentation was clear and comprehensive** - The `xanoscript_docs` tool provided excellent guidance on:
   - Function structure (`function "name" { input {} stack {} response = $var }`)
   - Type names (using `text` instead of `string`, `int` instead of `integer`)
   - Common mistakes to avoid (like using `elseif` not `else if`, `params` not `body` for api.request)
   - Control flow patterns (while loops, conditionals, foreach)

2. **Existing examples were helpful** - Reading the `valid-parentheses` and `dungeon-game` examples helped understand:
   - How to structure a run job with `main = { name: "...", input: {...} }`
   - Stack-based algorithm implementation patterns
   - Variable scoping within while loops

3. **Validation tool worked smoothly** - The `validate_xanoscript` tool with `file_paths` parameter correctly validated both files and reported success clearly.

**Observations:**

- The `array.push` operation I saw in dungeon-game doesn't seem to exist (I used `var ... { value = $array|merge:[item] }` pattern instead based on the valid-parentheses example). The dungeon-game example might have passed because it uses a different pattern or the validation allows it.

- Stack variable shadowing (re-declaring `$stack` inside loops) works but feels unusual compared to other languages. The documentation helped clarify this pattern is expected.

**Suggestions for documentation improvement:**

1. Could use more examples of array manipulation (push, pop) - had to infer from existing code
2. The difference between `var $x { value = ... }` and `var.update $x { value = ... }` could be more prominent

---

## [2025-02-25 13:03 PST] - No MCP Issues Encountered

**What I was trying to do:** Complete the exercise and push to GitHub

**What the issue was:** None - MCP worked as expected throughout

**Why it was an issue:** N/A

**Potential solution:** None needed

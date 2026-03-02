# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-02 13:35 PST] - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs and logs the results.

**What the issue was:** I initially wrote the run.job with a `stack` block following the pattern used in `function`, `query`, and other constructs:

```xs
run.job "test_valid_word_abbreviation" {
  stack {
    function.run "valid_word_abbreviation" { ... }
  }
}
```

**Why it was an issue:** This caused a validation error: "The argument 'stack' is not valid in this context". The run.job syntax is completely different from other constructs - it uses `main = { name: "...", input: {...} }` instead of a stack block.

**Potential solution (if known):** 
- The documentation for run.job (`xanoscript_docs({ topic: "run" })`) clearly explains the correct syntax, but it's easy to miss since most other constructs use `stack`.
- Consider adding a more helpful error message like "run.job uses 'main' property, not 'stack'. See xanoscript_docs({ topic: 'run' }) for correct syntax."
- Perhaps add a note in the essentials documentation about this difference.

---

## [2025-03-02 13:32 PST] - Missing documentation on return/early exit in loops

**What I was trying to do:** Implement early exit from an inner while loop when parsing numbers in the abbreviation string.

**What the issue was:** I needed to break out of an inner while loop when encountering a non-digit character. I wasn't sure if `break` was supported or what the syntax was.

**Why it was an issue:** The essentials documentation mentions `return { value = ... }` for early returns from conditionals, but doesn't cover loop control flow (break/continue).

**Potential solution (if known):**
- Add documentation about loop control flow to the essentials or functions topic
- Clarify if `break` and `continue` are supported in while/foreach loops
- I used `return { value = "break" }` as a workaround, but not sure if this is idiomatic

---

## [2025-03-02 13:28 PST] - String character access pattern unclear

**What I was trying to do:** Access individual characters from a string by index.

**What the issue was:** I wasn't sure what the best pattern was for character-by-character string traversal. I ended up using `substr:$idx:1` which works but feels verbose.

**Why it was an issue:** The documentation mentions `substr` for substrings but doesn't have explicit examples of character iteration patterns.

**Potential solution (if known):**
- Add a "String iteration" or "Character access" pattern to the essentials documentation
- Example: iterating through a string with index-based access

---

## General Feedback

### What worked well:
1. The `xanoscript_docs` MCP tool is excellent - comprehensive and well-organized
2. Validation errors are specific and show line/column numbers
3. The essentials documentation is very helpful with "Common Mistakes" section
4. mcporter makes calling MCP tools straightforward

### Suggestions for improvement:
1. **Consistent construct syntax:** Most constructs use `stack { }` but `run.job` doesn't - this inconsistency is surprising
2. **More loop examples:** Show patterns for nested loops with early exit
3. **String manipulation patterns:** Add common patterns like character iteration, building strings character by character

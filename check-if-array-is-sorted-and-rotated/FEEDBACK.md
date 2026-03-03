# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 04:32 PST] - Response cannot be inside conditional blocks

**What I was trying to do:** Create a function that returns a boolean value based on a condition

**What the issue was:** I initially wrote code like:
```xs
conditional {
  if ($n <= 1) {
    response = true
  }
}
```

This resulted in the error: `Expecting --> } <-- but found --> 'response' <--`

**Why it was an issue:** I didn't know that `response` must be at the very end of the stack block and cannot appear inside any conditional or control flow block. This is different from many other languages where return statements can be anywhere.

**Potential solution (if known):** 
- The documentation mentions using `return { value = ... }` for early returns, but it wasn't clear that `response` has the same restriction
- It would be helpful to have a more explicit error message like "'response' must be at the end of the stack block, use 'return' for early exits"

---

## [2025-03-03 04:35 PST] - Return statement syntax confusion

**What I was trying to do:** Return early from a function when array length is <= 1

**What the issue was:** The syntax for early return is `return { value = true }` not `return true` or just `return`. It took me a moment to get the braces and equals sign correct.

**Why it was an issue:** The syntax is different from typical programming languages. Most use `return true` or `return(value)`.

**Potential solution (if known):** 
- The documentation shows this pattern but it's easy to overlook
- A quick reference card showing "Early return pattern: `return { value = $result }`" would be helpful

---

## [2025-03-03 04:30 PST] - MCP tool invocation via shell was tricky

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths

**What the issue was:** The initial attempt with `file_paths:=[path1,path2]` failed because the shell interpreted the brackets. I had to use `--args '{"file_paths": [...]}'` syntax.

**Why it was an issue:** The mcporter CLI syntax wasn't immediately obvious for complex arguments. The error message from zsh about "no matches found" wasn't helpful.

**Potential solution (if known):**
- More examples in the mcporter help showing JSON argument passing
- A simpler shorthand like `mcporter call xano.validate_xanoscript directory:./path` would be convenient

---

## General Observations

### What worked well:
- The `xanoscript_docs` topic system is excellent - very comprehensive
- The validation tool gives clear line/column error locations
- The error messages (when syntax is wrong) are fairly specific

### What could be improved:
1. **Common patterns guide:** A single-page "Common XanoScript Patterns" showing:
   - How to return values from conditionals
   - Loop patterns with index tracking
   - Array manipulation examples

2. **Validation suggestions:** When validation fails, suggest the fix pattern:
   - "Did you mean to use `return { value = ... }` instead of `response = ...` inside a conditional?"

3. **foreach index access:** It would be nice if `foreach` provided a built-in `$index` variable instead of requiring manual tracking

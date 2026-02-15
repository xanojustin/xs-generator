# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 01:47 PST] - Filter Expression in Conditional

**What I was trying to do:**
Create a conditional check to see if any features were returned from the Mapbox API by checking if the features array count equals 0.

**What the issue was:**
The validator reported: `[Line 35, Column 35] An expression should be wrapped in parentheses when combining filters and tests`

I initially wrote:
```xs
conditional {
  if ($data.features|count == 0) {
    // ...
  }
}
```

This syntax looks intuitive and follows patterns from other languages, but XanoScript doesn't allow filters directly in comparison expressions within conditionals.

**Why it was an issue:**
The error message wasn't very clear about what the fix should be. It says "wrapped in parentheses" but the actual solution is to extract the filter result to a separate variable first, not just add parentheses.

**Potential solution (if known):**
Either:
1. Allow filters in conditionals with clearer error messaging (e.g., "Cannot use filters directly in if conditions. Store the result in a variable first.")
2. Or support the syntax with automatic extraction

---

## [2025-02-15 01:45 PST] - MCP Tool Naming Confusion

**What I was trying to do:**
Find the Xano MCP tool to validate XanoScript code.

**What the issue was:**
The tool is named `validate_xanoscript` but I had to run `mcporter list xano --schema` to find it. There's no simple `xano validate` command or obvious entry point in the main documentation.

**Why it was an issue:**
It took extra exploration to find the right tool. The naming convention isn't immediately obvious - is it `validate`, `validate_script`, `check_syntax`?

**Potential solution (if known):**
Add a `validate` or `check` alias, or include a quick reference in the main `xanoscript_docs` output showing the most commonly used tools.

---

## [2025-02-15 01:45 PST] - Documentation Format for Validation Errors

**What I was trying to do:**
Understand validation error output format to fix issues.

**What the issue was:**
The validator returns errors in a plain text format like:
```
Found 1 error(s):

1. [Line 35, Column 35] An expression should be wrapped in parentheses when combining filters and tests
```

This doesn't include:
- The actual problematic code snippet
- Suggested fix
- Link to relevant documentation

**Why it was an issue:**
Had to manually count lines and cross-reference with my code to understand what was wrong.

**Potential solution (if known):**
Include a code snippet in the error output:
```
Found 1 error(s):

1. [Line 35, Column 35] An expression should be wrapped in parentheses when combining filters and tests
   
   34 | conditional {
   35 |   if ($data.features|count == 0) {
      |       ^^^^^^^^^^^^^^^^^^^^^^^
   36 |     throw {
```

---

## General Feedback

### What Worked Well:
1. The `xanoscript_docs` tool is comprehensive and well-organized
2. The quickstart patterns are very helpful
3. The run.job/run.service documentation is clear
4. MCP integration works smoothly via mcporter

### Suggestions:
1. **Add more API integration examples** - Specifically showing common patterns for:
   - Query parameter construction with dynamic values
   - Handling paginated responses
   - Error retry logic

2. **JSON path access documentation** - More examples of accessing nested API response fields like `$api_result.response.result.choices|first|get:"message"|get:"content"`

3. **Filter precedence clarification** - Document which filters can be chained directly vs which need intermediate variables

4. **Validation on save** - If possible, integrate validation into a file watcher or pre-commit hook workflow

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 02:35 PST] - Issue: Response inside stack block causes cryptic error

**What I was trying to do:** Create a function that returns early when row_index is 0, using `response` and `return` inside a conditional block within the stack.

**What the issue was:** I initially wrote code like:
```xs
stack {
  var $row { value = [1] }
  
  conditional {
    if ($input.row_index == 0) {
      response = $row
      return
    }
  }
  // ... more logic ...
}
response = $row
```

The validator gave this error:
```
[Line 11, Column 9] Expecting --> } <-- but found --> 'response' <--
```

This error message was somewhat confusing because it made me think there was a missing brace somewhere, when actually the issue was that `response` cannot be used inside the `stack` block at all.

**Why it was an issue:** The error message didn't clearly explain that `response` is not allowed inside `stack` blocks. It just said it expected a `}` which made me think I had a syntax error with braces.

**Potential solution (if known):** The validator could detect when `response` appears inside a `stack` block and give a clearer error message like: `"'response' cannot be used inside 'stack' block. Move 'response' to the function level after the stack block closes."`

---

## [2025-02-27 02:37 PST] - Issue: file_paths parameter format unclear

**What I was trying to do:** Validate multiple files at once using the `validate_xanoscript` tool.

**What the issue was:** The first attempt used CLI-style comma-separated paths:
```bash
mcporter call xano.validate_xanoscript file_paths="/path/file1.xs,/path/file2.xs"
```

This failed with:
```
Invalid arguments: file_paths: Invalid input: expected array, received string
```

I had to use `--args` with JSON format instead:
```bash
mcporter call xano.validate_xanoscript --args '{"file_paths":["/path/file1.xs","/path/file2.xs"]}'
```

**Why it was an issue:** The CLI usage pattern wasn't immediately clear from the tool description. It took trial and error to figure out the correct format.

**Potential solution (if known):** The tool could accept comma-separated strings and convert them to arrays internally, or the documentation could show more examples of multi-file validation with different calling patterns.

---

## [2025-02-27 02:38 PST] - Observation: Documentation is helpful but could use more examples

**What I was trying to do:** Understand the correct structure for functions with early returns and complex conditionals.

**What I found:** The documentation for `functions` and `run` was comprehensive and well-organized. The quick reference sections were particularly useful.

**Why it matters:** The documentation helped me understand that I needed to restructure my logic to avoid early returns with `response` inside conditionals. However, there weren't many examples showing:
1. How to handle conditional logic that affects the final response
2. Best practices for accumulating results in variables vs direct response assignment

**Potential improvement:** Add an example showing a function that builds different results based on conditional branches, with a single response at the end.

---

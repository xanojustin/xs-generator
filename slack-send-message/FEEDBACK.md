# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 12:18 PST] - Nested Conditional Syntax Confusion

**What I was trying to do:**
Create a XanoScript function with multiple sequential input validations (check token, then check channel, then check message).

**What the issue was:**
I initially wrote nested `if` statements directly inside `else` blocks like this:
```xs
conditional {
  if ($bot_token == null) { ... }
  else {
    if ($channel == null) { ... }  // ERROR: 'if' found where '}' expected
    else {
      if ($message == null) { ... }
      ...
    }
  }
}
```

The validator returned: `[Line 28, Column 9] Expecting --> } <-- but found --> 'if' <--`

**Why it was an issue:**
This pattern is intuitive coming from other languages (JavaScript, Python, etc.) where you can chain if/else/ifs without additional wrappers. The error message was not clear about *why* it expected a `}` - it didn't explain that nested conditionals need their own `conditional` wrapper.

**Potential solution (if known):**
The documentation could explicitly show:
1. A clear example of multi-level validation pattern
2. An explicit note: "Inside an `else` block, if you need another `if/else`, wrap it in `conditional { }`"
3. A comparison showing "WRONG" vs "RIGHT" patterns

The fix was:
```xs
conditional {
  if ($bot_token == null) { ... }
  else {
    conditional {  // <-- WRAPPED IN conditional
      if ($channel == null) { ... }
      else {
        conditional {  // <-- WRAPPED IN conditional
          if ($message == null) { ... }
          ...
        }
      }
    }
  }
}
```

---

## [2025-02-13 12:22 PST] - Missing Documentation on Conditional Nesting

**What I was trying to do:**
Find documentation about proper conditional nesting patterns in XanoScript.

**What the issue was:**
The `functions` and `syntax` documentation topics don't mention how to handle nested conditionals. The quick reference only shows basic `if/else` at a single level.

**Why it was an issue:**
I had to discover the pattern through trial and error with the validator. The existing Stripe example I referenced used a different pattern (if/else with the main logic in the else), not sequential validation checks.

**Potential solution (if known):**
Add a section to the `functions` or `syntax` documentation:
```markdown
### Nested Conditionals
When you need nested if/else logic, wrap each level in its own `conditional` block:

```xs
conditional {
  if (condition1) { ... }
  else {
    conditional {
      if (condition2) { ... }
      else { ... }
    }
  }
}
```
```

---

## [2025-02-13 12:15 PST] - Documentation Discovery Workflow

**What I was trying to do:**
Find the correct syntax for creating a run job and making HTTP API requests.

**What the issue was:**
The `xanoscript_docs` tool has many topics, but I had to call it multiple times to find relevant information:
1. First call for general overview
2. Second call for `run` topic
3. Third call for `functions` topic  
4. Fourth call for `syntax` topic
5. Fifth call for `integrations` topic (found api.request here)

**Why it was an issue:**
It wasn't immediately clear which topic would contain what I needed. The `api.request` syntax was buried in `integrations` rather than `functions` or `syntax`.

**Potential solution (if known):**
1. Consider adding a search or index capability to the docs tool
2. Add "Common Patterns" topic that shows: "Making HTTP Requests", "Input Validation", "Error Handling"
3. Cross-link related topics (e.g., mention in `functions` that `api.request` is documented in `integrations`)

---

## [2025-02-13 12:20 PST] - File Naming Convention Confusion

**What I was trying to do:**
Name the function file correctly.

**What the issue was:**
The documentation says files should use `snake_case` naming, but looking at the Stripe example, I noticed the run job file is `run.xs` not `run.job.xs`. I initially thought I needed to name it `run.job.xs` based on the construct name.

**Why it was an issue:**
The documentation shows:
```
run.xs
```

But doesn't explicitly explain that regardless of whether it's `run.job` or `run.service`, the file is always `run.xs`.

**Potential solution (if known):**
Add a note in the run documentation: "Note: Both `run.job` and `run.service` constructs are defined in a file named `run.xs` (not `run.job.xs`)."

---

## [2025-02-13 12:25 PST] - Positive Feedback: Good Examples in Documentation

**What worked well:**
The `integrations` documentation had excellent, complete examples for `api.request` including:
- Full parameter list (url, method, params, headers, timeout)
- Response structure documentation
- Real-world usage pattern

This made it easy to adapt for the Slack API call once I found it.

**Suggestion:**
Consider moving or duplicating the `api.request` documentation to the `functions` topic since it's a core operation used within functions.

---

## Summary

Overall the MCP validation tool was very helpful - it caught syntax errors immediately and gave line/column numbers. The main friction was understanding the XanoScript conditional nesting pattern, which differs from most C-style languages.

The documentation is comprehensive but could benefit from:
1. More "complete example" patterns for common scenarios (validation, API calls, error handling)
2. A troubleshooting/FAQ section for common syntax mistakes
3. Cross-references between related topics

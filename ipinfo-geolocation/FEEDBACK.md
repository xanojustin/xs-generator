# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 08:47 PST] - Issue: Conditional Block Inside Variable Value

**What I was trying to do:**
Create a conditional URL builder that would use a different IPinfo API endpoint depending on whether an IP address was provided as input.

**What the issue was:**
I initially wrote code like this:
```xs
var $url {
  value = conditional {
    if ($input.ip != null && $input.ip != "") {
      "https://ipinfo.io/" ~ $input.ip ~ "/json?token=" ~ $api_key
    }
    else {
      "https://ipinfo.io/json?token=" ~ $api_key
    }
  }
}
```

This resulted in a validation error:
```
[Line 15, Column 15] Expecting: Expected an expression but found: 'conditional'
```

**Why it was an issue:**
I incorrectly assumed `conditional` could be used as an expression that returns a value (like a ternary operator). The documentation shows `conditional` as a standalone statement in examples, but doesn't explicitly state that it cannot be used as an expression within a variable assignment.

**Potential solution (if known):**
The documentation could include a clearer note that `conditional` is a statement, not an expression, and cannot be used inside variable value assignments. Perhaps also show the correct pattern for conditional value assignment using separate `var` declaration and `var.update` within the conditional branches.

The working solution was:
```xs
var $url { value = "" }

conditional {
  if ($input.ip != null && $input.ip != "") {
    var.update $url { value = "https://ipinfo.io/" ~ $input.ip ~ "/json?token=" ~ $api_key }
  }
  else {
    var.update $url { value = "https://ipinfo.io/json?token=" ~ $api_key }
  }
}
```

---

## [2025-02-18 08:48 PST] - Issue: Reserved Variable Name $response

**What I was trying to do:**
Create a variable named `$response` to hold the final response data before returning it from the function.

**What the issue was:**
The validator returned:
```
'$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
While the quickstart documentation does list `$response` as a reserved variable, I missed it in the long list of reserved names. The error message was helpful in suggesting an alternative name, but it would be nice to have this more prominently displayed or have the language server auto-suggest alternatives when typing reserved names.

**Potential solution (if known):**
Consider adding syntax highlighting or IDE warnings for reserved variable names in real-time as the user types. The documentation could also have a more prominent warning box about reserved names at the top of the syntax section.

---

## [2025-02-18 08:45 PST] - Positive Feedback: MCP Tool Worked Well

**What worked well:**
- The `xanoscript_docs` tool provided comprehensive, well-organized documentation
- The `validate_xanoscript` tool gave clear error messages with line/column positions
- The error suggestions (like suggesting `$my_response` instead of `$response`) were helpful
- The directory-based validation made it easy to validate all files at once

**Suggestions for improvement:**
- Consider adding a `cheatsheet` topic to `xanoscript_docs` that shows common patterns at a glance
- The MCP could benefit from an `init_project` tool that creates a basic scaffold for run.job, function, etc.
- Would be helpful to have a `format_xanoscript` tool for consistent code formatting

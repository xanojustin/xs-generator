# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 22:50 PST] - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool from a shell command.

**What the issue was:**
Passing multi-line XanoScript code through shell commands caused severe escaping issues. Using `sed` to escape quotes resulted in errors like:
```
[Line 2, Column 19] Expecting: one of these possible Token sequences: [...] but found: 'Track'
```

The shell was interpreting quotes and newlines incorrectly before they reached the MCP.

**Why it was an issue:**
This made validation extremely difficult. I had to resort to Python to properly JSON-encode the file content before passing it to mcporter.

**Potential solution (if known):**
- The MCP could accept a file path instead of requiring the code to be passed as a string parameter
- Or provide a CLI tool that handles file reading internally
- Or document the proper escaping method for shell usage

---

## [2025-02-14 22:55 PST] - Each Loop Syntax Unclear for Object Iteration

**What I was trying to do:**
Iterate over a decoded JSON object to merge properties into another object. I tried using:
```xs
each ($custom_props as $key:$value) {
  var.update $event_properties {
    value = $event_properties|set:$key:$value
  }
}
```

**What the issue was:**
The validator returned:
```
[Line 69, Column 13] Expecting --> } <-- but found --> 'each'
```

This suggests either:
1. The `each` syntax doesn't support `$key:$value` style iteration
2. `each` cannot be used inside `try_catch` blocks
3. The documentation doesn't match the actual parser behavior

**Why it was an issue:**
The quickstart documentation shows `each ($items as $item)` syntax but doesn't clarify:
- Whether object iteration with `$key:$value` is supported
- Whether `each` can be nested inside other blocks

I had to work around this by using the `merge` filter instead, which was actually cleaner but not my first approach.

**Potential solution (if known):**
- Document the exact supported patterns for `each` (arrays only? objects too?)
- Clarify nesting rules - can `each` be used inside `try_catch`, `conditional`, etc.?
- Provide more examples of object manipulation patterns

---

## [2025-02-14 23:00 PST] - Multi-line String Concatenation

**What I was trying to do:**
Create a readable multi-line error message using the string concatenation operator `~`:
```xs
var $error_message {
  value = "HTTP error " ~ ($api_result.response.status|to_text) ~ ": " ~ 
          ($api_result.response.result|json_encode)
}
```

**What the issue was:**
The parser rejected this with:
```
[Line 129, Column 82] Expecting: [...] but found: '
'
```

It seems XanoScript doesn't allow newlines inside expressions, even when logically continuing a statement.

**Why it was an issue:**
This forces all string concatenations to be on a single line, which can make complex expressions hard to read. I had to rewrite as:
```xs
value = "HTTP error " ~ ($api_result.response.status|to_text) ~ ": " ~ ($api_result.response.result|json_encode)
```

**Potential solution (if known):**
- Document that expressions must be on a single line
- Or support line continuation (like backslash in shell or implicit continuation after operators)
- Or document a recommended pattern for complex string building

---

## [2025-02-14 23:05 PST] - Unclear Type Declaration for Nullable Text Fields

**What I was trying to do:**
Declare an optional text input field with filters. I initially tried:
```xs
text? properties? { ... }
```

**What the issue was:**
I was unsure about the correct syntax for optional text fields with filters. Is it:
- `text? properties? { ... }`
- `text properties? { ... }`
- `text properties? filters=trim { ... }`

The validation error I got earlier (before fixing the description string) made it unclear whether the issue was with the type declaration or the content.

**Why it was an issue:**
The syntax documentation doesn't clearly show examples of optional fields with filters. I had to guess that `text properties? filters=trim { ... }` was the correct pattern.

**Potential solution (if known):**
- Add examples showing optional fields with filters in the quickstart
- Document the exact order: type modifiers name filters? default? { ... }

---

## Summary

Overall the Xano MCP worked well once I figured out the proper way to call it. The main pain points were:

1. **Shell escaping** - Required Python to properly pass file contents
2. **Ambiguous documentation** - Some syntax patterns weren't clearly documented
3. **Error messages** - Could be more specific about what construct is not allowed

The validation tool itself is very helpful - once I got it working, it caught real syntax errors quickly and provided line/column information that was accurate.

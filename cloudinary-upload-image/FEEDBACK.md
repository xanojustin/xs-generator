# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 20:50 PST] - Input Block `value` Property Not Valid

**What I was trying to do:**
Create a function with optional input parameters that have default values.

**What the issue was:**
I initially wrote:
```xs
input {
  text folder { description = "Folder path in Cloudinary (optional)", value = "" }
}
```

The validation failed with:
```
[Line 6, Column 73] The argument 'value' is not valid in this context
[Line 6, Column 73] Expected value of `value` to be `null`
```

**Why it was an issue:**
I assumed that `value` could be used to provide default values for input parameters, similar to other programming languages. The error message was somewhat confusing because it mentioned `null` but my intent was to have an empty string default.

**Potential solution (if known):**
The documentation could clarify that:
1. Input blocks don't support default values via `value`
2. Optional parameters should be handled in the stack logic with conditional checks
3. Show a clear pattern for handling optional vs required inputs

---

## [2025-02-13 20:45 PST] - Documentation Discovery Challenge

**What I was trying to do:**
Find the correct syntax for making HTTP API requests (`api.request`).

**What the issue was:**
The `api.request` syntax was not in the obvious places I checked (quickstart, syntax, functions topics). I had to search through multiple documentation topics to find it. Eventually found it in the README topic's "Example Implementations" section.

**Why it was an issue:**
Making HTTP requests is a very common operation. It should be prominently featured in the quickstart documentation with a complete working example, not buried in a large README document.

**Potential solution (if known):**
- Add a dedicated topic for "http" or "external_apis" that focuses on `api.request`
- Include `api.request` examples in the quickstart guide
- Cross-reference from the "integrations" topic to where `api.request` is documented

---

## [2025-02-13 20:47 PST] - String Concatenation in Complex Expressions

**What I was trying to do:**
Build a signature string for Cloudinary's authenticated upload API that required concatenating multiple values with operators.

**What the issue was:**
I needed to build a string like: `file=<url>&timestamp=<ts><secret>`

The documentation mentions that when using filters with concatenation, you need parentheses. However, I was uncertain about the precedence and whether I needed parentheses around the entire expression or just filtered parts.

**Why it was an issue:**
The documentation says "wrap each filtered expression in parentheses" but when you have complex concatenation with mixed variables and filters, it's not immediately obvious what's needed.

**Potential solution (if known):**
Add more examples showing complex concatenation patterns:
```xs
// Example with mixed variables and filters
var $complex { 
  value = "prefix_" ~ ($var1|to_text) ~ "_" ~ ($var2|filter) ~ "_suffix" 
}
```

---

## [2025-02-13 20:48 PST] - Now Timestamp Function Unclear

**What I was trying to do:**
Generate a Unix timestamp for API authentication.

**What the issue was:**
I used `now|to_seconds` based on inference from the date/time filters documentation, but wasn't sure if `now` was a variable, function, or keyword.

**Why it was an issue:**
The documentation lists `to_timestamp`, `to_ms`, `to_seconds` as filters but doesn't clearly document what `now` is or other ways to get the current time.

**Potential solution (if known):**
Add a section in the syntax documentation explaining:
- `now` - current timestamp
- Other time-related constants/variables if they exist
- Best practices for timestamp generation

---

## [2025-02-13 20:49 PST] - No Default Filter Alternative Pattern Missing

**What I was trying to do:**
Handle optional input parameters that might be empty strings.

**What the issue was:**
The documentation explicitly states "There is no `default` filter. Use conditional blocks or `first_notnull`/`first_notempty` instead."

However, it doesn't show a clear pattern for checking if an optional text parameter was provided or is empty.

**Why it was an issue:**
I had to guess that checking `$input.folder != ""` was the right approach. It worked, but I wasn't sure if there was a more idiomatic way (like checking for null vs empty string).

**Potential solution (if known):**
Add a pattern to the quickstart:
```xs
// Handling optional text input
conditional {
  if (`$input.optional_field != ""`) {
    // Field was provided
  }
}
```

Or document the difference between:
- Not providing a parameter (null?)
- Providing an empty string
- How to check for both cases

---

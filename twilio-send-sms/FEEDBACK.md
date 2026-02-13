# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 09:45 PST] - $env Variables Not Allowed in run.job Input

**What I was trying to do:**
Create a run.job that passes environment variables as inputs to the function being called.

**What the issue was:**
When I tried to use `$env.twilio_to_number` in the run.job's `input` block, the validator returned this error:
```
[Line 5, Column 11] Expecting: one of these possible Token sequences:
...but found: '$env'
```

The documentation for run.job says:
> Input values must be constants - No variables like `$input` allowed

However, it doesn't mention that `$env` variables are also not allowed. This was unexpected since environment variables are typically treated as constants.

**Why it was an issue:**
I had to restructure the code to pass an empty `input: {}` and have the function read `$env` variables directly from within the stack. This works but is less flexible than being able to parameterize the run job via environment variables in the input block.

**Potential solution (if known):**
Either:
1. Allow `$env` variables in run.job input blocks (since they are effectively constants at runtime)
2. Update the documentation to explicitly state that `$env` is not allowed in run.job input blocks

---

## [2026-02-13 09:50 PST] - Unknown `default` Filter

**What I was trying to do:**
Provide a default value for an environment variable using the pipe filter syntax: `$env.twilio_message_body|default:"Hello..."`

**What the issue was:**
The validator returned:
```
[Line 14, Column 40] Unknown filter function 'default'
```

I assumed a `default` filter would exist since it's common in templating languages (Twig, Jinja2, etc.).

**Why it was an issue:**
I had to rewrite the code using a conditional block to check for null and set a default value. This is more verbose than a simple filter would be.

**Potential solution (if known):**
Consider adding a `default` filter for providing fallback values:
```xs
var $message_body {
  value = $env.twilio_message_body|default:"Hello from Xano!"
}
```

Alternatively, document the available filters more prominently so developers know what options exist.

---

## [2026-02-13 09:52 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Convert a status code to text using a filter: `$api_result.response.status|to_text`

**What the issue was:**
The validator returned:
```
An expression should be wrapped in parentheses when combining filters and tests
```

**Why it was an issue:**
The error message was somewhat unclear. I had to extract the expression into a separate variable with parentheses to satisfy the validator:
```xs
var $http_status {
  value = ($api_result.response.status)
}
var $status_text {
  value = $http_status|to_text
}
```

**Potential solution (if known):**
The error message could be more specific about which expression needs parentheses. Also, it's unclear why `$api_result.response.status|to_text` requires parentheses when it seems like a simple filter application.

---

## General Observations

### Strengths
1. The `xanoscript_docs` MCP tool is very helpful for understanding the language
2. The validation tool catches errors early and provides line/column numbers
3. The language structure is clean and declarative

### Areas for Improvement
1. **Documentation of available filters**: It's not clear from the main docs what filters are available beyond a few examples
2. **Error message clarity**: Some errors could be more specific about what the parser expects
3. **Consistency in variable access**: `$env` works in functions but not in run.job input blocks - this is slightly confusing

### Documentation Wishlist
1. A comprehensive list of all available filters with examples
2. Clearer rules about where `$env`, `$input`, `$auth`, etc. can be used
3. More examples of real-world API integrations (like this Twilio example)

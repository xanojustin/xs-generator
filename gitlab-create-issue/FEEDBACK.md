# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 07:50 PST] - MCP validate_xanoscript Tool Confusion

**What I was trying to do:**
Validate the XanoScript files I created using the Xano MCP's validate_xanoscript tool.

**What the issue was:**
The validate_xanoscript tool requires a `code` parameter (the actual code content), not a `file_path` parameter. Initially, I tried passing the file path:
```
mcporter call xano.validate_xanoscript file_path=/Users/justinalbrecht/xs/gitlab-create-issue/run.xs
```

This returned an error: "Error: 'code' parameter is required"

**Why it was an issue:**
It wasn't immediately clear from the tool name that it expects the actual code content rather than a file path. Most validation tools accept file paths, so this was unexpected.

**Potential solution (if known):**
- The tool could accept either `code` OR `file_path` parameter
- The MCP could provide a file reading helper
- Better documentation about the expected parameter format

---

## [2025-02-14 07:52 PST] - Passing Code Content to MCP Tool

**What I was trying to do:**
Pass the XanoScript code content to the validate_xanoscript tool for validation.

**What the issue was:**
Passing multi-line code with quotes, newlines, and special characters via command line is extremely difficult. The escaping requirements are complex and error-prone.

I tried several approaches:
1. Direct inline string - failed due to quoting issues
2. Using jq to JSON-encode the content - partially worked but shell escaping still caused issues
3. mcporter's --args with @file.json syntax - mcporter doesn't support this syntax

The only reliable method was to use bash variable expansion with jq encoding, but this is fragile.

**Why it was an issue:**
Validating files is a core workflow when developing XanoScript. The difficulty in passing code content makes the validation tool hard to use in practice.

**Potential solution (if known):**
- Add a `file_path` parameter as an alternative to `code`
- Provide a CLI wrapper that handles file reading internally
- Support reading from stdin

---

## [2025-02-14 07:45 PST] - XanoScript Syntax: elseif vs else if

**What I was trying to do:**
Write conditional statements in XanoScript.

**What the issue was:**
The documentation clearly states that XanoScript uses `elseif` (one word) not `else if` (two words). This is different from many other languages like JavaScript, Python, etc. that use `else if` or `elif`.

```xs
// ❌ Wrong in most languages, definitely wrong in XanoScript
conditional {
  if (...) { }
  else if (...) { }  // Parse error!
}

// ✅ Correct in XanoScript
conditional {
  if (...) { }
  elseif (...) { }
}
```

**Why it was an issue:**
This is a common syntax mistake that would cause parse errors. While documented, it's an easy trap for developers coming from other languages.

**Potential solution (if known):**
The documentation already covers this well in the "Common Mistakes" section. A linter or IDE extension could help catch this.

---

## [2025-02-14 07:48 PST] - XanoScript: Using params vs body in api.request

**What I was trying to do:**
Make an HTTP POST request with a request body in XanoScript.

**What the issue was:**
In most programming languages, you use `body` to set the request body. In XanoScript, you use `params` instead:

```xs
// ❌ Wrong
api.request {
  url = "..."
  method = "POST"
  body = $payload  // "body" is not valid!
}

// ✅ Correct
api.request {
  url = "..."
  method = "POST"
  params = $payload  // Use "params" for request body
}
```

**Why it was an issue:**
This naming is counter-intuitive for developers familiar with HTTP concepts. `params` typically means URL query parameters, not the request body.

**Potential solution (if known):**
The documentation clearly documents this, but the naming choice is still confusing. Supporting both `params` and `body` with `body` being an alias could help.

---

## [2025-02-14 07:55 PST] - XanoScript: String Concatenation with Filters

**What I was trying to do:**
Concatenate strings that include filtered values.

**What the issue was:**
When using filters inside string concatenation, you MUST use parentheses around the filtered expression:

```xs
// ❌ Wrong
var $msg { value = $status|to_text ~ " - " ~ $data|json_encode }

// ✅ Correct
var $msg { value = ($status|to_text) ~ " - " ~ ($data|json_encode) }
```

**Why it was an issue:**
Without parentheses, the filter precedence causes unexpected behavior. This is documented but easy to forget.

**Potential solution (if known):**
The documentation covers this. A linter warning about filter precedence in concatenation could help.

---

## [2025-02-14 07:58 PST] - XanoScript: Response Body Access

**What I was trying to do:**
Access the response body from an api.request call.

**What the issue was:**
The structure for accessing the response body is `$api_result.response.result`. This wasn't immediately obvious from the examples - I had to carefully study the existing Stripe implementation to understand the pattern.

```xs
api.request {
  url = "https://api.example.com/data"
  method = "POST"
  params = $payload
} as $api_result

// Access response body
var $body { value = $api_result.response.result }
// Access HTTP status
var $status { value = $api_result.response.status }
```

**Why it was an issue:**
The nesting structure (`response.result` for body, `response.status` for status) isn't immediately intuitive. I expected something like `$api_result.body` or `$api_result.data`.

**Potential solution (if known):**
More examples in the documentation showing the full response structure would help. A diagram of the response object structure would be valuable.

---

## [2025-02-14 08:00 PST] - XanoScript: Variable Redeclaration in Conditionals

**What I was trying to do:**
Update a variable inside a conditional block in XanoScript.

**What the issue was:**
When parsing error responses, I need to extract error information from potentially different fields. I found myself wanting to redeclare variables like `$error_message` multiple times in different conditional branches.

I had to structure the code carefully to avoid redeclaring variables:

```xs
// This pattern doesn't work - can't redeclare $error_message
conditional {
  if (...) {
    var $error_message { value = "First error" }
  }
  if (...) {
    var $error_message { value = "Second error" }  // Error!
  }
}
```

**Why it was an issue:**
This requires restructuring code to use a single variable declaration with updates, which is less intuitive than being able to set the variable in different branches.

**Potential solution (if known):**
This might be by design for scoping reasons, but it wasn't immediately clear from the documentation.

---

## Summary

Overall, the Xano MCP worked well for retrieving documentation via `xanoscript_docs`. The main friction points were:

1. **Validation Tool UX** - The `validate_xanoscript` tool expects code content rather than file paths, making it awkward to use from the CLI.

2. **Syntax Quirks** - Several XanoScript syntax choices (elseif, params instead of body) differ from common programming languages and require mental context-switching.

3. **Documentation Gaps** - While comprehensive, some practical details (like the exact response structure from api.request) required studying examples rather than being explicitly documented.

The documentation system via `xanoscript_docs` with different topics is excellent and provided all the information I needed once I knew what to look for.

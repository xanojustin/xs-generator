# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 03:17 PST] - Documentation Topics Return Generic Index

**What I was trying to do:**
Get specific documentation about XanoScript run jobs and function syntax using `xanoscript_docs` with topic parameters like "run", "integrations", and "functions".

**What the issue was:**
All topic queries returned the same generic documentation index page instead of specific content for each topic. The "run" topic, "integrations" topic, and "functions" topic all returned identical content with just the index/reference table.

**Why it was an issue:**
I couldn't get detailed syntax information for run jobs or function definitions. I had to reverse-engineer the syntax by reading existing implementations in the ~/xs/ folder (stripe-charge-customer) instead of having proper reference documentation.

**Potential solution:**
Ensure the MCP server returns topic-specific content or provide a complete reference document that covers all constructs in one page.

---

## [2025-02-15 03:18 PST] - Validate Tool Requires 'code' Parameter

**What I was trying to do:**
Validate .xs files using the `validate_xanoscript` tool by passing a `file_path` parameter.

**What the issue was:**
The tool requires a `code` parameter (the actual code content as a string), not a `file_path`. When I tried passing file_path, I got:
```
Error: 'code' parameter is required
```

**Why it was an issue:**
I had to figure out the correct way to pass the code content. Direct JSON string passing was tricky due to escaping. I eventually found that using `mcporter call xano validate_xanoscript --args "$(cat file.xs | jq -Rs '{code: .}')"` worked, but this wasn't documented.

**Potential solution:**
- Support a `file_path` parameter as a convenience
- Document the expected parameter format clearly in the tool description
- Provide an example command in the documentation

---

## [2025-02-15 03:20 PST] - Auth Parameter Not Supported in api.request

**What I was trying to do:**
Add Basic Authentication to an `api.request` call using an `auth` parameter:
```xs
api.request {
  url = $api_url
  method = "POST"
  auth = {
    type: "basic"
    username: $key
    password: $secret
  }
}
```

**What the issue was:**
The validator returned:
```
Found 2 error(s):
1. [Line 70, Column 7] The argument 'auth' is not valid in this context
2. [Line 70, Column 14] Expecting: Expected a null but found: '{'
```

**Why it was an issue:**
I had to manually construct the Basic Auth header using base64 encoding instead. The syntax `auth` object seemed logical given the documentation mentions "Common Pattern: API Integration Function" with Bearer tokens in headers, but there's no mention of how to handle Basic Auth.

**Potential solution:**
- Add support for an `auth` parameter with `type: "basic"` and `type: "bearer"`
- Document how to construct Basic Auth headers manually if auth parameter isn't supported
- Provide examples for different authentication methods

---

## [2025-02-15 03:22 PST] - base64_encode Filter Not Documented

**What I was trying to do:**
Construct a Basic Auth header which requires base64 encoding of "username:password".

**What the issue was:**
I used `$auth_string|base64_encode` assuming the filter exists, but this wasn't documented anywhere I could find. I haven't actually tested if this filter works in production Xano - I'm hoping it does based on common Xano filter patterns.

**Why it was an issue:**
Uncertainty about whether the syntax will actually work at runtime. If `base64_encode` doesn't exist, the function will fail.

**Potential solution:**
- Document all available filters in the xanoscript_docs
- Provide a complete filter reference with examples

---

## [2025-02-15 03:23 PST] - Error Handling for Nested Objects

**What I was trying to do:**
Extract error messages from nested API response objects.

**What the issue was:**
The syntax for conditionally extracting nested values was unclear. I wasn't sure if I could chain `|get:` filters or if multiple conditional blocks were needed.

**Why it was an issue:**
I ended up with verbose nested conditional blocks that may not be the most efficient approach:
```xs
conditional {
  if ($api_result.response.result != null) {
    var $response_body { value = $api_result.response.result }
    var $error_msg { value = $response_body|get:"message" }
    conditional {
      if ($error_msg != null && $error_msg != "") {
        var $error_message { value = $error_msg }
      }
    }
  }
}
```

**Potential solution:**
- Document best practices for error handling from API responses
- Show examples of extracting nested optional fields
- Explain if there's a more concise syntax like `$api_result.response.result|get:"message"|default:"Unknown error"`

---

## Summary

The Xano MCP works well for validation once you figure out the correct syntax, but the documentation system needs improvement. The biggest gaps are:

1. Topic-specific documentation not returning detailed content
2. No clear reference for api.request parameters and authentication options
3. Missing documentation for available filters and string operations
4. No examples of common patterns like Basic Auth or error handling

The validation tool is helpful and caught my auth parameter error immediately. The error messages were clear about what was wrong. Having a file_path option would be a nice convenience addition.

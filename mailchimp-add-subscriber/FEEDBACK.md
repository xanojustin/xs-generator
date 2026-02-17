# FEEDBACK.md - MCP and XanoScript Development Notes

**Date:** 2024-02-16
**Project:** Mailchimp Add Subscriber Run Job
**Developer:** AI Assistant (Subagent)

---

## Summary

This document captures the struggles, learnings, and feedback from developing a Xano Run Job for Mailchimp API integration. This feedback is intended to help improve the Xano MCP server and XanoScript tooling.

---

## 1. MCP Server Setup Issues

### Issue: Installation Path Confusion
**What happened:**
The task instructed running `npm install -g @xano/developer-mcp`, but it wasn't immediately clear:
- Whether this installed a CLI tool or just an MCP server
- How to actually invoke the MCP tools after installation
- Whether `npx` was needed or if the package was globally available

**Resolution:**
Used `npx @xano/developer-mcp` via mcporter configuration. The mcporter skill made this easier once configured.

**Suggestion:**
Provide clearer documentation on the relationship between the npm package and how it's invoked through MCP.

---

## 2. Documentation Challenges

### Issue: Finding the Right Documentation Topics
**What happened:**
The `xanoscript_docs` tool requires specific topic names. I had to guess which topics existed and what they contained. The initial call returned an index, but discovering sub-topics required trial and error.

**Topics discovered:**
- `quickstart` - Very helpful for common patterns
- `syntax` - Comprehensive filter and operator reference
- `run` - Essential for run.job syntax
- `types` - Referenced but didn't explicitly call

**Suggestion:**
Consider adding a `list_topics` or `search_docs` function to the MCP that allows fuzzy searching or browsing available documentation.

### Issue: Understanding File Structure Conventions
**What happened:**
The task requested specific files:
- `run.job.xs`
- `test.xs`
- `types.xs`

But existing projects in the repo use:
- `run.xs` (not `run.job.xs`)
- No `test.xs` or `types.xs` files anywhere

This created confusion about whether to follow the task requirements or the existing patterns.

**Resolution:**
Created both patterns - `run.xs` for the actual run job (following existing convention) and `test.xs`/`types.xs` as requested (even though they're not standard in other projects).

**Suggestion:**
Standardize on file naming conventions and document them clearly. If `run.job.xs` is valid, existing projects should use it.

---

## 3. XanoScript Syntax Struggles

### Issue: Object Literal Syntax
**Initial confusion:**
Coming from JavaScript/TypeScript, I initially wrote:
```xs
// Wrong
var $data { value = { customer = $id } }
```

**Correct syntax:**
```xs
// Correct
var $data { value = { customer: $id } }
```

**Learning:**
XanoScript uses `:` not `=` for object properties. The quickstart documentation helped here.

### Issue: Filter Expression Parentheses
**What happened:**
String concatenation with filters requires careful parentheses:
```xs
// Wrong - parse error
var $msg { value = $status|to_text ~ " - " ~ $data|json_encode }

// Correct
var $msg { value = ($status|to_text) ~ " - " ~ ($data|json_encode) }
```

**Documentation:**
This is documented in the syntax reference, but easy to miss. It's a common source of errors.

### Issue: Conditional Block Syntax
**What happened:**
Used `else if` instead of `elseif` initially:
```xs
// Wrong
conditional {
  if (...) { }
  else if (...) { }  // Parse error!
}

// Correct
conditional {
  if (...) { }
  elseif (...) { }
}
```

**Suggestion:**
The error message for this could be more helpful - it currently just says "parse error" without indicating the correct keyword.

### Issue: Type Aliases vs Actual Types
**Confusion:**
Initially tried to use familiar type names:
```xs
// Wrong
input {
  string name      // Error: use "text"
  integer count    // Error: use "int"
  boolean active   // Error: use "bool"
}
```

**Correct:**
```xs
input {
  text name
  int count
  bool active
}
```

**Documentation:**
The quickstart has a good table for this, but it would be helpful to have a conversion guide for developers coming from TypeScript/JavaScript.

### Issue: Reserved Variable Names
**What happened:**
Tried to use `$response` as a variable name, not realizing it's reserved.

**Learning:**
The quickstart has a good table of reserved names. Important to check this first.

---

## 4. API Request Patterns

### Issue: Request Body Parameter Name
**What happened:**
Initially used `body` for POST request payload:
```xs
// Wrong
api.request {
  url = "..."
  method = "POST"
  body = $payload    // Invalid!
}
```

**Correct:**
```xs
api.request {
  url = "..."
  method = "POST"
  params = $payload  // Correct
}
```

**Suggestion:**
This is documented, but `body` is such a common convention that it might warrant a specific error message suggesting `params`.

### Issue: Building Conditional Objects
**Challenge:**
Building a payload with optional fields required multiple conditional blocks:
```xs
var $merge_fields { value = {} }

conditional {
  if (($input.first_name|strlen) > 0) {
    var $merge_fields { 
      value = $merge_fields|set:"FNAME":$input.first_name 
    }
  }
}
```

**Question:**
Is there a more elegant way to conditionally add fields to an object? Something like:
```xs
// Hypothetical
var $payload {
  value = {
    email: $input.email,
    FNAME?: $input.first_name,  // Only add if not null/empty
    LNAME?: $input.last_name
  }
}
```

### Issue: String Concatenation for URLs
**What happened:**
Building dynamic URLs requires the `~` operator:
```xs
url = "https://" ~ $server_prefix ~ ".api.mailchimp.com/3.0/lists/" ~ $input.audience_id ~ "/members"
```

**Learning:**
This is straightforward once you know it, but template literals (like JavaScript's `${variable}`) would be more readable.

---

## 5. Error Handling Patterns

### Issue: Response Status Checking
**What happened:**
Initially forgot to wrap filter expressions in parentheses when comparing:
```xs
// Wrong
if ($api_result.response.status >= 200 && $api_result.response.status < 300) { }

// Actually works (no filters involved), but with filters:
// Wrong
if ($array|count > 0) { }

// Correct
if (($array|count) > 0) { }
```

### Issue: Precondition vs Throw
**Decision point:**
When to use `precondition` vs `throw` vs `try_catch`?

**Pattern I settled on:**
- Use `precondition` for input validation (catches missing/invalid inputs early)
- Use `throw` for API-specific errors with custom error names
- Use `try_catch` for operations that might fail but should have fallbacks

**Suggestion:**
A decision tree or flowchart for error handling would be helpful.

---

## 6. Type System Feedback

### Issue: Optional Types in Input
**What works well:**
```xs
input {
  text required_field
  text optional_field?
  text with_default?="default_value"
}
```

**Question:**
Can input blocks validate email format automatically? Currently doing manual validation:
```xs
precondition ($input.email|contains:"@") {
  error_type = "inputerror"
  error = "Invalid email format"
}
```

### Issue: Custom Type Definitions (types.xs)
**What happened:**
Created `types.xs` with type definitions as requested, but unsure if this is valid XanoScript syntax or just documentation.

**Content created:**
```xs
type SubscriberInput {
  text email
  text first_name?
  // ...
}
```

**Question:**
Are custom type definitions supported in XanoScript, or is this just for documentation purposes? The documentation mentions type validation but doesn't show custom type definition syntax.

---

## 7. Testing and Validation

### Issue: No Built-in Test Runner
**What happened:**
Created `test.xs` with test cases, but there's no clear way to execute them or validate the syntax.

**Suggestion:**
A `validate_xanoscript` MCP tool was mentioned in the task, but I couldn't find documentation on how to use it or what it validates.

### Issue: Live Testing Challenges
**Challenge:**
Without a way to run the XanoScript locally, testing requires:
1. Deploying to Xano
2. Configuring environment variables in Xano dashboard
3. Running the job through Xano's interface

**Suggestion:**
A local test runner or dry-run mode would be very helpful for development iteration.

---

## 8. Mailchimp-Specific Learnings

### Authentication
**Discovery:**
Mailchimp uses HTTP Basic Auth with:
- Username: `apikey`
- Password: Your actual API key

The authorization header must be:
```
Authorization: Basic {base64("apikey:your_api_key")}
```

**Implementation:**
```xs
headers = [
  "Authorization: Basic " ~ ("apikey:" ~ $api_key)|base64_encode
]
```

### Server Prefix
**Discovery:**
The server prefix (e.g., `us1`, `us14`) is required in the API URL. This is:
- The part after the dash in your API key (`key-us1`)
- The subdomain in your Mailchimp admin URL (`us1.admin.mailchimp.com`)

**Suggestion:**
Some developers might expect to extract this from the API key automatically, but the API requires it as a separate configuration value.

### Subscriber Status
**Options:**
- `subscribed` - Immediate subscription
- `pending` - Double opt-in email sent
- `unsubscribed` - Unsubscribed
- `cleaned` - Bounced/invalid

For this integration, we use `subscribed` to immediately add the user.

---

## 9. MCP Tool Feedback

### Positive: Documentation Tool
The `xanoscript_docs` tool is excellent once you know the topic names. The content is comprehensive and well-organized.

### Suggestion: Interactive Validation
It would be helpful to have an MCP tool that:
1. Takes XanoScript code as input
2. Returns syntax errors with line numbers
3. Suggests fixes for common mistakes

### Suggestion: Example Generator
A tool that generates example code for common patterns:
- "Generate an API integration function"
- "Generate input validation for email"
- "Generate error handling for HTTP requests"

---

## 10. Overall Experience

### What Worked Well
1. **mcporter skill** - Made adding and using the Xano MCP server straightforward
2. **Documentation quality** - Once found, the docs are clear and comprehensive
3. **Syntax consistency** - XanoScript has clear, consistent patterns
4. **Error types** - The typed error system (`inputerror`, `accessdenied`, etc.) is helpful

### What Was Challenging
1. **Initial setup** - Unclear how the npm package connected to MCP
2. **File naming** - Conflicting conventions between task and existing projects
3. **Syntax quirks** - Common mistakes (parentheses, `elseif`, `params` vs `body`)
4. **Testing workflow** - No local validation or test runner

### Recommendations for Improvement

1. **Quickstart CLI tool** - A guided setup that:
   - Validates the MCP server is configured
   - Shows available documentation topics
   - Validates XanoScript syntax

2. **Better error messages** - Specifically:
   - Suggest `elseif` when `else if` is detected
   - Suggest `params` when `body` is detected
   - Suggest correct type names (`text` instead of `string`)

3. **Template generator** - Command to scaffold common patterns:
   ```
   xano template api-integration --name mailchimp
   ```

4. **VS Code extension** - Syntax highlighting and error detection would be huge

---

## Files Created

1. `run.xs` - Run job configuration
2. `function/mailchimp_add_subscriber.xs` - Main function implementation
3. `test.xs` - Test cases (5 scenarios)
4. `types.xs` - Type definitions (uncertain if valid XanoScript or documentation)
5. `README.md` - Comprehensive documentation
6. `FEEDBACK.md` - This file

---

## Conclusion

The Xano MCP server and XanoScript language are powerful once you learn the patterns. The main friction points are:
1. Initial discovery of documentation and conventions
2. Syntax differences from more common languages
3. Testing/validation workflow

With better tooling for validation, error messages, and templates, the developer experience would be significantly improved.

**Time to complete:** ~45 minutes
**Lines of code:** ~350
**Files created:** 6

---

*This feedback is provided to help improve the Xano MCP server and XanoScript development experience.*
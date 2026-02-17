# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 18:47 PST] - MCP Tool Syntax Discovery

**What I was trying to do:**
Call the `validate_xanoscript` tool through mcporter to validate my XanoScript files.

**What the issue was:**
The syntax for calling mcporter was unclear. I tried multiple approaches:
- `mcporter call xano validate_xanoscript --file_path <path>`
- `mcporter call xano validate_xanoscript --file <path>`
- `mcporter call xano validate_xanoscript '{"file_path": "..."}'`

None of these worked. The error messages were unhelpful:
```
Expecting --> function <-- but found --> '-'
```

**Why it was an issue:**
I wasted significant time trying different syntax variations. The documentation doesn't clearly show how to pass parameters to tools.

**Potential solution (if known):**
The correct syntax is: `mcporter call xano validate_xanoscript file_path=/path/to/file.xs`

Document this clearly with examples in the MCP documentation.

---

## [2025-02-16 18:50 PST] - Object vs json Type Confusion

**What I was trying to do:**
Define an input parameter that accepts a JSON object for the data to insert.

**What the issue was:**
I used `object data` in the input block, but XanoScript expects `json data`.

```xs
// ❌ Incorrect
object data { description = "Object containing the data to insert" }

// ✅ Correct
json data { description = "Object containing the data to insert" }
```

**Why it was an issue:**
The documentation lists types like `text`, `int`, `bool`, `decimal`, `type[]`, and `json`, but I instinctively reached for `object` since that's what the data type conceptually is. The error message was helpful though:
```
💡 Suggestion: Use "json" instead of "object"
```

**Potential solution (if known):**
The error message already provides a good suggestion. Perhaps add `object` as an alias for `json` since many developers think in terms of "objects" not "JSON".

---

## [2025-02-16 18:52 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Validate that the input data object has at least one field by checking its count.

**What the issue was:**
I wrote:
```xs
precondition ($input.data|count > 0) {
```

But XanoScript requires parentheses around the filtered expression:
```xs
precondition (($input.data|count) > 0) {
```

**Why it was an issue:**
The error message was:
```
An expression should be wrapped in parentheses when combining filters and tests
```

While helpful, I had to guess the exact placement. The documentation mentions this but it's easy to miss:
> "When concatenating strings that use filters, wrap each filtered expression in parentheses"

**Potential solution (if known):**
Make the parser smarter to handle this case automatically, or provide a more specific error with the corrected code example.

---

## [2025-02-16 18:55 PST] - Ternary Operator Not Supported

**What I was trying to do:**
Use a ternary operator to select between two values based on a condition:
```xs
var $api_key { 
  value = ($supabase_service_key != null && $supabase_service_key != "") 
          ? $supabase_service_key 
          : $supabase_anon_key 
}
```

**What the issue was:**
The ternary operator `? :` is not supported in XanoScript. I had to use a conditional block instead.

**Why it was an issue:**
Ternary operators are standard in most programming languages. Having to restructure to use a conditional block is verbose:
```xs
var $api_key { value = $supabase_service_key }
conditional {
  if ($supabase_service_key == null || $supabase_service_key == "") {
    var $api_key { value = $supabase_anon_key }
  }
}
```

**Potential solution (if known):**
Add support for the ternary operator or the nullish coalescing operator `??` for more complex conditional expressions.

---

## [2025-02-16 18:58 PST] - Conditional Block Cannot Be Used in Variable Value

**What I was trying to do:**
Use a conditional block inline to set a variable value:
```xs
var $prefer_value { 
  value = conditional {
    if ($input.conflict_resolution == "ignore") { "resolution=ignore-duplicates" }
    elseif ($input.conflict_resolution == "update") { "resolution=merge-duplicates" }
    else { "return=representation" }
  }
}
```

**What the issue was:**
Despite the documentation showing this pattern, it resulted in:
```
Expecting: Expected an expression but found: 'conditional'
```

**Why it was an issue:**
The documentation explicitly shows this as a valid pattern:
```xs
var $tier_limit {
  value = conditional {
    if ($auth.tier == "premium") { 1000 }
    elseif ($auth.tier == "pro") { 500 }
    else { 100 }
  }
}
```

But it doesn't work in practice. I had to restructure using separate conditional blocks with explicit variable assignments.

**Potential solution (if known):**
Either fix the parser to support this pattern, or update the documentation to remove this example if it's not actually supported.

---

## [2025-02-16 19:00 PST] - AWS SES Authentication Complexity

**What I was trying to do:**
Originally, I attempted to implement AWS SES which requires AWS Signature Version 4 authentication.

**What the issue was:**
AWS SES uses AWS SigV4 which requires:
1. Creating a canonical request
2. Generating a string to sign
3. Calculating HMAC-SHA256 signatures
4. Building the Authorization header with multiple components

I attempted to use:
```xs
api.request {
  // ...
  aws_auth = {
    access_key: $aws_access_key_id,
    secret_key: $aws_secret_access_key,
    region: $aws_region,
    service: "ses"
  }
}
```

But `aws_auth` is not a valid parameter for `api.request`.

**Why it was an issue:**
Implementing AWS SigV4 manually in XanoScript would require:
- Multiple HMAC-SHA256 operations
- Date/time formatting in specific formats
- String concatenation and encoding
- Complex header construction

This is extremely verbose and error-prone without built-in support.

**Potential solution (if known):**
Add built-in AWS authentication support:
```xs
api.request {
  url = "https://email.us-east-1.amazonaws.com/v2/email/outbound-emails"
  method = "POST"
  aws_v4_auth = {
    access_key: $env.AWS_ACCESS_KEY_ID,
    secret_key: $env.AWS_SECRET_ACCESS_KEY,
    region: "us-east-1",
    service: "ses"
  }
}
```

---

## [2025-02-16 19:05 PST] - Documentation Topic Discovery

**What I was trying to do:**
Find documentation about how to structure a run job and write functions.

**What the issue was:**
I had to make multiple separate calls to `xanoscript_docs` to get complete information:
1. First call for general documentation
2. Second call for `run` topic
3. Third call for `functions` topic
4. Fourth call for `integrations` topic

Each call returned a large document, and I had to piece together how these concepts work together.

**Why it was an issue:**
It was inefficient and required multiple round-trips. I wasn't sure which topic would contain the information I needed. The `api.request` documentation was in `integrations`, not `functions` or `apis`.

**Potential solution (if known):**
- Add a "quickstart" or "run-job-example" topic that includes a complete, working example
- Add cross-references at the end of each doc: "Related topics: functions, integrations, apis"
- Consider adding a search or index feature to find topics by keyword

---

## [2025-02-16 19:10 PST] - Input Block Default Values with $env

**What I was trying to do:**
Set a default value for an input parameter using an environment variable.

**What the issue was:**
The documentation clearly states:
> **Important:** `$env` variables cannot be used in `run.job` or `run.service` input blocks. Input values must be constants.

```xs
// ❌ Invalid - $env not allowed in run.job input
run.job "my_job" {
  input {
    text api_key = $env.API_KEY    // Error!
  }
}
```

**Why it was an issue:**
This is a reasonable limitation (security/parsing), but it's documented as a limitation rather than being obvious from the syntax. I didn't hit this error but noticed it while reading the docs.

**Potential solution (if known):**
The documentation is clear about this. Keep the good documentation and perhaps add a linter warning if someone tries to use $env in an input block.

---

## Summary

Overall, XanoScript is powerful but has some friction points:

1. **Syntax quirks**: Parentheses requirements around filtered expressions, no ternary operator
2. **Documentation gaps**: Hard to find the right topic, some documented patterns don't work
3. **AWS integration**: Lack of built-in AWS SigV4 auth makes AWS services difficult to use
4. **MCP tool syntax**: Unclear how to pass parameters to validation tools

The validation tool was extremely helpful once I figured out the syntax. The error messages are generally good and often include suggestions for fixes.

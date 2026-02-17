# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 11:20 PST] - Index Type Documentation Issue

**What I was trying to do:**
Create a table with indexes for faster querying on commonly searched fields (sent_at, to_email, status).

**What the issue was:**
I used `type: "index"` for the index definitions based on general database knowledge, but XanoScript requires specific index types like `btree`, `gin`, etc. The error message was:
```
Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`
```

**Why it was an issue:**
The xanoscript_docs for tables section didn't clearly show what the valid index types are. I had to guess and then get validation errors to find the correct values.

**Potential solution:**
Add a clear table in the tables documentation showing all valid index types with descriptions of when to use each:
- `primary` - Primary key
- `btree` - Standard B-tree index for equality/range queries
- `btree|unique` - Unique constraint
- `gin` - Generalized Inverted Index (for JSON/array search)
- `search` - Full-text search
- `vector` - Vector similarity search

---

## [2025-02-17 11:18 PST] - AWS SES Authentication Complexity

**What I was trying to do:**
Implement AWS SES API integration using proper AWS Signature Version 4 authentication.

**What the issue was:**
The XanoScript documentation doesn't have examples for AWS Signature V4, which is required for AWS API calls. AWS SES requires complex request signing with:
- Timestamp-based signatures
- HMAC-SHA256 hashing
- Canonical request construction
- Multiple header values

The `api.request` function only supports basic headers, not the dynamic signature generation needed for AWS.

**Why it was an issue:**
I had to simplify the authentication to a basic header approach which won't actually work with AWS SES. The run job as written uses a placeholder auth method that AWS will reject.

**Potential solution:**
Add a built-in `cloud.aws.ses.send_email` operation similar to other cloud integrations, or provide a `util.aws_sign` helper function that generates proper AWS Signature V4 headers given the access key, secret, region, and service.

---

## [2025-02-17 11:15 PST] - String Concatenation with Filters

**What I was trying to do:**
Build email addresses with names like `"Name <email@example.com>"` using the `~` concatenation operator.

**What the issue was:**
Initially I wrote expressions like `$input.from_name ~ " <" ~ $input.from_email ~ ">"` without realizing that complex concatenations need to be handled carefully with null/empty values.

**Why it was an issue:**
The quickstart docs mention using parentheses around filters in expressions, but it's easy to forget when building complex strings. The error messages for parse errors could be clearer about where the issue is.

**Potential solution:**
Add more examples of complex string building patterns in the quickstart guide, especially for:
- Building email addresses with optional display names
- Constructing URLs with query parameters
- Formatting multi-part messages

---

## [2025-02-17 11:17 PST] - Object Manipulation with set Filter

**What I was trying to do:**
Dynamically build the AWS SES request payload by conditionally adding optional fields (HTML body, reply-to addresses).

**What the issue was:**
The `set` filter syntax for nested objects is confusing. I needed to write:
```xs
$value = $ses_payload|set:"Content"|set:"Simple"|set:"Body"|set:"Text":$text_body
```

This chained filter approach is hard to read and error-prone.

**Why it was an issue:**
The documentation for the `set` filter doesn't show examples of nested object manipulation. I had to guess the chaining syntax.

**Potential solution:**
- Add clear examples of nested object manipulation
- Consider adding a `set_deep` filter that accepts a path like `"Content.Simple.Body.Text"`
- Or allow object literal manipulation with variable keys

---

## General Feedback

### Positive
- The MCP validation tool is very helpful and provides clear error messages with line numbers
- The documentation structure with `xanoscript_docs` topics is well organized
- The run.job/run.service constructs are intuitive

### Suggestions
1. **More cloud integration examples** - AWS, GCP, Azure integrations are common but complex
2. **Built-in auth helpers** - OAuth2, AWS Signature, JWT signing helpers
3. **Better null-safety** - The `??` operator and `first_notnull` filter are good, but more patterns for optional field handling would help
4. **Schema validation errors** - When table schema is invalid, show the line in context with surrounding lines

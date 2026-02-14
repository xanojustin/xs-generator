# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 06:15 PST] - MCP Tool Parameter Naming Confusion

**What I was trying to do:**
Validate XanoScript files using the MCP validate_xanoscript tool.

**What the issue was:**
The tool expects a `code` parameter, but I initially tried using `script` (common convention for file content). The error message just said "'code' parameter is required" without helpful context.

**Why it was an issue:**
Had to guess the correct parameter name by trial and error. A more descriptive error or documentation would help.

**Potential solution:**
- Add tool schema documentation showing parameter names
- Include examples in the MCP tool description
- Accept common aliases like `script`, `content`, `source`

---

## [2026-02-14 06:18 PST] - Error Type Constraints Not Documented

**What I was trying to do:**
Create preconditions for environment variable validation with a custom error_type "configuration".

**What the issue was:**
Validation failed with: "Expected value of `error_type` to be one of `standard`, `notfound`, `accessdenied`, `toomanyrequests`, `unauthorized`, `badrequest`, `inputerror`"

**Why it was an issue:**
The documentation examples show error_type values but don't explicitly list all valid options. "configuration" seemed like a logical choice for missing env vars but isn't allowed.

**Potential solution:**
- Add a table of valid error_type values to the documentation
- Explain when to use each error type
- Consider adding "configuration" or "internal" for env/config issues

---

## [2026-02-14 06:20 PST] - Hash Filter Not Available

**What I was trying to do:**
Generate SHA256 hash for AWS Signature V4 authentication using `$content|hash:"sha256"`.

**What the issue was:**
The `hash` filter doesn't exist in XanoScript. Validation error: "Unknown filter function 'hash'".

**Why it was an issue:**
AWS S3 uploads require content hashing for proper authentication. Without this, I had to fall back to UNSIGNED-PAYLOAD which is less secure and may not work with all S3 configurations.

**Potential solution:**
- Add `hash` filter supporting sha256, sha1, md5 algorithms
- Document any existing crypto/hash capabilities
- Consider adding HMAC support for AWS-style signatures

---

## [2026-02-14 06:22 PST] - api.request Uses 'params' Not 'body'

**What I was trying to do:**
Make a PUT request to S3 with file content in the request body.

**What the issue was:**
Used `body = $input.file_content` but validation failed: "The argument 'body' is not valid in this context". Had to use `params` instead.

**Why it was an issue:**
Most HTTP libraries use `body` for request payload. Using `params` for PUT/POST body is counter-intuitive. The quickstart docs do show this but it's easy to miss.

**Potential solution:**
- Accept both `body` and `params` as aliases
- Add clearer documentation highlighting this distinction
- Show examples for GET (params as query string) vs POST/PUT (params as body)

---

## [2026-02-14 06:24 PST] - Reserved Variable Names Not Documented

**What I was trying to do:**
Declare a variable named `$response` to build the function output.

**What the issue was:**
Validation failed: "'$response' is a reserved variable name and should not be used as a variable." I then tried `$output` which was also reserved.

**Why it was an issue:**
The documentation mentions `$response` is reserved in one place but doesn't provide a complete list. Had to guess multiple names before finding one that worked (`$api_response`).

**Potential solution:**
- Provide a complete list of reserved variable names
- Explain the naming conventions (why $output is reserved but $api_response isn't)
- Suggest naming patterns that are safe to use

---

## [2026-02-14 06:25 PST] - Index Type Values Not Documented

**What I was trying to do:**
Create table indexes for the upload_log table.

**What the issue was:**
Used `type: "index"` but validation failed: "Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`"

**Why it was an issue:**
The documentation examples don't cover all index types. "index" seems like a reasonable generic type but isn't valid.

**Potential solution:**
- Add a table of valid index types to the tables documentation
- Explain when to use each type (btree for general, gin for JSON, etc.)
- Show example table definitions with different index types

---

## [2026-02-14 06:26 PST] - Timestamp Format String Escaping

**What I was trying to do:**
Format a timestamp in AWS ISO format: `20230214T123000Z` (with T separator).

**What the issue was:**
Tried using `"Ymd\\THis\\Z"` with backslash escaping but got a syntax error. Changed to `"YmdTHisZ"` which works but doesn't clearly separate date/time visually.

**Why it was an issue:**
Unsure if escaping is supported or what the correct syntax would be. The documentation doesn't cover format string escaping rules.

**Potential solution:**
- Document format string escaping rules
- Provide examples of complex format strings
- Consider predefined format constants for common formats (ISO8601, RFC2822, etc.)

---

## Summary

The Xano MCP generally works well for validation, but the main pain points are:
1. Missing comprehensive documentation for valid enum values (error_type, index type)
2. Missing filter functions (hash) for common crypto operations
3. Reserved variable names list is incomplete
4. Parameter naming in api.request is unintuitive (params vs body)

The validation tool catches errors quickly, which is great! Most issues were resolved within minutes once the error message pointed in the right direction.

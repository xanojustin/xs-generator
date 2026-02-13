# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-13 09:15 PST - MCP Tool Naming and Discovery Issues

**What I was trying to do:**
Call the `validate_xanoscript` tool to validate my XanoScript code.

**What the issue was:**
The MCP server name was confusing. `mcporter list` showed:
- `xano-developer` (4 tools) 
- `xano` (6 tools)

I initially tried calling `xano.validate_xanoscript` but got "Unknown MCP server 'xano'". Then tried `xano-developer.validate_xanoscript` and same error.

Only when calling from the workspace directory (`/Users/justinalbrecht/.openclaw/workspace`) did the calls work. The mcporter was loading servers from `./config/mcporter.json` relative to CWD, not from a global config.

**Why it was an issue:**
This was very confusing because the server was clearly listed by `mcporter list` but calls failed with "Unknown MCP server". The error message didn't indicate it was a CWD/config path issue.

**Potential solution:**
- Better error messages indicating which config file was searched
- A warning when servers are found in other locations but not the current CWD
- Or have mcporter search parent directories for config files like git does

---

## 2026-02-13 09:18 PST - validate_xanoscript Parameter Format

**What I was trying to do:**
Pass the XanoScript code to the validate_xanoscript tool.

**What the issue was:**
The tool requires a `code` parameter. I tried multiple approaches:
1. `mcporter call xano-developer.validate_xanoscript "code:$CODE"` - parameter not recognized
2. Passing file path as JSON - didn't work
3. `mcporter call xano-developer.validate_xanoscript --args @file.json` - @ syntax not supported

The only way that worked was: `mcporter call xano-developer.validate_xanoscript --args "$JSON"` where JSON was created via `jq -Rs '{code: .}'`

**Why it was an issue:**
This was very unintuitive. The mcporter CLI help shows examples like `mcporter call linear.list_issues limit:5` but passing a large multi-line string as a key=value argument doesn't work well.

**Potential solution:**
- Support reading from stdin for code parameter: `cat file.xs | mcporter call xano-developer.validate_xanoscript --stdin`
- Support file path directly: `mcporter call xano-developer.validate_xanoscript file:./run.xs`
- Better documentation/examples for multi-line string arguments

---

## 2026-02-13 09:22 PST - error_type Validation Not Documented

**What I was trying to do:**
Create meaningful error types for different validation failures (missing config vs missing input).

**What the issue was:**
I used `error_type = "configuration"` for missing environment variables, but the validator rejected it saying only these are allowed: `standard`, `notfound`, `accessdenied`, `toomanyrequests`, `unauthorized`, `badrequest`, `inputerror`.

This list wasn't documented in the xanoscript_docs output I received.

**Why it was an issue:**
I wanted to distinguish between "user input error" and "server configuration error" but had to use `badrequest` for both, which is less precise.

**Potential solution:**
- Add a `configuration` error type for missing env vars
- Document the valid error_type values in the syntax or functions documentation

---

## 2026-02-13 09:24 PST - Missing `lower` Filter

**What I was trying to do:**
Lowercase the email address before computing MD5 hash (Mailchimp requires lowercase emails for subscriber hash).

**What the issue was:**
I tried using `|lower` filter like: `$input.subscriber_email|md5|lower` but got error: "Unknown filter function 'lower'"

The available filters weren't documented, so I had to remove the lowercasing.

**Why it was an issue:**
This could cause issues with Mailchimp's subscriber hash which expects lowercase emails. Without knowing what filters exist, I'm guessing at functionality.

**Potential solution:**
- Document all available filters in the syntax documentation
- Add a `lower` or `lowercase` filter (very commonly needed)

---

## 2026-02-13 09:25 PST - `condition` Block Syntax Unknown

**What I was trying to do:**
Conditionally add merge fields to the request body only if first_name/last_name were provided.

**What the issue was:**
I tried using `condition ($variable) { ... }` blocks but got error: "Expecting --> } <-- but found --> 'condition'"

This syntax isn't documented in the examples I saw. I had to rewrite using ternary operators which is less readable for complex conditional logic.

**Why it was an issue:**
The Stripe example didn't have conditionals, so I had no reference. Without documentation for control flow, I'm guessing at syntax.

**Potential solution:**
- Document conditional/control flow syntax in the functions or syntax docs
- Provide examples showing if/else or condition blocks

---

## 2026-02-13 09:27 PST - `api.request` Uses `params` Not `body`

**What I was trying to do:**
Send a JSON body in a PUT request to Mailchimp API.

**What the issue was:**
I used `body = $request_body` in the `api.request` block but got error: "The argument 'body' is not valid in this context" and "Expecting: Expected a null"

Looking at the Stripe example, it uses `params` even for POST requests with JSON bodies. This is confusing naming since HTTP typically uses "body" for POST/PUT payloads.

**Why it was an issue:**
The naming is inconsistent with standard HTTP terminology. `params` usually means URL query parameters, not request body.

**Potential solution:**
- Support both `body` (for JSON payloads) and `params` (for form data)
- Or at least document that `params` is used for all request payloads

---

## General Feedback

**Positive:**
- The validation tool is very helpful with specific line/column error messages
- Once I figured out the mcporter syntax, validation was fast
- The Stripe example was a good reference for basic structure

**Documentation Gaps:**
1. No list of available filters (lower, upper, etc.)
2. No documentation on conditional/if statements
3. No list of valid error_type values
4. api.request options not fully documented (when to use params vs other options)
5. How to reassign variables (I used `var $name` multiple times which seemed to work but unsure if it's the right pattern)

**MCP Issues:**
1. Config file location discovery is difficult
2. No clear way to pass multi-line strings as parameters
3. Error messages don't help identify CWD/config issues

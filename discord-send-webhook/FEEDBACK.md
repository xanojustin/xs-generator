# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 16:20 PST] - MCP Parameter Passing Issues

**What I was trying to do:**
Validate XanoScript code using the MCP `validate_xanoscript` tool.

**What the issue was:**
The MCP tool kept returning "'code' parameter is required" despite passing JSON payloads. The correct format turned out to be:
```bash
mcporter call xano validate_xanoscript code='...code here...'
```

Not:
- `mcporter call xano validate_xanoscript '{"code": "..."}'`
- `mcporter call xano validate_xanoscript --file ...`
- Piping JSON from stdin

**Why it was an issue:**
The documentation didn't clearly show the correct CLI format. The tool signature shows `code: string` but the exact command-line invocation format wasn't obvious. Multiple failed attempts consumed significant time.

**Potential solution:**
Add clear CLI examples in the MCP documentation showing the `key=value` format for positional arguments.

---

## [2025-02-13 16:25 PST] - Unknown Filter `to_integer`

**What I was trying to do:**
Convert a string color value to an integer for Discord's embed color field.

**What the issue was:**
I assumed the filter was `to_integer` (logical naming), but the actual filter name is `to_int`. The validator correctly caught this as "Unknown filter function 'to_integer'".

**Why it was an issue:**
The naming inconsistency (integer vs int) is confusing. Many languages use `toInt()`, `parseInt()`, `to_integer`, etc. It's not obvious which one XanoScript uses.

**Potential solution:**
Document common filter naming patterns or provide aliases for common variations (e.g., both `to_int` and `to_integer` working).

---

## [2025-02-13 16:25 PST] - Invalid `util.date_now` Syntax

**What I was trying to do:**
Get the current timestamp for Discord embeds.

**What the issue was:**
I used `util.date_now` thinking it was a utility function, but this syntax doesn't exist. The correct approach is `"now"|to_timestamp` followed by `|format_timestamp:"...":"UTC"`.

**Why it was an issue:**
The documentation mentions `util.send_email` in the integrations section, leading me to believe there was a `util` namespace with date functions. There's no clear reference for "how to get current timestamp" in the quickstart.

**Potential solution:**
Add a "Common Patterns" section for date/time operations in the quickstart docs, including "get current timestamp" and "format current date".

---

## [2025-02-13 16:22 PST] - Invalid `configerror` Error Type

**What I was trying to do:**
Use a descriptive error type for missing environment variable configuration.

**What the issue was:**
`configerror` is not a valid error_type. Valid types are: `standard`, `notfound`, `accessdenied`, `toomanyrequests`, `unauthorized`, `badrequest`, `inputerror`.

**Why it was an issue:**
The error message was clear about what types ARE valid, but it would be helpful to have a "configerror" or "configuration" type for missing env vars, as this is a common use case.

**Potential solution:**
Consider adding a `configuration` or `config` error type specifically for missing/invalid environment variables and configuration issues.

---

## [2025-02-13 16:18 PST] - MCP Server Connection Timeout Between Commands

**What I was trying to do:**
Run multiple validation commands in sequence.

**What the issue was:**
The MCP server connection would timeout between commands, requiring re-listing servers before each call. Error was: "Unknown MCP server 'xano'" even though it was listed moments before.

**Why it was an issue:**
This made the development workflow slow - I couldn't create a simple validation script that runs multiple checks.

**Potential solution:**
Increase the default keepalive timeout, or document that connections are short-lived and recommend batching operations.

---

## [2025-02-13 16:15 PST] - Multi-line String Escaping Challenges

**What I was trying to do:**
Pass multi-line XanoScript code to the validator via command line.

**What the issue was:**
Shell escaping of quotes, newlines, and special characters made it difficult to validate files directly. Had to inline the code in the command which was error-prone.

**Why it was an issue:**
No built-in `--file` or stdin support meant manually escaping every validation attempt.

**Potential solution:**
Add a `--file` parameter or stdin support to `validate_xanoscript` so we can do:
```bash
mcporter call xano validate_xanoscript --file ./run.xs
# or
cat run.xs | mcporter call xano validate_xanoscript --stdin
```

---

## Summary

Overall the MCP tool works well for validation, but the developer experience could be improved with:
1. Better CLI documentation with concrete examples
2. Stdin/file support for the validator
3. More consistent filter naming
4. Additional error types for common scenarios
5. A "Common Patterns" quick reference for things like "current timestamp"

The validation feedback is excellent - clear line/column positions and helpful error messages made fixing issues straightforward once I understood the syntax.
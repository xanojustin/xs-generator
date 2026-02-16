# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 13:48 PST] - MCP Tool Invocation Syntax Confusion

**What I was trying to do:**
Call the `validate_xanoscript` tool using mcporter to validate XanoScript files.

**What the issue was:**
The documentation shows the tool signature but doesn't clearly explain the CLI invocation syntax. I tried multiple formats that all failed:
- `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` - JSON format
- `mcporter call xano.validate_xanoscript '{"file_path": "/path"}'` - Dot notation with JSON
- Various parameter passing attempts

Only `mcporter call xano.validate_xanoscript "file_path=/path/to/file"` worked.

**Why it was an issue:**
Wasted significant time trying different invocation patterns. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was misleading because I WAS passing these parameters, just in the wrong format.

**Potential solution:**
Add clear CLI examples in the tool description showing the exact mcporter call syntax.

---

## [2026-02-16 13:50 PST] - run.job Does Not Support Description Field

**What I was trying to do:**
Add a `description` field to the `run.job` block similar to how `function` blocks support it.

**What the issue was:**
```xs
run.job "Send Email via Resend" {
  description = "Send a transactional email using the Resend API"
  main = { ... }
}
```
This fails validation with: "The argument 'description' is not valid in this context"

**Why it was an issue:**
The xanoscript_docs show `description` as a common field across constructs, so I assumed it worked for run.job. Had to remove it after validation failure.

**Potential solution:**
Document which constructs support `description` and which don't. Or better, support descriptions on all constructs for consistency.

---

## [2026-02-16 13:52 PST] - Conditional Logic Syntax Unclear

**What I was trying to do:**
Add conditional logic inside a `stack` block to conditionally add fields to an object.

**What the issue was:**
Tried using `if` statement directly inside stack:
```xs
stack {
  if ($input.cc_emails != null && $input.cc_emails|count > 0) {
    var $payload { value = $payload|set:"cc":$input.cc_emails }
  }
}
```
This fails with "Expecting --> } <-- but found --> 'if'".

**Why it was an issue:**
Had to read an existing working implementation (stripe-create-charge) to discover that `conditional { if (...) { } }` is the correct syntax. The quickstart docs mention this but it's buried in examples.

**Potential solution:**
Make the `conditional` wrapper requirement more prominent in the quickstart. Perhaps add a "Common Patterns" section specifically for conditionals.

---

## [2026-02-16 13:55 PST] - Filter Expression Parentheses Required

**What I was trying to do:**
Check if an array has items using `$input.cc_emails|count > 0`.

**What the issue was:**
```xs
if ($input.cc_emails != null && $input.cc_emails|count > 0) {
```
This fails validation. Must wrap filter expressions in parentheses:
```xs
if (($input.cc_emails != null) && (($input.cc_emails|count) > 0)) {
```

**Why it was an issue:**
The error message doesn't clearly indicate that parentheses are needed around filter expressions. Had to find this in the "Common Mistakes" section after failing validation multiple times.

**Potential solution:**
The validator could provide a more helpful error message like "Did you mean to wrap the filter expression in parentheses?" when detecting filter syntax in comparisons.

---

## [2026-02-16 13:58 PST] - Array Literal Syntax in Object Values

**What I was trying to do:**
Create an object with an array value for the `to` field:
```xs
var $payload {
  value = {
    from: $from_field,
    to: [$input.to_email],
    subject: $input.subject
  }
}
```

**What the issue was:**
Initially tried using commas between object properties (from JavaScript habit) and also wasn't sure about array literal syntax.

**Why it was an issue:**
The docs show object syntax uses `:` not `=`, but array syntax examples are sparse. Had to trial-and-error to confirm `[item1, item2]` works.

**Potential solution:**
Add a clear "Object and Array Literal Syntax" section to quickstart showing complete examples.

---

## [2026-02-16 14:00 PST] - Headers Array Syntax

**What I was trying to do:**
Pass multiple HTTP headers in the `api.request` block.

**What the issue was:**
```xs
headers = [
  "Content-Type: application/json",
  "Authorization: Bearer " ~ $api_key
]
```
The array items need to be on separate lines without commas, but this isn't immediately obvious.

**Why it was an issue:**
JavaScript muscle memory wants commas between array items. The docs show examples but don't explicitly state "no commas needed between array items in XanoScript".

**Potential solution:**
Add a note in the api.request documentation explicitly stating that array items don't need commas.

---

## Summary

Overall, the Xano MCP validation tool works well once you figure out the invocation syntax. The main friction points were:

1. **CLI invocation format** - Needs clearer examples
2. **Inconsistent field support** - Description works on function but not run.job
3. **Conditional syntax** - The `conditional {}` wrapper is non-obvious
4. **Filter parentheses** - Easy to forget, hard error to diagnose
5. **Array/object syntax** - Could use more explicit documentation

The validator is helpful and catches errors early. With better error messages and more explicit syntax documentation, the DX would be significantly improved.

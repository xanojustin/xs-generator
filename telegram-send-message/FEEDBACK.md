# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 22:20 PST] - Boolean Type Name Confusion

**What I was trying to do:**
Create a function with a boolean input parameter for `disable_notification`.

**What the issue was:**
I initially used `boolean disable_notification?=false` but the validator reported:
```
[Line 7, Column 5] Expecting --> } <-- but found --> 'boolean'
```

The error message was confusing - it made me think there was a syntax error with braces, not with the type name itself.

**Why it was an issue:**
The error didn't clearly indicate that `boolean` was not a valid type name. I had to consult the types documentation to discover the correct type is `bool` (not `boolean`).

**Potential solution:**
The validator could provide a more helpful error message like "Unknown type 'boolean'. Did you mean 'bool'?" Similar to how TypeScript or other languages suggest corrections.

---

## [2025-02-14 22:22 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Validate input by checking if a trimmed string is not empty: `$input.chat_id|trim != ""`

**What the issue was:**
The validator reported:
```
An expression should be wrapped in parentheses when combining filters and tests
```

I had to change `$input.chat_id|trim != ""` to `($input.chat_id|trim) != ""`.

**Why it was an issue:**
This requirement wasn't immediately obvious from the error message. The documentation mentions it in the syntax section but it's easy to miss. The error occurred on lines using `|trim` filter in comparisons.

**Potential solution:**
The syntax documentation could emphasize this more prominently, or the error message could show the corrected code example: "Wrap the filtered expression in parentheses: ($input.chat_id|trim) != ''"

---

## [2025-02-14 22:23 PST] - Reserved Variable Name `$response`

**What I was trying to do:**
Create a variable named `$response` to hold the API response data before returning it.

**What the issue was:**
The validator reported:
```
'$response' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
This was unexpected - I didn't know `$response` was reserved. The documentation doesn't clearly list reserved variable names. I had to rename it to `$api_response`.

**Potential solution:**
Add a section to the documentation listing all reserved variable names (`$response`, `$input`, `$env`, `$db`, etc.) so developers know what names to avoid.

---

## [2025-02-14 22:24 PST] - Missing `default` Filter

**What I was trying to do:**
Provide a fallback value for potentially null fields using the `default` filter:
```xs
$result.description|default:"Unknown error"
```

**What the issue was:**
The validator reported:
```
Unknown filter function 'default'
```

**Why it was an issue:**
Many template languages (Twig, Jinja2, Liquid, etc.) have a `default` filter for providing fallback values. I assumed XanoScript would have one too. I had to rewrite the logic using conditional blocks instead.

**Potential solution:**
Either:
1. Add a `default` filter for consistency with other template languages
2. Document the recommended alternative pattern (using conditional blocks with null checks)
3. List available filters in the quick reference more explicitly

The documentation mentions "There is no `default` filter" but it's buried in the syntax quick reference. It could be more prominent.

---

## [2025-02-14 22:25 PST] - Documentation Organization

**What I was trying to do:**
Find all the information I needed to write a valid XanoScript function.

**What the issue was:**
The documentation is split across multiple topics (`functions`, `types`, `syntax`, `integrations`, etc.) and I had to make multiple calls to `xanoscript_docs` to gather all the necessary information.

**Why it was an issue:**
It took several iterations to find:
- The correct type names (`bool` not `boolean`)
- Filter expression syntax (parentheses requirement)
- Reserved variable names
- How to make HTTP requests (`api.request`)
- Error handling patterns

**Potential solution:**
Consider providing a "complete example" documentation that shows a real-world function with all common patterns:
- Input validation
- HTTP requests
- Error handling
- Response construction

This would serve as a comprehensive reference in one place.

---

## [2025-02-14 22:26 PST] - MCP Tool Output Format

**What I was trying to do:**
Call the validate_xanoscript tool programmatically to check my code.

**What the issue was:**
The mcporter CLI returns JSON output but the actual validation message is inside a `content` array with text objects. This made parsing slightly more complex than expected.

**Why it was an issue:**
Example output structure:
```json
{
  "content": [
    {
      "type": "text",
      "text": "Found X error(s): ..."
    }
  ],
  "isError": true
}
```

**Potential solution:**
This is minor, but a flatter response structure or consistent error format would make scripting easier.

---

## Summary

Overall the Xano MCP and XanoScript validation worked well. The main pain points were:

1. **Learning curve on syntax details** - Parentheses for filters, reserved names, available types
2. **Error messages could be more helpful** - Suggest corrections, show examples
3. **Documentation could use a comprehensive example** - One doc showing all common patterns

The validator caught real issues that would have caused runtime errors, which is great! Once I understood the patterns, writing valid XanoScript was straightforward.

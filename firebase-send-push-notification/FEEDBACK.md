# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 23:45 PST] - Optional Parameter Syntax Confusion

**What I was trying to do:**
Define optional input parameters in a function using the syntax I thought was correct based on reading the documentation.

**What the issue was:**
I initially wrote:
```xs
input {
  text? image_url { description = "..." }
  object? data { description = "..." }
}
```

This caused a parser error: `Expecting token of type --> Identifier <-- but found --> '?' <--`

I then tried `text image_url?` without a description block, but got: `Expecting --> { <-- but found --> '
' <--`

**Why it was an issue:**
The documentation shows `int age? filters=min:0` as an example, but doesn't clearly explain that the `?` goes AFTER the variable name, not the type. Also, it wasn't clear whether optional parameters could have description blocks or if they needed filters.

**Potential solution (if known):**
The `types` documentation eventually clarified the correct syntax:
```xs
text image_url? filters=trim {
  description = "Optional image URL for notification"
}
```

But this was hard to find. The quickstart and functions docs should have a clearer example showing optional parameters with descriptions.

---

## [2026-02-13 23:50 PST] - Missing `default` Filter

**What I was trying to do:**
Provide a fallback value when accessing a potentially null object property.

**What the issue was:**
I wrote:
```xs
var $message_id {
  value = $api_result.response.result.name|default:""
}
```

This failed with: `Unknown filter function 'default'`

**Why it was an issue:**
Many programming languages and template engines use `default` as a filter for providing fallback values. The XanoScript documentation mentions `first_notnull` in the quickstart "Common Mistakes" section, but it's easy to miss.

**Potential solution (if known):**
The correct filter is `first_notnull`:
```xs
var $message_id {
  value = $api_result.response.result.name|first_notnull:""
}
```

The quickstart documentation does mention this, but having `default` as an alias for `first_notnull` would help developers coming from other languages.

---

## [2026-02-13 23:52 PST] - Reserved Variable Name `$response`

**What I was trying to do:**
Create a variable to hold the response data before returning it.

**What the issue was:**
I named my variable `$response`:
```xs
var $response {
  value = { success: true, ... }
}
response = $response
```

This failed with: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:**
The documentation does mention this in the quickstart "Common Mistakes" section, but it's a natural instinct to name your response variable `$response`. The error message was clear, which helped.

**Potential solution (if known):**
The documentation covers this well, but perhaps the validator could suggest alternative names like `$result` in the error message.

---

## [2026-02-13 23:48 PST] - Validate Tool Requires Code Content, Not File Path

**What I was trying to do:**
Validate my .xs files using the MCP `validate_xanoscript` tool.

**What the issue was:**
I initially tried:
```bash
mcporter call xano validate_xanoscript --args '{"file": "/path/to/file.xs"}'
```

This failed with: `Error: 'code' parameter is required`

**Why it was an issue:**
I expected the tool to accept a file path and read the content itself. Having to pipe file content through jq and pass it as a JSON string is cumbersome:
```bash
mcporter call xano validate_xanoscript --args "$(cat file.xs | jq -Rs '{code: .}')"
```

**Potential solution (if known):**
The tool should accept either:
1. A `file` parameter with a path to the file
2. A `code` parameter with the actual code content

This would make validation much easier during development.

---

## [2026-02-13 23:55 PST] - Documentation Organization

**What I was trying to do:**
Find the correct syntax for optional parameters.

**What the issue was:**
The information about optional parameters was spread across multiple documentation topics:
- `functions` topic mentioned `int age? filters=min:0`
- `types` topic had the complete picture with `text optional_field?`
- `quickstart` mentioned common mistakes but not optional parameters specifically

**Why it was an issue:**
I had to read through 3 different documentation topics to piece together the correct syntax. This slowed down development significantly.

**Potential solution (if known):**
Consider adding a "Common Patterns" or "Cheat Sheet" topic that shows:
1. Required vs optional parameters
2. Nullable vs optional
3. Default values
4. Common input patterns

All in one place with clear before/after examples.

---

## [2026-02-13 23:58 PST] - `object` vs `json` Type Confusion

**What I was trying to do:**
Define an optional parameter for a JSON data payload.

**What the issue was:**
I initially used `object` type:
```xs
object data?
```

But after reading the `types` documentation more carefully, I saw that `json` is the recommended type for "Any JSON structure" while `object` is specifically for "Nested Schema" with a defined schema block.

**Why it was an issue:**
The distinction between `object` and `json` isn't immediately clear. I was trying to use `object` without a schema definition, which might have worked but felt wrong.

**Potential solution (if known):**
The documentation is clear on this in the `types` topic, but it would help if the `functions` quickstart examples showed when to use `json` vs `object`.

---

## General Feedback

**What worked well:**
1. The `xanoscript_docs` tool is helpful for getting detailed documentation
2. Error messages from the validator are generally clear and point to specific line numbers
3. Once I understood the syntax, writing XanoScript felt natural and consistent

**Areas for improvement:**
1. The `validate_xanoscript` tool should accept file paths
2. A single "cheat sheet" topic with common patterns would be invaluable
3. Some filters like `default` could have aliases for familiarity
4. Optional parameter syntax could be more prominently featured in the quickstart

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 09:17 PST] - JSON Parameter Parsing Issues with mcporter

**What I was trying to do:**
Call the `validate_xanoscript` tool via mcporter to validate my XanoScript files.

**What the issue was:**
The mcporter CLI tool does not accept JSON-formatted parameters as expected. When I tried to pass parameters using JSON syntax like:
- `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'`
- `mcporter call xano validate_xanoscript '{"directory": "/path/to/dir"}'`

The MCP server returned: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

This suggests the JSON was not being parsed correctly by mcporter or was being sent as a single string argument rather than parsed parameters.

**Why it was an issue:**
The MCP tool documentation shows the parameters as a JSON schema, which implies JSON should work. However, mcporter actually requires `key=value` or `key:value` flag-style syntax:
- `mcporter call xano validate_xanoscript file_path=/path/to/file.xs`

This was confusing because the documentation format (JSON schema) didn't match the actual CLI interface.

**Potential solution:**
- Update mcporter documentation to clearly show the flag-style syntax for the call command
- Or support both JSON and flag-style parameters in mcporter
- Add examples in the MCP tool descriptions showing the correct mcporter syntax

---

## [2025-02-18 09:18 PST] - Default Values in Input Blocks Not Supported

**What I was trying to do:**
Create an optional input parameter with a default value using:
```xs
text html_content { description = "HTML email content (optional)", default = "" }
```

**What the issue was:**
The XanoScript validator returned:
```
1. [Line 10, Column 72] The argument 'default' is not valid in this context
2. [Line 10, Column 72] Expected value of `default` to be `null`
```

This indicates that either:
1. The `default` property is not supported in input blocks at all, OR
2. The syntax for default values is different than expected

**Why it was an issue:**
I had to remove the default value and instead handle the "optional" nature of the parameter in the stack logic by checking if it's an empty string. This is more verbose than having native default value support.

**Potential solution:**
- Clarify in the documentation whether `default` is supported in input blocks
- If it is supported, document the correct syntax
- If not supported, provide a recommended pattern for handling optional parameters with defaults

---

## [2025-02-18 09:19 PST] - No 'set' Keyword for Object Mutation

**What I was trying to do:**
Modify an object's property after creation using:
```xs
set $message_with_html.HtmlPart = $input.html_content
```

**What the issue was:**
The validator returned: "Expecting --> } <-- but found --> 'set' <--"

This means `set` is not a valid keyword in XanoScript. I had to work around this by reconstructing the entire object with the new property included.

**Why it was an issue:**
I expected to be able to mutate object properties after creation, which is common in many languages. Instead, I had to create a new object with all the properties copied plus the new one:
```xs
var $message_with_html {
  value = {
    From: $message_payload.value.From,
    To: $message_payload.value.To,
    Subject: $message_payload.value.Subject,
    TextPart: $message_payload.value.TextPart,
    HtmlPart: $input.html_content
  }
}
```

This is more verbose and error-prone (if the original object changes, this code needs to be updated too).

**Potential solution:**
- If object mutation is intentionally not supported (immutability by design), document this clearly
- If it is supported, document the correct syntax for property assignment
- Consider adding a merge/update syntax like: `$obj|merge:{newProp: value}`

---

## [2025-02-18 09:20 PST] - Documentation Topic for 'run' Returns Index Instead of Specific Content

**What I was trying to do:**
Get specific documentation about run jobs and services by calling:
```
mcporter call xano xanoscript_docs topic=run
```

**What the issue was:**
The documentation returned the same index/overview page instead of specific content about run jobs. It showed the general documentation index with a list of topics, but not the actual content for the 'run' topic.

**Why it was an issue:**
I was expecting detailed documentation about run job syntax, configuration options, and examples. Instead, I only got the index which told me the 'run' topic exists but didn't provide the actual documentation content.

**Potential solution:**
- Ensure that topic-specific queries return the actual content for that topic
- If the content is the same as the index, consider removing 'run' from the topic list or adding a note that it redirects to the index

---

## General Observations

### Positive:
- The validation tool is very helpful and provides specific line/column error locations
- Error messages are generally clear and actionable
- The syntax is clean and readable once understood

### Areas for Improvement:
- More examples in the documentation showing common patterns
- Clearer distinction between what's valid in different contexts (input blocks vs stack blocks)
- Better documentation for the `mcporter call` command syntax vs the MCP tool parameter schema

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 15:47 PST] - Boolean Type Syntax

**What I was trying to do:**
Define a boolean input parameter in the function's input block.

**What the issue was:**
I initially used `boolean purge_everything?="false"` but the validator complained with "Expecting --> } <-- but found --> 'boolean' <--".

**Why it was an issue:**
The XanoScript type is `bool`, not `boolean`. Also, the default value for a boolean should be `true`/`false` without quotes, not `"true"`/`"false"` as strings.

**Potential solution (if known):**
The types documentation does mention `bool` in the table, but it could be more prominent. Maybe include a "Common Gotchas" section that highlights:
- `bool` not `boolean`
- `object` not `array`
- Default values for bools don't use quotes

---

## [2026-02-14 15:45 PST] - Input Block Description Syntax

**What I was trying to do:**
Write an input parameter with a filter and description on a single line.

**What the issue was:**
I wrote:
```xs
text zone_id filters=trim { description = "Cloudflare Zone ID" }
```

The parser failed with: "Expecting: expecting at least one iteration which starts with one of these possible Token sequences:: <[NewlineToken]> but found 'description'"

**Why it was an issue:**
The description block needs to be on its own lines, not on the same line as the type declaration. The correct format is:
```xs
text zone_id filters=trim {
  description = "Cloudflare Zone ID"
}
```

**Potential solution (if known):**
The documentation shows this correctly in examples, but the error message is confusing - it mentions "NewlineToken" which doesn't clearly indicate that the `{ description = ... }` block needs its own lines.

---

## [2026-02-14 15:50 PST] - Unknown Filter Function 'length'

**What I was trying to do:**
Check if an array has elements by using `|length` filter.

**What the issue was:**
The validator reported "Unknown filter function 'length'" on multiple lines where I used `$input.urls|length` and `$errors|length`.

**Why it was an issue:**
In many programming languages, `length` is the standard way to get array size. XanoScript uses `count` instead, which is mentioned in the syntax docs but easy to miss.

**Potential solution (if known):**
Consider adding `length` as an alias for `count` for better developer experience, or include a "Filter equivalents from other languages" comparison table in the quickstart guide.

---

## [2026-02-14 15:40 PST] - validate_xanoscript Tool Parameter Confusion

**What I was trying to do:**
Validate XanoScript code using the MCP validate_xanoscript tool.

**What the issue was:**
The tool expects a `code` parameter with the actual file content, but initially I tried passing `file_path`. The error message was just "'code' parameter is required" without explanation of what format the code should be in (string, escaped, etc.).

**Why it was an issue:**
Had to figure out how to properly pass multi-line code content via CLI - ended up using `jq -sR` to read the file as a raw string.

**Potential solution (if known):**
- Support both `file_path` and `code` parameters
- Or improve the error message to show an example of how to pass the code parameter correctly

---

## General Observations

### Strengths
- The xanoscript_docs tool is very helpful for getting syntax reference
- The error messages include line and column numbers which is great
- Validation catches syntax errors before deployment

### Suggestions
1. **More examples in documentation** - Having more complete, real-world function examples would help
2. **Common patterns cookbook** - A collection of "how to do X" patterns (API calls, array checking, error handling)
3. **IDE support** - Syntax highlighting and autocomplete would catch many of these issues at write-time
4. **Interactive validator** - A web-based validator where you can paste code and get immediate feedback

---

*This feedback was generated during the development of the Cloudflare Purge Cache run job on February 14, 2026.*

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 17:47 PST] - MCP Server Connection Issue

**What I was trying to do:**
Call the Xano MCP validate_xanoscript tool using mcporter.

**What the issue was:**
Initial attempts to call `mcporter call xano.validate_xanoscript` failed with "Unknown MCP server 'xano'" error, even though `mcporter list` showed xano was configured.

**Why it was an issue:**
The MCP server is configured as a stdio transport (npx @xano/developer-mcp), but mcporter wasn't finding it automatically. I had to use the `--stdio` flag explicitly.

**Potential solution:**
Either document that stdio-based MCP servers require the `--stdio` flag, or have mcporter auto-detect and use the configured transport method from the config file.

---

## [2026-02-15 17:48 PST] - Input Field Syntax Confusion

**What I was trying to do:**
Define input fields with default values and required validation in a function.

**What the issue was:**
I incorrectly used `filters="required"` and `default = "value"` syntax which are not valid. The validator reported:
- "The argument 'filters' is not valid in this context"
- "The argument 'default' is not valid in this context"

**Why it was an issue:**
Coming from other languages/frameworks, I assumed `default` would be a property and `filters` would include validation like "required". The correct syntax is:
- `text field?="default_value"` for optional with default
- Just `text field` for required (no modifier means required)
- `text field?` for optional with no default

**Potential solution:**
The quick_reference for types showed the modifiers table but it wasn't immediately clear that these modifiers go inline with the type declaration. A more explicit example like:
```xs
input {
  text required_field                    // Required, no default
  text optional_field?                   // Optional, no default  
  text field_with_default?="default"     // Optional with default
}
```
would have prevented this confusion.

---

## [2026-02-15 17:49 PST] - Unknown Filter Function

**What I was trying to do:**
Get the character count of a string using a `length` filter.

**What the issue was:**
Used `$input.content|length` which failed validation with "Unknown filter function 'length'".

**Why it was an issue:**
I assumed `length` would be the filter name (common in many languages), but XanoScript uses `count` for both arrays and strings.

**Potential solution:**
The quick_reference does show `count` in the filters table, but having a note that "count works for both arrays and strings" would be helpful. I also looked for a complete filter reference but only found the quick_reference with a few examples.

---

## [2026-02-15 17:50 PST] - Limited Filter Documentation

**What I was trying to do:**
Find a comprehensive list of all available filters.

**What the issue was:**
The syntax quick_reference only shows 8 common filters (trim, to_lower, to_upper, first, last, count, get, set, json_encode, json_decode, to_text, to_int). I couldn't find documentation for other potentially useful filters.

**Why it was an issue:**
Without a complete filter reference, I'm unsure what operations are available (e.g., is there a `length` for strings? `replace`? `split`? `contains`?)

**Potential solution:**
Add a comprehensive filter reference to the documentation, or a way to discover available filters through the MCP.

---

## [2026-02-15 17:51 PST] - String Concatenation in Headers

**What I was trying to do:**
Construct an Authorization header with string concatenation: `"xi-api-key: " ~ $env.ELEVENLABS_API_KEY`

**What the issue was:**
Initially wasn't sure if string concatenation with `~` would work in array contexts like headers.

**Why it was an issue:**
The syntax docs showed string concatenation but didn't explicitly show it being used within array literals.

**Potential solution:**
Add an example showing string concatenation within arrays, e.g.:
```xs
headers = [
  "Content-Type: application/json",
  "Authorization: Bearer " ~ $token
]
```

---

## Summary

Overall the MCP worked well once I figured out the `--stdio` flag requirement. The main struggles were around:
1. Input field syntax (default values and optional markers)
2. Discovering available filters
3. Understanding what syntax is valid in different contexts

The validate_xanoscript tool was very helpful and provided clear error messages with line/column numbers, which made fixing issues straightforward.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 02:50 PST] - MCP Server Name Resolution Issue

**What I was trying to do:**
Validate XanoScript files using the Xano MCP server via mcporter.

**What the issue was:**
The command `mcporter call xano.validate_xanoscript file=...` failed with "Unknown MCP server 'xano'", even though `mcporter list` showed the xano server as configured and healthy.

**Why it was an issue:**
This blocked automated validation. I had to work around by using the `--stdio` flag with the full npx command: `mcporter call --stdio "npx @xano/developer-mcp" validate_xanoscript ...`

**Potential solution (if known):**
The configured server name might be case-sensitive or there might be an issue with how mcporter resolves server names for STDIO-based MCP servers. Either mcporter should resolve the name correctly, or the error message should be clearer about why the server isn't found.

---

## [2025-02-16 02:51 PST] - validate_xanoscript Requires Code Content, Not File Path

**What I was trying to do:**
Validate a XanoScript file by passing a file path to the validate_xanoscript tool.

**What the issue was:**
The tool expects a `code` parameter containing the actual code content as a string, not a file path. The parameter name `code` and description "The XanoScript code to validate" weren't immediately clear that it needed raw content.

**Why it was an issue:**
I initially tried passing `file="/path/to/file.xs"` which failed with "'code' parameter is required". It took checking the schema to understand the correct usage.

**Potential solution (if known):**
Add support for a `file_path` parameter as an alternative to `code`, or clarify in the description that the actual file content is required (not a path). Example: "The XanoScript source code content to validate (not a file path)".

---

## [2025-02-16 02:53 PST] - Input Block Boolean Type is `bool`, Not `boolean`

**What I was trying to do:**
Define a boolean input parameter with a default value in a function input block.

**What the issue was:**
I initially used `boolean stream?=false` which caused a parse error: "Expecting --> } <-- but found --> 'boolean'"

**Why it was an issue:**
The type name `boolean` is intuitive (matches TypeScript/JavaScript), but XanoScript uses `bool`. The error message didn't indicate that `boolean` was an invalid type - it just said it expected a closing brace, which was confusing.

**Potential solution (if known):**
1. Accept both `bool` and `boolean` as aliases
2. Improve the error message to say something like "Unknown type 'boolean'. Did you mean 'bool'?"
3. Add a quick reference table of valid types to the error output

---

## [2025-02-16 02:55 PST] - Index Type Must Be `btree`, Not `index`

**What I was trying to do:**
Create a table with indexes on fields for faster queries.

**What the issue was:**
I used `type: "index"` for secondary indexes, but the validator rejected it with: "Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`"

**Why it was an issue:**
The term "index" is the generic concept, so it's natural to use it as the type. The error message was actually very helpful here, but I had to run validation to discover the valid values.

**Potential solution (if known):**
Consider accepting `index` as an alias for `btree` since that's the most common use case. Or improve the documentation to make the index type options more prominent.

---

## [2025-02-16 02:57 PST] - `truncate` Filter Doesn't Exist

**What I was trying to do:**
Truncate long strings before storing them in the database using `$text|truncate:500`.

**What the issue was:**
The `truncate` filter doesn't exist in XanoScript. The validator reported: "Unknown filter function 'truncate'"

**Why it was an issue:**
Many languages/frameworks have a `truncate` function (Rails, Laravel, Django, etc.), so it's a common expectation. I had to implement truncation manually using `strlen` checks and `substr`.

**Potential solution (if known):**
Add a `truncate` filter as a convenience: `$text|truncate:max_length` which would handle the length check internally.

---

## [2025-02-16 02:58 PST] - No Ternary/Conditional Expression Operator

**What I was trying to do:**
Write a compact conditional assignment like `$value = condition ? if_true : if_false`.

**What the issue was:**
XanoScript doesn't have a ternary operator. I had to use a `conditional` block with `var.update` to achieve the same result, which is more verbose.

**Why it was an issue:**
The code is less readable and more verbose:
```xs
// What I wanted to write:
var $truncated { value = $text|strlen > 500 ? ($text|substr:0:500) : $text }

// What I had to write:
var $truncated { value = $text }
conditional {
  if (`($text|strlen) > 500`) {
    var.update $truncated { value = $text|substr:0:500 }
  }
}
```

**Potential solution (if known):**
Consider adding a ternary operator or a `limit`/`truncate` filter that handles this common pattern.

---

## [2025-02-16 02:59 PST] - Expression Parentheses Requirement Confusing

**What I was trying to do:**
Write a conditional expression with filters: `if ($text|strlen > 500)`.

**What the issue was:**
The parser required extra parentheses around the entire expression: `if (($text|strlen) > 500)` - wrapping just the filter part.

**Why it was an issue:**
The error message "An expression should be wrapped in parentheses when combining filters and tests" was helpful, but it's not clear why `$text|strlen > 500` needs different grouping than `$text|strlen` alone.

**Potential solution (if known):**
The parser could be more lenient about operator precedence, or the error message could show the exact required syntax with an example.

---

## Summary

Overall, the Xano MCP and validation tools are functional and useful. The main friction points were:

1. **Documentation gaps** - Some common patterns (like truncating strings) require workarounds
2. **Error messages** - Could be more specific about what was wrong and suggest fixes
3. **Naming conventions** - `bool` vs `boolean`, `index` vs `btree` - accepting common synonyms would help
4. **MCP server resolution** - The configured server wasn't found by name, requiring workarounds

The validator was actually quite fast and helpful once I understood how to use it. The error messages with line/column numbers were accurate and made debugging much easier.

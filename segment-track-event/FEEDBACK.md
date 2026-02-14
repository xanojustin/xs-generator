# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 03:17 PST] - Object Type Requires Schema Block

**What I was trying to do:**
Create a function with optional object type input parameters to accept arbitrary JSON objects (for event properties, context, etc.)

**What the issue was:**
The `object` type requires a `schema` block defining its structure. I initially wrote:
```xs
object properties? { description = "Event properties" }
```

This caused a validation error:
```
[Line 7, Column 26] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'
```

**Why it was an issue:**
I needed to accept arbitrary JSON objects (properties, context, integrations) for the Segment API, but the `object` type requires a predefined schema. This is limiting for APIs that accept flexible JSON structures.

**Potential solution (if known):**
I switched to using `json` type instead, which works for arbitrary JSON. The documentation could be clearer about:
1. When to use `object` vs `json` type
2. That `object` requires a schema block
3. That `json` is the appropriate type for arbitrary/flexible JSON structures

---

## [2026-02-14 03:15 PST] - MCP Server Naming Confusion

**What I was trying to do:**
Call the Xano MCP validation tool using `mcporter call xano.validate_xanoscript`

**What the issue was:**
The server is named "xano" in mcporter list, but calling `xano.validate_xanoscript` returned "Unknown MCP server 'xano'". 

I had to use the syntax:
```
mcporter call validate_xanoscript --server xano ...
```

**Why it was an issue:**
The standard MCP tool calling convention `<server>.<tool>` doesn't work with mcporter. The documentation for mcporter shows different syntax than what actually works.

**Potential solution (if known):**
The mcporter documentation or the error message could be clearer about the correct syntax. Either:
1. Support the standard `<server>.<tool>` syntax
2. Document clearly that `--server` flag is required and the tool name comes first

---

## [2026-02-14 03:14 PST] - validate_xanoscript Requires Code Parameter

**What I was trying to do:**
Validate XanoScript files by passing a file path to the validate_xanoscript tool

**What the issue was:**
The tool requires a `code` parameter with the actual content, not a `file_path` parameter. The documentation I initially saw suggested `file_path` might work, but the tool returned:
```
Error: 'code' parameter is required
```

**Why it was an issue:**
I had to read the file content and pass it as the `code` parameter, which requires shell juggling with `jq` to properly escape the content.

**Potential solution (if known):**
The tool could support both:
1. `file_path` - read and validate a file directly
2. `code` - validate inline code

Or the documentation could be clearer that only `code` is supported.

---

## [2026-02-14 03:13 PST] - Limited Documentation on Input Type Modifiers

**What I was trying to do:**
Understand the correct syntax for optional input parameters with filters and descriptions

**What the issue was:**
The documentation shows various syntax examples but doesn't clearly explain:
1. That optional modifiers (`?`) can be combined with filters
2. That descriptions use `{ description = "..." }` block syntax
3. Which types support which combinations

I had to experiment to find that this works:
```xs
text user_id? filters=trim { description = "..." }
```

But this doesn't:
```xs
object properties? { description = "..." }
```

**Why it was an issue:**
Trial and error was needed to find valid syntax combinations, which slows down development.

**Potential solution (if known):**
A comprehensive type compatibility matrix or more detailed input block examples showing all valid combinations would help.

---

## [2026-02-14 03:12 PST] - Documentation Discovery

**What I was trying to do:**
Find the correct XanoScript syntax before writing code

**What the issue was:**
The `xanoscript_docs` tool is excellent, but I didn't initially know:
1. What topics were available
2. That I should call it without parameters first for an overview
3. The relationship between different documentation topics

**Why it was an issue:**
I had to guess which topics to request (tasks, syntax, integrations, functions, types)

**Potential solution (if known):**
The overview/documentation listing could be more prominent, or the tool could return a quick topic list when called without parameters.

---

## General Observations

### Positive:
- The `xanoscript_docs` tool is comprehensive and well-organized
- The validation tool provides helpful error messages with line/column numbers
- Once I understood the syntax, writing XanoScript was straightforward

### Areas for Improvement:
1. **Type system clarity** - Better distinction between `object` (structured) and `json` (unstructured)
2. **MCP integration** - More consistent tool naming/calling conventions
3. **Validation workflow** - Support for file-based validation in addition to code-based
4. **Quick reference** - A single-page cheat sheet showing all valid input type combinations
# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 17:45 PST] - MCP Tool Parameter Confusion

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool from the Xano MCP.

**What the issue was:**
The tool expects a `code` parameter containing the actual file content, not a `file_path` parameter. When I tried to pass `file_path="/path/to/file.xs"`, I got the error: "Error: 'code' parameter is required".

**Why it was an issue:**
I had to read the entire file content first, then pass it as a string parameter to the validation tool. This is cumbersome and not intuitive - most validation tools accept file paths for convenience.

**Potential solution (if known):**
The MCP could accept either:
1. A `file_path` parameter that reads the file internally
2. A `code` parameter for inline code
3. Or document clearly that `code` requires the full content, not a path

---

## [2025-02-13 17:45 PST] - String Escaping Challenges in Shell Commands

**What I was trying to do:**
Pass multi-line XanoScript code through shell commands to the MCP validation tool.

**What the issue was:**
Shell quoting and escaping becomes very complex when passing multi-line code strings with special characters (quotes, newlines, backticks) through `exec()` commands. The XanoScript contains quotes (`"`), concatenation operators (`~`), and various syntax that requires careful escaping.

**Why it was an issue:**
It was difficult to construct a valid shell command that preserved the exact XanoScript syntax. Single quotes, double quotes, and special characters all needed different escaping strategies.

**Potential solution (if known):**
1. Add a `file_path` parameter to `validate_xanoscript` so files can be validated directly
2. Or provide a batch validation endpoint that accepts multiple files
3. Or create a CLI wrapper that handles file reading and validation together

---

## [2025-02-13 17:45 PST] - Documentation Discovery

**What I was trying to do:**
Understand the exact syntax for run.job and function definitions in XanoScript.

**What the issue was:**
The `xanoscript_docs` tool is excellent and provides comprehensive documentation, but it took a few tries to understand that I needed to call it with specific `topic` parameters to get the relevant sections.

**Why it was an issue:**
Without knowing the available topics upfront, I had to guess or make multiple calls to find the right documentation. The main docs page lists topics but discovering them required reading through the content.

**Potential solution (if known):**
1. Provide a `topics` or `list_topics` command to see available documentation categories
2. Or include a topic index/TOC at the top of the main documentation response

---

## [2025-02-13 17:45 PST] - Input Block Optional Parameter Syntax

**What I was trying to do:**
Define optional input parameters in a function with default values.

**What the issue was:**
The documentation shows `text? field_name` for optional fields, but it wasn't immediately clear how to specify default values. I discovered through trial that optional fields with defaults use `text? field_name="default_value"` syntax.

**Why it was an issue:**
The quickstart documentation mentions optional fields but doesn't clearly show the default value syntax pattern in one place.

**Potential solution (if known):**
Add a clear example in the quickstart showing:
```xs
input {
  text required_field
  text? optional_field
  text? optional_with_default = "default_value"
}
```

---

## [2025-02-13 17:45 PST] - Filter Syntax for Object Manipulation

**What I was trying to do:**
Conditionally add fields to an object before sending it in an API request.

**What the issue was:**
The `|set:` filter syntax wasn't immediately obvious from the quickstart. I needed to use `var.update` with the `set` filter to add optional fields to the payload object.

**Why it was an issue:**
The pattern for building objects with optional fields is common in API integrations, but the documentation doesn't highlight this as a primary pattern.

**Potential solution (if known):**
Add a specific section in quickstart for "Building API Request Payloads with Optional Fields" showing:
```xs
var $payload { value = { required: "value" } }
conditional {
  if ($input.optional != null) {
    var.update $payload { value = $payload|set:"optional":$input.optional }
  }
}
```

---

## Summary

Overall, the Xano MCP worked well once I understood the patterns:
- Documentation via `xanoscript_docs` is comprehensive and well-organized by topic
- Validation tool works but would benefit from file_path support
- XanoScript syntax is clean and intuitive for those familiar with declarative languages
- The `run.job` construct is simple and effective for one-off tasks

The main friction points were:
1. File validation requiring inline code instead of file paths
2. Shell escaping complexity when passing code strings
3. Needing to discover documentation topics through exploration

None of these were blockers - just opportunities for improved developer experience.

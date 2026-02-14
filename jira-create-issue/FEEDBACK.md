# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 04:45 PST] - Installation Location Confusion

**What I was trying to do:**
Install and use the Xano MCP server

**What the issue was:**
The MCP was installed globally via npm (`npm install -g @xano/developer-mcp`), but the `xanoscript_docs` command was not available in my PATH. I had to use `mcporter` to discover and call the tools instead.

**Why it was an issue:**
The documentation suggests `xanoscript_docs` might be a CLI command, but it's actually an MCP tool that needs to be called through an MCP client like mcporter. This wasn't immediately clear.

**Potential solution (if known):**
Clarify in the MCP docs that tools are accessed via MCP protocol, not as standalone CLI commands. Perhaps provide a wrapper script or alias for common operations.

---

## [2026-02-14 04:47 PST] - Missing Tool Discovery

**What I was trying to do:**
Discover available tools in the Xano MCP

**What the issue was:**
Had to use `mcporter list xano --schema` to see tool names. The tool names weren't documented anywhere obvious - I had to inspect the schema output to find `xanoscript_docs` and `validate_xanoscript`.

**Why it was an issue:**
No quick reference guide listing the available tools and their purposes. Had to dig through JSON schema.

**Potential solution (if known):**
Add a simple tool listing in the README or a `xano mcp tools` command that lists available tools with brief descriptions.

---

## [2026-02-14 04:48 PST] - Documentation Topic Discovery

**What I was trying to do:**
Find the right documentation topic for run jobs

**What the issue was:**
The `xanoscript_docs` tool has a `topic` parameter with many options, but there's no easy way to list available topics without looking at the schema. I guessed "run" was the right topic but wasn't sure.

**Why it was an issue:**
Had to inspect the input schema to see all 20+ available topics. Would be helpful to have a topic listing command.

**Potential solution (if known):**
Add a topic discovery command or include available topics in the tool description with examples.

---

## [2026-02-14 04:50 PST] - Counterintuitive `params` Parameter

**What I was trying to do:**
Make an HTTP POST request with a JSON body

**What the issue was:**
The `api.request` operation uses `params` for the request body (not query parameters), which is confusing. The documentation even notes this: "The `params` parameter is used for the **request body** (POST/PUT/PATCH), not query parameters."

**Why it was an issue:**
Every other HTTP library uses `body` for request body and `params` for query parameters. This naming choice is error-prone.

**Potential solution (if known):**
Consider adding a `body` alias for `params` or eventually deprecating `params` in favor of `body` to match industry conventions.

---

## [2026-02-14 04:52 PST] - String Concatenation with Filters

**What I was trying to do:**
Concatenate strings that use filters (like `|to_text`)

**What the issue was:**
The syntax requires wrapping filtered expressions in parentheses: `($status|to_text) ~ ": " ~ ($data|json_encode)`. Without parentheses, it causes a parse error.

**Why it was an issue:**
Not intuitive - most languages don't require this. Had to find this in the documentation.

**Potential solution (if known):**
The documentation covers this well with examples, but the parser error message could be more helpful. Currently it probably just says "parse error" without suggesting the parentheses fix.

---

## [2026-02-14 04:53 PST] - No `default` Filter

**What I was trying to do:**
Provide a default value for potentially null input

**What the issue was:**
There's no `default` filter (common in Twig, Liquid, etc.). Had to use `conditional` blocks instead, which is more verbose.

**Why it was an issue:**
Common pattern `$input.description|default:""` isn't available. Must use:
```xs
conditional {
  if ($input.description != null) {
    // use description
  }
  else {
    // use default
  }
}
```

**Potential solution (if known):**
Add a `default` filter: `$value|default:"fallback"` or `$value|default:$other_var`

---

## [2026-02-14 04:55 PST] - Setting Object Properties is Verbose

**What I was trying to do:**
Conditionally add properties to an object (like adding optional fields to the Jira issue)

**What the issue was:**
The `set` filter returns a new object, so I need to use `var` and `var.update` in a chain:
```xs
var $fields_with_desc { value = $issue_fields|set:"description":... }
var.update $issue_fields { value = $fields_with_desc }
```

**Why it was an issue:**
Very verbose for a common pattern. Would be nice to mutate in place or have a cleaner syntax.

**Potential solution (if known):**
Consider adding object mutation syntax or a cleaner chained approach like:
```xs
$issue_fields|set:"description":...|set:"priority":...
```
Or allow direct mutation:
```xs
set $issue_fields.description = ...
```

---

## [2026-02-14 04:56 PST] - Filter Chaining Syntax is Unclear

**What I was trying to do:**
Chain multiple filters together

**What the issue was:**
Unclear if filters can be chained with `|` like Unix pipes, and if the order matters. Documentation shows individual filters but not complex chaining.

**Why it was an issue:**
Had to guess at syntax like `$obj|set:"a":1|set:"b":2` vs nested calls.

**Potential solution (if known):**
Add clear examples of filter chaining in the syntax documentation.

---

## [2026-02-14 04:57 PST] - Positive Validation Experience

**What I was trying to do:**
Validate XanoScript code before committing

**What the issue was:**
None! The `validate_xanoscript` tool worked perfectly. It caught no errors (which was correct) and provided clear feedback.

**Why it was an issue:**
Not an issue - this worked great! Fast feedback loop.

**Potential solution (if known):**
Keep this tool as-is. Maybe add line/column numbers to the "valid" response too for consistency.

---

## [2026-02-14 04:58 PST] - Documentation Quality is Good

**What I was trying to do:**
Learn XanoScript syntax for run jobs, functions, and API requests

**What the issue was:**
None! The `xanoscript_docs` tool returned comprehensive, well-organized documentation with examples.

**Why it was an issue:**
Not an issue - the docs were thorough and helpful. Especially liked the "Quick Reference" tables.

**Potential solution (if known):**
The `quick_reference` mode is great for keeping context small. Consider making it the default.

---

## Summary

Overall the MCP worked well for this task. Main friction points:
1. Discovery of tools and topics (could use better listing/discovery)
2. Some syntax quirks (`params` vs `body`, parentheses for filtered expressions)
3. Verbose object manipulation

The validation tool and documentation quality were highlights!

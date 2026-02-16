# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 01:46 PST] - Xano MCP Tool Discovery

**What I was trying to do:**
Access the Xano MCP server and use the `validate_xanoscript` tool to validate my .xs files.

**What the issue was:**
Initially, I wasn't sure how to access the MCP tools. The user mentioned tools like `xanoscript_docs` and `validate_xanoscript` but I didn't know if they were available as shell commands, through an HTTP API, or via some other interface. I tried accessing localhost:3000 which was blocked, and searched for installed binaries.

**Why it was an issue:**
This delayed my progress as I had to search for how to actually call these tools. The user instructions said to "call the `xanoscript_docs` tool" but didn't specify the mechanism.

**Potential solution (if known):**
- Document the MCP server access method clearly (e.g., "use `mcporter call xano.<tool_name>`")
- Provide a quick-start snippet showing how to validate a file
- Consider making `xanoscript_docs` available as a simple CLI command

---

## [2026-02-16 01:47 PST] - Finding Correct XanoScript Syntax via MCP

**What I was trying to do:**
Get the XanoScript documentation to understand the syntax for run jobs and functions.

**What the issue was:**
The `xanoscript_docs` tool requires a `topic` parameter, but I didn't know what topics were available. I had to guess based on the documentation structure. Also, the initial documentation output was very long and I had to search through it for specific information.

**Why it was an issue:**
Without knowing available topics, I was shooting in the dark. I eventually tried `topic: "syntax"` which worked, but it took time to figure this out.

**Potential solution (if known):**
- Provide a topic list command or default behavior when no topic is specified
- Add a search functionality to find specific syntax within docs
- Organize docs with a clearer index/table of contents

---

## [2026-02-16 01:52 PST] - Filter Name Discovery (upper vs to_upper)

**What I was trying to do:**
Convert a string to uppercase using a filter.

**What the issue was:**
I assumed the filter was named `upper` (common in many languages), but the actual filter name is `to_upper`. The validation error "Unknown filter function 'upper'" didn't suggest the correct filter name.

**Why it was an issue:**
I had to dig through the syntax documentation to find the correct filter name. This is a common operation that should be obvious or have helpful error suggestions.

**Potential solution (if known):**
- Add filter name suggestions in validation errors ("Did you mean 'to_upper'?")
- Provide a quick reference card of common filters (uppercase, lowercase, trim, etc.)
- Allow aliases for common filter names (upper → to_upper)

---

## [2026-02-16 01:55 PST] - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool by passing the code content as a parameter.

**What the issue was:**
The `validate_xanoscript` tool only accepts a `code` string parameter, which requires passing multi-line XanoScript code through the shell. This caused multiple escaping issues:

Simple `mcporter call xano.validate_xanoscript code="..."` commands failed because:
1. Newlines in the code break the shell command
2. Quotes inside the code conflict with shell quoting
3. Special characters get interpreted by the shell

I had to use a complex workaround with `jq` to properly escape the code:
```bash
CODE=$(cat file.xs) && echo '{"code": ""}' | jq --arg code "$CODE" '.code = $code' > /tmp/validate.json
mcporter call xano.validate_xanoscript --args "$(cat /tmp/validate.json)"
```

**Why it was an issue:**
This is not intuitive and requires knowledge of both jq and shell escaping. It makes validating files during development cumbersome.

**Potential solution (if known):**
- Add a `file_path` parameter alternative to `validate_xanoscript` so we can pass a file path instead of raw code content
- Or provide a helper that reads the file and validates it internally
- Document the recommended way to validate files (e.g., using jq + temp files as I eventually did)

---

## [2026-02-16 01:58 PST] - No Single Source of Truth for Syntax

**What I was trying to do:**
Understand the complete XanoScript syntax for writing a run job and function.

**What the issue was:**
The documentation is split across multiple topics (`syntax`, `functions`, `integrations`, etc.). I had to:
1. Read existing examples in the ~/xs/ folder to understand the structure
2. Query the MCP docs for specific syntax details
3. Validate repeatedly to catch syntax errors

**Why it was an issue:**
There's no single comprehensive reference. I had to piece together information from:
- Existing code examples (which may have bugs or outdated patterns)
- MCP documentation (scattered across topics)
- Validation errors (trial and error)

**Potential solution (if known):**
- Create a comprehensive language reference guide
- Add an interactive validator that shows syntax errors as you type
- Provide more complete, production-ready examples in the docs

---

## Summary

Overall, the Xano MCP tools work well once you understand how to access them. The validation tool is particularly helpful. The main friction points were:

1. **Tool discoverability** - Unclear how to access MCP tools initially
2. **Documentation organization** - Information scattered across topics
3. **Filter naming** - Non-intuitive filter names without suggestions
4. **Validation workflow** - Complex shell escaping required to validate files
5. **No file-based validation** - Must pass code as string instead of file path

The language itself is clean and intuitive once you learn the patterns. Having a `file_path` parameter for validation would significantly improve the developer experience.

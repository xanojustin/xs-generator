# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-20 17:35 PST - MCP Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** I initially tried passing parameters as JSON (`'{"file_paths": [...]}'`) and got the error: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

The mcporter CLI expects parameters in `key=value` format, not JSON. This wasn't immediately clear from the documentation examples.

**Why it was an issue:** I spent several attempts trying different JSON formatting approaches before realizing the correct syntax was:
```
mcporter call xano validate_xanoscript directory=/Users/justinalbrecht/xs/queue-using-stacks
```

**Potential solution:** 
1. The `describe` output shows examples like `mcporter call xano.validate_xanoscript(file_path: "/path/to/file.md", file, ...)` which suggests function-call syntax, but this doesn't work directly in the CLI
2. The help text could explicitly show both the `key=value` format and mention that JSON via `--args` is an alternative
3. A clearer error message like "Parameter 'directory' not provided. Use format: key=value" would help

---

## 2025-02-20 17:30 PST - Documentation Topic Redundancy

**What I was trying to do:** Get specific documentation for functions, quickstart, and run jobs

**What the issue was:** I called `xanoscript_docs` with topics `functions`, `quickstart`, and `run` - all three returned nearly identical general documentation instead of topic-specific content.

**Why it was an issue:** I was hoping for:
- `functions` topic: Detailed function syntax, patterns, examples
- `run` topic: Run job syntax, how to use `function.run`, examples
- `quickstart`: Quick reference patterns

Instead, all returned the same general XanoScript overview with the index of topics.

**Potential solution:** 
1. The topic-specific documentation may not be implemented yet, or the MCP is returning the fallback README
2. Consider returning a clear message like "Topic 'run' documentation not yet available, showing overview instead"
3. Or ensure all listed topics have actual content

---

## 2025-02-20 17:25 PST - Working Directory Sensitivity

**What I was trying to do:** Run validation from within the `queue-using-stacks` directory

**What the issue was:** When I changed to the target directory and ran `mcporter call xano validate_xanoscript`, I got: "Unknown MCP server 'xano'"

**Why it was an issue:** The MCP server configuration seems to be relative to the working directory or there's some path resolution issue. I had to run from the home directory with absolute paths.

**Potential solution:**
1. MCP server discovery should be consistent regardless of working directory
2. Or document that mcporter should be run from the home/config directory

---

## General Observations

### What Worked Well
1. Once I figured out the parameter format, validation worked perfectly
2. The error messages for invalid XanoScript are very helpful (line/column positions)
3. The directory validation option is convenient for batch checking
4. All my files passed on first attempt, suggesting the documentation was sufficient for basic patterns

### Suggestions for MCP Improvement
1. Add more worked examples to the `describe` output showing the exact CLI syntax
2. Consider supporting JSON parameter input more naturally (many developers expect this)
3. Add a `validate_xanoscript --watch` mode for development workflow
4. Consider adding a `validate_and_format` tool that also fixes common formatting issues

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 16:46 PST] - MCP Server Discovery/Connection Issues

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` tool via mcporter.

**What the issue was:**
The `xano` MCP server is configured in `~/.openclaw/workspace/config/mcporter.json`, but mcporter couldn't find it when running from the home directory or other locations. The error was:
```
[mcporter] Unknown MCP server 'xano'.
```

**Why it was an issue:**
Had to figure out that mcporter needs to be run from the workspace directory where the config file exists. This wasn't immediately obvious from the error message.

**Potential solution (if known):**
- Document that mcporter uses the current working directory to find config
- Consider having mcporter search parent directories for config files (like git does with .git)
- Or provide a clearer error indicating which config file paths were checked

---

## [2026-02-13 16:45 PST] - validate_xanoscript Tool Requires Code Content, Not File Path

**What I was trying to do:**
Validate an .xs file by passing its file path to the validate_xanoscript tool.

**What the issue was:**
The tool requires the actual code content as a `code` parameter, not a file path. My initial attempts like:
```
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
```
Failed with: `Error: 'code' parameter is required`

**Why it was an issue:**
Had to read the file content, escape it properly as JSON, and pass it as the `code` parameter. This required multiple attempts with jq and shell escaping.

**Potential solution (if known):**
- Support both `code` (inline) and `file_path` (read from disk) parameters
- Or document clearly that the `code` parameter requires the actual file content
- Provide examples in documentation showing how to use jq to properly escape file content

---

## [2026-02-13 16:44 PST] - xanoscript_docs Topic Parameter Returns Same Content

**What I was trying to do:**
Get specific documentation for run jobs by calling `xanoscript_docs` with different topic parameters.

**What the issue was:**
Both `xanoscript_docs({"topic": "run"})` and `xanoscript_docs({"topic": "quickstart"})` returned the same general documentation content. The specific run job syntax and examples weren't provided.

**Why it was an issue:**
Had to look at existing implementations in the ~/xs folder to understand the run.job structure and syntax patterns instead of getting clear documentation from the MCP.

**Potential solution (if known):**
- Ensure topic-specific documentation actually returns different content per topic
- Add a dedicated `run` topic with run.job syntax, structure, and examples
- Include more examples in the general docs showing run.job definitions

---

## [2026-02-13 16:43 PST] - Difficulty Passing Multi-line Code to validate_xanoscript

**What I was trying to do:**
Pass the content of an .xs file (which contains newlines and quotes) to the validate_xanoscript tool.

**What the issue was:**
Multiple attempts failed:
1. Using `--args @filename.json` - mcporter doesn't support @file syntax
2. Using `jq -Rs` which wraps content in extra quotes - caused validation to fail
3. Shell variable expansion with complex escaping issues

The working solution was:
```bash
mcporter call xano validate_xanoscript --args "$(cat file.xs | jq -Rs '{code: .}')"
```

**Why it was an issue:**
Wasted significant time trying different approaches to pass the code content properly.

**Potential solution (if known):**
- Add a dedicated `validate_xanoscript_file` tool that accepts a file path
- Or provide clear CLI examples in documentation
- Support `--args @file.json` syntax for reading JSON from files

---

## [2026-02-13 16:42 PST] - Missing run.job Syntax Documentation

**What I was trying to do:**
Understand the exact syntax for run.job definitions in run.xs files.

**What the issue was:**
The xanoscript_docs didn't provide specific run.job syntax. Had to reverse-engineer from existing examples in ~/xs/ folder (stripe-charge-customer, sendgrid-send-email, etc.).

**Why it was an issue:**
Key questions that weren't answered by docs:
- What fields are required in a run.job block?
- What's the difference between `main.name` and the function name?
- How should `env` array be formatted?
- What input types are supported?

**Potential solution (if known):**
- Add complete run.job schema documentation
- Include all valid fields and their purposes
- Provide 2-3 complete, commented examples of run.xs files

---

## Summary

The Xano MCP server works well once you understand its quirks. Main friction points:

1. **Config location sensitivity** - mcporter needs to run from the right directory
2. **Validation requires inline code** - no file path option available
3. **Documentation gaps** - had to use existing examples as reference
4. **Shell escaping complexity** - multi-line code passing is tricky

The actual validation tool is accurate and helpful - it correctly identified issues when I had syntax problems. Just the ergonomics of using it could be improved.

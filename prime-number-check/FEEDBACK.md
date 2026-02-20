# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 18:05 PST] - Parameter Format Confusion for validate_xanoscript

**What I was trying to do:** Validate the XanoScript files using the MCP validate_xanoscript tool

**What the issue was:** The MCP tool documentation shows JSON parameter format like `{"file_path": "/path/to/file"}`, but when using `mcporter call` command, this doesn't work directly. The tool kept returning "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when passing JSON.

**Why it was an issue:** I tried multiple approaches:
1. `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` - Failed
2. `echo '{"file_path": "/path"}' | mcporter call xano validate_xanoscript` - Failed
3. `mcporter call xano validate_xanoscript --file_path /path` - Failed

The working format was `mcporter call xano validate_xanoscript file_path=/path/to/file` (key=value without dashes).

**Potential solution:** The MCP documentation or examples could show the correct CLI format more explicitly. The `mcporter call --help` mentions `key=value` but it's easy to miss.

---

## [2025-02-19 18:07 PST] - Documentation Structure Feedback

**What I was trying to do:** Understand the structure of run.xs files and how they call functions

**What the issue was:** The documentation describes the `run.job` construct but doesn't clearly explain the relationship between the `main.name` field and the function it calls. I had to look at existing examples (fizzbuzz, fibonacci) to understand that `main.name` should match the function name defined in the function file.

**Why it was an issue:** Without existing examples, it would have been unclear whether `main.name` refers to:
- The function construct name
- The file name
- A registered name in Xano

**Potential solution:** Add a "Run Job to Function Binding" section in the `run` topic documentation with a clear example showing the name matching.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 16:35 PST] - MCP Tool Parameter Syntax Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The parameter syntax for `mcporter call` was unclear. I tried multiple approaches that all failed:
1. JSON format: `'{"file_path": "/path/to/file"}'` — Error: parameter required
2. Double-dash format: `--file_path "/path/to/file"` — Error: parsed as code, not parameter
3. Eventually found: `file_path="/path/to/file"` works

**Why it was an issue:** Wasted time trying different syntaxes. The error messages were misleading — when using `--file_path`, the tool interpreted it as XanoScript code rather than a CLI parameter.

**Potential solution:** 
- Document the expected parameter format clearly in the tool description
- Support standard CLI formats like `--flag value` or `--flag=value`
- Better error messages that distinguish between "missing parameter" vs "parameter parsed as code"

---

## [2025-02-20 16:36 PST] - xanoscript_docs Topic Parameter Not Working

**What I was trying to do:** Get specific documentation by calling `xanoscript_docs` with a topic parameter (e.g., `quickstart`, `functions`)

**What the issue was:** Multiple attempts to pass the topic parameter failed:
1. `'{"topic": "quickstart"}'` — returned general README instead of quickstart content
2. Various other JSON formats — same result or errors

**Why it was an issue:** Could not access topic-specific documentation. Had to rely on existing code examples and general README.

**Potential solution:**
- Document the correct parameter format for topics
- Ensure topic parameter is properly parsed and returns the requested documentation section
- Add examples showing how to retrieve specific topics

---

## [2025-02-20 16:37 PST] - Working Directory Sensitivity

**What I was trying to do:** Run mcporter commands from within the `~/xs` directory

**What the issue was:** When running `mcporter call xano ...` from inside `~/xs`, got error: "Unknown MCP server 'xano'". But from home directory, it works fine.

**Why it was an issue:** Inconsistent behavior based on working directory. If there's a local config or package issue in `~/xs`, it breaks MCP discovery.

**Potential solution:**
- Make MCP server discovery work consistently regardless of working directory
- Document if certain directories have special MCP behavior
- Add debug info showing where mcporter is looking for config

---

## [2025-02-20 16:38 PST] - validate_xanoscript Directory Parameter Not Functional

**What I was trying to do:** Validate all files in a directory using the `directory` parameter

**What the issue was:** Attempted `directory: "/Users/justinalbrecht/xs/contains-duplicate"` but got "parameter required" error. Tried various syntaxes without success.

**Why it was an issue:** Had to validate files individually instead of batch validation, which is less efficient.

**Potential solution:**
- Fix the directory parameter to work as documented
- Provide working examples of batch validation

---

## Positive Feedback

Once the correct syntax was found (`file_path="/path"`), the validation worked quickly and provided clear output. The language server correctly identified the file types from their content.

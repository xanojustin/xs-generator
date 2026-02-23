# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 01:32 PST - MCP Connection and Path Issues

**What I was trying to do:** Validate XanoScript files using the Xano MCP server

**What the issue was:** The MCP server connection was problematic. I encountered several issues:
1. Initially tried `mcporter call xano.xanoscript_docs` which failed with "Unknown MCP server 'invoke'"
2. Then tried various incorrect syntaxes like `--params` and `invoke` command
3. Found that the `xano` server uses a command-based transport (`npx -y @xano/developer-mcp`) which requires the config file to be specified
4. The config file was not in the expected location (`~/.config/mcporter/`) but in `~/.openclaw/workspace/config/mcporter.json`
5. When using `directory="."` parameter, the validation returned "No .xs files found in directory: ." even though the files existed
6. Had to use absolute file paths with `file_paths` parameter to successfully validate

**Why it was an issue:** This caused significant delay in getting the first validation done. The error messages were not helpful in understanding that:
- The config file location was different than standard
- Directory-based validation wasn't working properly
- Absolute paths were required

**Potential solution (if known):** 
- Document the config file location clearly for OpenClaw users
- Fix the directory-based validation to properly discover .xs files
- Consider adding a `--cwd` or `--workdir` flag to mcporter for better path resolution
- Improve error messages to suggest using absolute paths when relative paths fail

---

## 2025-02-23 01:35 PST - Successful Validation

**What I was trying to do:** Successfully validate the XanoScript files after finding the right approach

**What the issue was:** Once I found the correct syntax with absolute file paths, validation worked perfectly on the first try.

**Why it was an issue:** Not an issue - validation passed successfully.

**Potential solution (if known):** The validation tool itself works great once you know how to use it. The main friction was finding the correct mcporter invocation pattern.

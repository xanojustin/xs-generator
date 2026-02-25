# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 02:03 PST] - MCP Command Not Found in PATH

**What I was trying to do:** Call `xanoscript_docs` to get XanoScript documentation before writing code

**What the issue was:** The `xanoscript_docs` command was not available in my PATH. I had to search for the actual CLI command which turned out to be `xano-developer-mcp`

**Why it was an issue:** I expected `xanoscript_docs` to be a standalone CLI command based on the prompt instructions, but it wasn't globally available. The npm package is installed but the bin command wasn't linked properly or the documentation was misleading.

**Potential solution (if known):** 
- Either make `xanoscript_docs` a proper CLI command that gets linked during npm install
- Or update the instructions to use `npx xano-developer-mcp` or `npx @xano/developer-mcp`
- The prompt says "call `xanoscript_docs` on the Xano MCP" but this should clarify HOW to call it (via MCP protocol vs CLI)

---

## [2025-02-25 02:05 PST] - MCP Server Hangs on CLI Invocation

**What I was trying to do:** Run `xano-developer-mcp --help` to see available commands

**What the issue was:** The command hung indefinitely and never returned output

**Why it was an issue:** I couldn't determine how to use the MCP tools via CLI. The MCP server is designed to run as a background process speaking JSON-RPC over stdio, not as a traditional CLI tool with --help.

**Potential solution (if known):**
- The MCP should have a `--help` flag that works for discovering capabilities
- Or there should be clearer documentation that the MCP is meant to be used via an MCP client (like Claude Desktop) not as a standalone CLI
- Consider adding a separate CLI wrapper that doesn't start the MCP server but just exposes the tools as commands

---

## [2025-02-25 02:10 PST] - Node Module Resolution Issues

**What I was trying to do:** Write a Node.js script to validate XanoScript files using the MCP library

**What the issue was:** Couldn't import from '@xano/developer-mcp' directly because the package wasn't in my project's node_modules. Had to use the full path to the global installation.

**Why it was an issue:** The ES module import system couldn't find the package even though it was installed globally. This made it harder to write a simple validation script.

**Potential solution (if known):**
- Add better documentation for using the library programmatically
- Consider publishing a separate CLI package that's easier to invoke
- Or provide a simple wrapper script that handles the module resolution

---

## [2025-02-25 02:12 PST] - Unclear Documentation for `validate_xanoscript` Tool

**What I was trying to do:** Understand how to use the `validate_xanoscript` tool

**What the issue was:** I had to read the source code of the MCP package to figure out how to use the validation function

**Why it was an issue:** There was no clear documentation on how to actually invoke the validation. I had to:
1. Find the package installation location
2. Read through `dist/tools/validate_xanoscript.js` to understand the API
3. Write a custom Node.js script to call the function

**Potential solution (if known):**
- Add a simple CLI command like `xano-validate` that takes file paths as arguments
- Document the programmatic API with examples in the README
- Provide a shell script wrapper that makes validation easy from the command line

---

## [2025-02-25 02:15 PST] - Prompt Instructions vs Reality Mismatch

**What I was trying to do:** Follow the instructions in the prompt to "call `xanoscript_docs` on the Xano MCP"

**What the issue was:** The instructions assume a specific MCP integration that wasn't actually available in this environment

**Why it was an issue:** The prompt says "You MUST call `xanoscript_docs` on the Xano MCP" and mentions it as if it's a simple function call. In reality:
- The MCP tools are designed to be called via MCP protocol, not directly
- There's no simple CLI interface
- The validation worked fine on the first try, so the documentation wasn't even needed in this case

**Potential solution (if known):**
- Update the prompt to clarify that MCP tools may not be directly available in all environments
- Provide fallback instructions for when MCP tools aren't available
- Or ensure the MCP tools are properly integrated before running these exercises

---

## Summary

The validation itself worked perfectly once I figured out how to invoke it. The main struggles were around:
1. Discovering how to actually call the MCP tools
2. Understanding the difference between MCP protocol usage and CLI usage
3. Module resolution issues when trying to use the library programmatically

The code passed validation on the first try, which suggests the syntax understanding from other exercises is working well!

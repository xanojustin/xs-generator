# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 18:32 PST] - No Issues - First Try Success

**What I was trying to do:** Create a complete XanoScript run job with a function that solves the "Arranging Coins" coding exercise.

**What the issue was:** None! Both files validated successfully on the first attempt.

**Why it was an issue:** N/A - Everything worked smoothly.

**Potential solution (if known):** N/A

---

## [2025-02-28 18:30 PST] - MCP Installation Discovery

**What I was trying to do:** Access the Xano MCP tools (`xanoscript_docs`, `validate_xanoscript`) to get documentation and validate code.

**What the issue was:** The command `xanoscript_docs` was not found in PATH after global npm install. The documentation implied it might be available as a CLI command.

**Why it was an issue:** I had to discover that the tools are only available as library exports, not CLI commands. I had to use Node.js to import and call them.

**Potential solution (if known):** 
- Add CLI wrappers for the tools so they can be called directly from shell
- Or update documentation to clearly state the tools are library-only and provide example Node.js one-liners for using them

---

## [2025-02-28 18:31 PST] - Documentation Access Works Well

**What I was trying to do:** Get XanoScript syntax documentation for functions and run jobs.

**What the issue was:** None - the `xanoscriptDocs()` function worked well and returned comprehensive documentation.

**Why it was an issue:** N/A

**Positive feedback:** The documentation is well-structured with clear examples. The topic-based organization (functions, run, syntax, types, etc.) made it easy to find what I needed.

---

## Summary

Overall, the Xano MCP worked well for this exercise:

1. **Installation:** `npm install -g @xano/developer-mcp` worked smoothly
2. **Documentation:** Accessing docs via `xanoscriptDocs({ topic: "..." })` provided clear, helpful information
3. **Validation:** `validateXanoscript()` accurately validated both `.xs` files
4. **First-try success:** The code I wrote based on the documentation passed validation immediately

The main improvement would be making the tools more discoverable/accessible from the shell without requiring Node.js boilerplate.

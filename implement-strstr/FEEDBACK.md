# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-23 09:05 PST] - First Validation Passed Without Issues

**What I was trying to do:** Create the "implement strstr" coding exercise with a function and run job

**What the issue was:** None — both files passed validation on the first attempt

**Why it was (not) an issue:** The code was written correctly following the XanoScript patterns from the documentation

**Notes:**
- The naive string matching algorithm was straightforward to implement using XanoScript's `substr` filter and `strlen` filter
- The `return` statement inside conditionals worked as expected for early returns
- Variable scoping in the while loop worked correctly with `var.update`

---

## [2025-02-23 09:04 PST] - MCP Configuration

**What I was trying to do:** Call the Xano MCP to get XanoScript documentation

**What the issue was:** The MCP server wasn't configured in mcporter initially

**Why it was an issue:** Had to run `mcporter config add xano --command "npx" --arg "-y" --arg "@xano/developer-mcp" --scope home` to add it

**Potential solution (if known):** Consider documenting the mcporter setup in the skill documentation or have it pre-configured

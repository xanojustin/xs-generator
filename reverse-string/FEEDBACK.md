# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 18:15 PST] - No Issues Encountered - Clean Development Experience

**What I was trying to do:** Create a reverse-string coding exercise using XanoScript

**What the issue was:** No issues encountered! The development flow was smooth.

**Why it was (not) an issue:** 
- Documentation was clear and comprehensive
- The `split`, `reverse`, and `join` filters worked exactly as documented
- Code passed validation on first attempt
- Tool calls were responsive and accurate

**Potential solution (if known):** N/A - This was a positive experience. The quick_reference mode in xanoscript_docs was particularly helpful for finding the right filters efficiently.

---

## [2026-02-18 18:05 PST] - MCP Tool Discovery Process

**What I was trying to do:** Find the correct syntax for calling the Xano MCP tools via mcporter

**What the issue was:** Initially struggled with the mcporter call syntax - tried various formats before finding the correct one

**Why it was an issue:** The error messages weren't always clear about the correct parameter format. Tried:
- `mcporter call xanoscript_docs --mcp-server "npx..."` (wrong flag)
- `mcporter call "npx...".xanoscript_docs topic: functions` (wrong syntax)
- `mcporter call "npx -y @xano/developer-mcp".xanoscript_docs topic: functions` (dot notation wrong)

**Potential solution (if known):** The correct syntax is:
```
mcporter call "npx -y @xano/developer-mcp" xanoscript_docs topic=functions mode=quick_reference
```

Having a clear example in the SKILL.md or documentation would help. The key insight is:
1. Server command goes first in quotes
2. Tool name is separate (not dot-notated)
3. Parameters use `key=value` format (not `key: value`)

---

## [2026-02-18 18:00 PST] - npm Token Warning

**What I was trying to do:** Call the MCP tools

**What the issue was:** Saw npm notice about expired access token, though it didn't block functionality

**Why it was an issue:** Warning message appears in stderr but operation succeeds. Could be confusing to users.

**Potential solution (if known):** The warning is just noise since the package is already installed globally. Perhaps document that this warning can be ignored if using global installation.

---

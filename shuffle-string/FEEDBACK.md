# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 08:35 PST] - Successful First-Attempt Validation

**What I was trying to do:** Create a shuffle-string exercise with a run job and function

**What the issue was:** No issues encountered - both files passed validation on first attempt

**Why it was an issue:** N/A - successful validation

**Potential solution (if known):** The documentation from `xanoscript_docs` was comprehensive enough to write correct syntax on the first try. Key helpful elements:
- Clear function structure examples with input/stack/response blocks
- Run.job syntax with main.name and main.input
- Variable declaration patterns using `var $name { value = ... }`
- Filter syntax like `|strlen`, `|count`, `|substr`, `|set`, `|get`
- foreach loops with `each as $item` syntax
- for loops with `each as $idx` syntax

---

## [2026-03-02 08:30 PST] - MCP Server Discovery

**What I was trying to do:** Access the Xano MCP to get documentation and validate code

**What the issue was:** Initially unclear how to call the MCP tools

**Why it was an issue:** Tried using raw JSON-RPC over stdio but got method errors

**Potential solution (if known):** Using `mcporter call --stdio` worked perfectly. The skill documentation for mcporter helped clarify the correct approach:
```
mcporter call --stdio "npx @xano/developer-mcp" xanoscript_docs topic="functions"
```


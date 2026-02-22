# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-22 00:03 PST] - Initial Documentation Call

**What I was trying to do:** Get XanoScript documentation to understand the syntax before writing code

**What the issue was:** The MCP tools were available but I had to discover the correct way to call them via mcporter CLI

**Why it was an issue:** Initially wasn't sure how to invoke the Xano MCP - discovered it was through `mcporter call xano.<tool>`

**Potential solution (if known):** The workflow could benefit from a standard preamble in the coding exercise prompt showing the exact mcporter commands to use

---

## [2026-02-22 00:05 PST] - Cheat Sheet Mode Empty

**What I was trying to do:** Get quick reference syntax via cheatsheet topic with quick_reference mode

**What the issue was:** The response was essentially empty - just showed "Documentation version: 2.1.0" with no actual content

**Why it was an issue:** Had to fall back to full documentation mode which uses more context tokens

**Potential solution (if known):** Either fix the cheatsheet quick_reference mode to include actual content, or remove it as an option to avoid confusion

---

## [2026-02-22 00:07 PST] - First Validation Success

**What I was trying to do:** Validate the min-stack .xs files

**What the issue was:** None - validation passed on first try!

**Why it was an issue:** N/A - this is positive feedback that the MCP validation works well

**Potential solution (if known):** The validation tool correctly identified both files as valid with clear output. The JSON output option made parsing the result easy.

---

## Overall Observations

### What Worked Well:
1. The `validate_xanoscript` tool with `directory` parameter made batch validation easy
2. The quickstart documentation topic was comprehensive and helped avoid common mistakes
3. The existing examples in ~/xs/ provided good reference patterns

### Syntax Clarity:
1. Understanding that `var $name { value = ... }` is the declaration syntax was clear
2. The `$input.fieldname` requirement (not just bare variable) was clearly documented
3. The `?` nullable vs optional distinction (`text?` vs `text name?`) was helpful

### Pattern Learned:
- Using two parallel arrays (operations and values) to simulate method calls on a data structure
- Array manipulation without native pop() required manual array reconstruction with while loops
- The `conditional { if/elseif/else }` structure is more verbose than traditional if statements but clear

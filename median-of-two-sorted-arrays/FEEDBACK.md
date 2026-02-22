# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-21 17:35 PST - Return statement syntax confusion

**What I was trying to do:** Implement early returns in the function when edge cases are detected (empty arrays, found the median).

**What the issue was:** I initially wrote:
```xs
conditional {
  if (($m|count) == 0 && ($n|count) == 0) {
    response = null
    return { }
  }
}
```

This caused a validation error: `Expecting --> } <-- but found --> 'response'`

**Why it was an issue:** The documentation shows `return { value = null }` syntax for early returns, but I incorrectly assumed I could set `response` and then call `return { }`. The parser doesn't allow `response` statements inside conditional blocks followed by return.

**Potential solution:** The documentation is actually clear about `return { value = ... }` syntax, but it could be emphasized more that:
1. Inside conditionals, use `return { value = ... }` only
2. Never use `response = ...` followed by `return` inside conditionals
3. The `response = ...` at the end of the stack block is separate from early returns

---

## 2025-02-21 17:36 PST - Filter parentheses requirement

**What I was trying to do:** Get the count of arrays and compare to zero.

**What the issue was:** I initially wrote:
```xs
if (($m|count) == 0 && ($n|count) == 0)
```

But since `$m` and `$n` were already storing counts, the `|count` filter was redundant and confusing.

**Why it was an issue:** The documentation clearly states filters need parentheses when used with operators, but I was unnecessarily applying filters to variables that already held counts. This was my own logic error, not a documentation issue.

**Potential solution:** The documentation is clear on this. No changes needed.

---

## 2025-02-21 17:30 PST - Finding correct documentation topics

**What I was trying to do:** Get XanoScript documentation for functions, syntax, and types.

**What the issue was:** The MCP has topics like "functions", "syntax", "types", "run" but I initially tried "quick_reference" and "function" (singular) which don't exist.

**Why it was an issue:** When I called `xanoscript_docs` with an invalid topic, the error message helpfully listed all available topics. However, the naming isn't always intuitive - "functions" vs "function", no "quick_reference" topic (it does have "cheatsheet" though).

**Potential solution:** The error message with available topics is actually very helpful. Maybe add aliases for common variations like "function" -> "functions" or add a topic index at the start of the README documentation.

---

## 2025-02-21 17:25 PST - MCP tool availability

**What I was trying to do:** Initially tried to spawn a sub-agent to access the MCP, but then realized I could call it directly via `mcporter`.

**What the issue was:** I wasn't sure if the Xano MCP was configured or how to access it. I initially spawned a sub-agent which seemed to hang or not produce output.

**Why it was an issue:** Running `mcporter list` showed me the Xano MCP was already configured and available. The sub-agent approach added unnecessary complexity.

**Potential solution:** The cron job instructions mention using `xanoscript_docs` but could explicitly mention checking `mcporter list` first to verify the MCP is configured, or provide a command to check/configure it.

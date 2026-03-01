# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 04:32 PST] - Documentation Request: Run Job Syntax

**What I was trying to do:** Understand the correct syntax for creating a run.job that calls a function

**What the issue was:** The quick reference documentation for `run` topic was minimal and only showed:
```
run.job "Name" {
  main = { ... }
}
```

But didn't show the complete structure with `name:` and `input:` fields.

**Why it was an issue:** I had to look at existing implementations in the `~/xs/` folder to understand the exact syntax for calling a function from a run job.

**Potential solution:** The quick_reference for the `run` topic could include a complete example like:
```xs
run.job "Test Function" {
  main = {
    name: "function_name"
    input: {
      param1: value1
      param2: value2
    }
  }
}
```

---

## [2026-03-01 04:33 PST] - MCP Tool Discovery

**What I was trying to do:** Find the available tools in the Xano MCP

**What the issue was:** Initially didn't know how to access the MCP. Found `mcporter` was already configured.

**Why it was an issue:** Had to search for how to interact with the MCP - discovered `mcporter list xano` and `mcporter call xano.<tool>` commands.

**Potential solution:** Include basic MCP interaction examples in the SKILL.md or have a quick reference guide for:
- `mcporter list xano` - list available tools
- `mcporter call xano.xanoscript_docs topic:functions` - get docs
- `mcporter call xano.validate_xanoscript file_path:"/path/to/file.xs"` - validate code

---

## [2026-03-01 04:35 PST] - Variable Update Syntax Clarification

**What I was trying to do:** Update a variable's value in a while loop

**What the issue was:** Wasn't sure if I should use `var.update` or `math.add`/`math.sub` for updating counter variables.

**Why it was an issue:** Looking at existing code, I saw both patterns used. For incrementing/decrementing counters, `math.add` and `math.sub` seem to be the preferred approach within the stack block.

**Potential solution:** The documentation could clarify when to use:
- `var.update $var { value = ... }` - for complete reassignment
- `math.add $var { value = n }` - for incrementing
- `math.sub $var { value = n }` - for decrementing

---

## Summary

Overall, the Xano MCP validation tool worked perfectly and caught no errors. The main friction points were:
1. Discovering the correct MCP tool syntax
2. Finding complete examples for run job structure
3. Understanding variable update patterns

The `validate_xanoscript` tool is excellent - passed on first try which suggests the documentation (once found) was sufficient.

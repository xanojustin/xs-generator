# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-03 10:32 PST - Ternary operator syntax confusion

**What I was trying to do:** Write a concise max/min calculation using ternary operator syntax

**What the issue was:** I used `??` / `::` syntax (common in some languages) but XanoScript doesn't support this syntax. The error was:
```
[Line 31, Column 77] Expecting --> } <-- but found --> ':' <---
```

**Why it was an issue:** The documentation mentions the `??` nullish coalescing operator in the essentials guide, but doesn't clearly document what ternary/if-expression syntax is available. I assumed `??` / `::` or `?` / `:` would work based on common patterns in other languages.

**Potential solution:** Document the available conditional expression syntax more clearly. If XanoScript doesn't have inline ternary expressions, explicitly state that and show the `conditional { if (...) {...} else {...} }` pattern as the alternative.

---

## 2025-03-03 10:35 PST - run.job syntax completely different from functions

**What I was trying to do:** Create a run.job that calls a function with test inputs and logs multiple results

**What the issue was:** I assumed `run.job` would use the same `stack { ... }` block pattern as `function`, but it uses a completely different `main = { name: "...", input: {...} }` syntax. The error was:
```
[Line 2, Column 3] The argument 'stack' is not valid in this context
```

**Why it was an issue:** The main XanoScript documentation at the top mentions `run.job` and `run.service` in the directory structure, but the essentials guide doesn't cover their syntax. I had to call `xanoscript_docs({ topic: "run" })` specifically to learn the correct syntax.

**Potential solution:** 
1. Include a brief example of `run.job` and `run.service` syntax in the essentials documentation
2. Add a "Common Patterns" section showing how to call a function from a run job
3. The error message could be more helpful - instead of just saying "stack is not valid", it could suggest valid alternatives

---

## 2025-03-03 10:30 PST - No easy way to discover MCP tools

**What I was trying to do:** Find the correct command to validate XanoScript files

**What the issue was:** I didn't know the exact tool names available in the Xano MCP. I tried `mcporter tools xano` and other variations before figuring out the pattern was `mcporter call xano.<tool_name>`.

**Why it was an issue:** Trial and error to discover available tools wastes time. The `mcporter list` command shows server names but not the individual tools.

**Potential solution:** 
1. `mcporter list` could show available tools under each server
2. Or provide a `mcporter tools <server>` command to list tools for a specific server

---

## 2025-03-03 10:40 PST - run.job limitations for testing

**What I was trying to do:** Create a run.job that runs multiple test cases and logs all results

**What the issue was:** The `run.job` `main` syntax only calls a single function with fixed input. It doesn't support the `stack` block where I could run multiple function calls and log their results. I had to simplify to a single test case.

**Why it was an issue:** For a coding exercise generator, it's useful to run multiple test cases and show all results. The current `run.job` structure limits this.

**Potential solution:** 
1. Document whether `run.job` can support multiple function calls or logging
2. If the pattern is to create a wrapper function that runs all tests, document that pattern
3. Or consider allowing a `stack` block in `run.job` for more complex orchestration

---

## Summary

The main friction points were:
1. **Syntax discovery:** Some constructs (ternary operator) aren't clearly documented
2. **Inconsistent patterns:** `run.job` vs `function` have very different syntaxes
3. **Tool discovery:** Hard to discover MCP tool names
4. **Testing limitations:** `run.job` is limited to single function calls

The documentation is comprehensive once you find the right topic, but the essentials guide could benefit from more cross-references and common pattern examples.

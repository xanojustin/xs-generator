# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-19 22:05 PST - xanoscript_docs returns same content for all topics

**What I was trying to do:** Get specific XanoScript documentation for different topics (quickstart, functions, syntax, types, run jobs)

**What the issue was:** No matter what topic I requested (quickstart, functions, types, syntax, run), the `xanoscript_docs` tool returned the same README content with the general overview of XanoScript constructs and workspace structure. I couldn't get specific syntax details or examples.

**Why it was an issue:** Without specific documentation for:
- The correct `function.run` syntax
- How to properly parenthesize filter expressions
- The rule about one definition per .xs file

I had to discover these by trial and error through the validation tool, which slowed down development significantly.

**Potential solution:** The MCP server should return topic-specific documentation, or the tool description should be updated if it only returns general documentation.

---

## 2026-02-19 22:12 PST - function.run syntax was unclear

**What I was trying to do:** Call one function from another function (recursively call merge_sort_helper)

**What the issue was:** I initially used incorrect syntax: `function.run "name":{param: value}` based on my assumptions. The documentation I received didn't show clear examples of inter-function calls.

**Why it was an issue:** Got validation error: "Expecting: Expected an expression but found: 'function'" which wasn't very clear about what the correct syntax should be.

**Potential solution:** 
- Include more examples of `function.run` in the documentation
- The error message could suggest the correct block syntax: `function.run "name" { input = { param: value } }`

---

## 2026-02-19 22:15 PST - One definition per file rule not obvious

**What I was trying to do:** Create helper functions within the same file (merge_sort_helper and merge as helper functions)

**What the issue was:** I put multiple `function` definitions in a single .xs file. Got error: "Redundant input, expecting EOF but found: // Helper function"

**Why it was an issue:** The error message doesn't clearly explain that each .xs file can only contain ONE definition. I had to figure this out through trial and error.

**Potential solution:** 
- The error message could explicitly state: "Each .xs file can only contain one definition. Split functions into separate files."
- Include this prominently in the quickstart documentation

---

## 2026-02-19 22:18 PST - Filter expression parentheses requirement

**What I was trying to do:** Check if array count is <= 1: `$input.numbers|count <= 1`

**What the issue was:** XanoScript requires parentheses when combining filters with comparison operators. The error was: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This wasn't documented in the general README I received. Had to fix via validation error.

**Potential solution:** Include this rule in the syntax documentation with examples like:
```xs
// WRONG:
if ($arr|count > 5) { }

// CORRECT:
if (($arr|count) > 5) { }
```

---

## General Feedback

The validation tool (`validate_xanoscript`) is excellent and caught all my mistakes with fairly clear error messages. However, the `xanoscript_docs` tool returning the same content regardless of topic made it much harder to write correct code initially. I had to rely on:
1. Reading existing working examples from other exercises
2. Trial and error through the validation tool

The MCP server and validation tool work well together, but better documentation delivery would significantly improve the development experience.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 17:15 PST] - MCP Tool Discovery via mcporter

**What I was trying to do:**
Call the `xanoscript_docs` tool directly as mentioned in the task prompt.

**What the issue was:**
The `xanoscript_docs` command was not available directly in the shell. Running `which xanoscript_docs` returned nothing. I had to discover that the Xano MCP was available through `mcporter` instead.

**Why it was an issue:**
The task explicitly said to "call `xanoscript_docs` on the xano MCP" but didn't mention that I needed to use mcporter as the intermediary. I had to:
1. First check what was available in mcporter (`mcporter list`)
2. Then figure out the correct call syntax (`mcporter call xano.xanoscript_docs`)

**Potential solution:**
- The task instructions could mention that tools are accessed via mcporter
- Or have a wrapper script that exposes `xanoscript_docs` directly
- Document the expected access pattern: `mcporter call xano.<tool_name>`

---

## [2025-02-16 17:18 PST] - Missing Topic-Specific Validation Rules

**What I was trying to do:**
Understand the complete validation rules for run.job configurations, specifically around the `main` and `pre` attributes.

**What the issue was:**
The documentation mentioned that run.job requires `main` and run.service uses `pre`, but I initially wondered if I needed both or if there were other required fields I was missing.

**Why it was an issue:**
I had to read the "run" topic documentation carefully to understand:
- run.job requires `main` but cannot use `pre`
- run.service can use `pre` but cannot use `main`
- The `input` values in run.job must be constants (no variables)

**Potential solution:**
- A clearer side-by-side comparison table in the docs would help
- Maybe a "run.job quick reference" cheat sheet with just the essential rules

---

## [2025-02-16 17:22 PST] - Object Array Construction Confusion

**What I was trying to do:**
Build the HubSpot API payload which requires an array of property objects like:
```json
{"properties": [{"property": "email", "value": "test@example.com"}]}
```

**What the issue was:**
I wasn't 100% sure about the object literal syntax in XanoScript. The quickstart docs helped, but I had to double-check:
- Object properties use `:` not `=` (unlike some other languages)
- Arrays are created with `[]` and items added via `|push:` filter

**Why it was an issue:**
Building complex nested structures dynamically requires multiple steps (creating base object, conditionally adding items with push). It works but feels verbose compared to JavaScript's spread operator.

**Potential solution:**
- Document a "building complex payloads" pattern more explicitly
- Show an example of dynamically building an array of objects with conditional items
- Consider if there's a more concise syntax for this common API integration pattern

---

## [2025-02-16 17:25 PST] - Success! First-Time Validation Pass

**What I was trying to do:**
Validate my .xs files after writing them.

**What went well:**
The `validate_xanoscript` MCP tool worked perfectly on the first try! It validated both files simultaneously and gave clear output showing all 2 files were valid.

**Positive feedback:**
- The validation tool accepted an array of file paths, making batch validation easy
- The output was clear: "2 valid, 0 invalid"
- The tool auto-detected the object type from the code syntax (run.job, function)

---

## [2025-02-16 17:28 PST] - Documentation Quality Appreciation

**What I was trying to do:**
Write correct XanoScript without prior knowledge of the syntax.

**What went well:**
The `xanoscript_docs` tool with the `quickstart` topic was excellent. It covered:
- Reserved variable names (saved me from using `$response`)
- Type name differences from other languages (bool vs boolean, text vs string)
- Common mistakes with clear before/after examples
- API request patterns with error handling

**Positive feedback:**
The "Common Mistakes" section was particularly valuable - it prevented errors I might have made like:
- Using `body` instead of `params` for api.request
- Using `else if` instead of `elseif`
- Forgetting parentheses around filtered expressions in comparisons

---

## Summary

**Overall MCP Experience:** Very positive once I figured out the mcporter access pattern.

**Most helpful:**
1. The comprehensive documentation available via `xanoscript_docs`
2. The batch validation tool that just works
3. Clear examples in the quickstart guide

**Areas for improvement:**
1. Clearer instructions on how to access MCP tools (mcporter vs direct)
2. More examples of building complex API payloads with conditional fields
3. A quick reference card for run.job/run.service validation rules

**Did it block development?** No - after initial discovery, everything worked smoothly.

**Time to first working code:** ~15 minutes from reading docs to validated files.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-03 15:35 PST - Object Literal Syntax Confusion

**What I was trying to do:** Create a run.xs file with the correct object syntax for defining a run.job with input parameters.

**What the issue was:** The documentation showed `input: { key: value }` syntax, but when I wrote:
```xs
input: {
  matrix_a: [...]
}
```
(with the opening brace on a new line), I got the error:
```
[Line 4, Column 12] Expecting: Expected an object {}
but found: '{'
```

**Why it was an issue:** The error message was confusing because it said "Expected an object {} but found '{'" - which seems contradictory since `{` IS the start of an object. The real issue was that the opening brace needs to be on the same line as the property name in this context.

**Potential solution (if known):** 
1. The error message could be clearer - something like "Opening brace must be on the same line as the property name"
2. Or the parser could be more lenient about whitespace before the opening brace (like most programming languages)
3. The documentation could explicitly show that the brace must be on the same line with a note/warning

---

## 2025-03-03 15:32 PST - Mixing `:` and `=` in Object Literals

**What I was trying to do:** Understand when to use `:` vs `=` in object definitions within run.xs

**What the issue was:** The syntax requirements are inconsistent and confusing:
- In `main = { ... }`, the outer assignment uses `=`
- Inside `main`, properties use `:` like `name: "..."` and `input: { ... }`
- But then inside `input: { ... }`, it switches back to `=` for the inner object properties

I tried several variations before getting it right:
1. First tried `:` everywhere (like JSON)
2. Then tried `=` everywhere 
3. Finally realized it's `=` for the outer block assignment, `:` for properties

**Why it was an issue:** This mixing of syntax is unintuitive. Most languages use consistent syntax within object literals (JSON uses `:` everywhere, Python uses `=` in function calls but `:` in dict literals).

**Potential solution (if known):** 
1. Make the syntax consistent - either `:` everywhere for key-value pairs, or `=` everywhere
2. Or provide a very clear syntax guide specifically for run.xs files showing the exact pattern

---

## 2025-03-03 15:30 PST - Finding the Right MCP Server Name

**What I was trying to do:** Call the Xano MCP to get documentation

**What the issue was:** The task instructions said to call `xanoscript_docs` but I had to first discover that:
1. The MCP server is named "xano" not "xanoscript_docs"
2. The tool is `xano.xanoscript_docs`

**Why it was an issue:** The task said "call `xanoscript_docs` on the Xano MCP" but didn't specify the full tool path format or how to discover available tools.

**Potential solution (if known):** 
1. The task instructions could include the exact mcporter command: `mcporter call xano.xanoscript_docs topic: "..."`
2. Or provide a quick reference for how to list available MCP servers and tools

---

## 2025-03-03 15:25 PST - Understanding the Run Job Structure

**What I was trying to do:** Understand the relationship between run.job and functions

**What the issue was:** The task says "a run job that calls a function" but it took me a moment to understand:
1. run.xs defines the run.job with a `main` block
2. The function is defined separately in function/*.xs
3. The function must be called via `function.run` within the stack, OR via the `main` reference in run.job

Actually, looking at the documentation again, the `main` block in run.job directly references the function name - it doesn't use `function.run` syntax there. The `function.run` syntax is used inside a function's stack block.

**Why it was an issue:** The distinction between defining what function to run (in run.job) vs calling a function from within another function's logic wasn't immediately clear.

**Potential solution (if known):** 
1. A simple diagram in the docs showing: run.job → calls function → which may call other functions
2. Clearer naming - maybe `run.job` should use `function:` instead of `main:` to be consistent with `function.run`

---

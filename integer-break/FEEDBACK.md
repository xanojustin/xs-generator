# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 16:05 PST] - MCP file_paths parameter parsing issue

**What I was trying to do:** Validate multiple files by passing file_paths parameter with comma-separated paths

**What the issue was:** The mcporter call with `file_paths=/path1,/path2` interpreted the comma as a separator and tried to validate each character as a separate file path, resulting in errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** Could not use the documented file_paths array parameter via CLI

**Potential solution:** The CLI should properly parse comma-separated values for array parameters, or the documentation should clarify the correct syntax for passing multiple file paths via mcporter call.

**Workaround used:** Used `directory` parameter instead to validate all files in the folder.

---

## [2026-02-24 16:08 PST] - Conditional block syntax confusion

**What I was trying to do:** Write a conditional block with multiple independent if statements for base case handling

**What the issue was:** The parser expected `elseif` instead of a second `if`. The error message "Expecting: one of these possible Token sequences: [if] but found: 'if'" was confusing because it says it expected `if` but found `if`.

**Why it was an issue:** Unclear that conditional blocks only allow one `if` at the start, followed by `elseif` chains. Two separate `if` statements need separate `conditional` blocks.

**Potential solution:** Improve the error message to say something like "Use 'elseif' instead of consecutive 'if' statements within a conditional block" or clarify that multiple independent conditions require separate conditional blocks.

---

## [2026-02-24 16:10 PST] - Backtick expression syntax for conditionals

**What I was trying to do:** Write while loops and if conditions without backticks

**What the issue was:** All conditional expressions (`if`, `while`, `elseif`) require backticks around the comparison expression

**Why it was an issue:** Coming from other languages, it's not intuitive that `if ($x > 5)` needs to be `if (`$x > 5`)`. The error messages were not clear about this requirement.

**Potential solution:** 
1. Add a more prominent note in the quickstart documentation about backticks being required for ALL conditional expressions
2. Improve error messages to suggest adding backticks when a comparison operator is detected without them

---

## [2026-02-24 16:12 PST] - Quick reference documentation gaps

**What I was trying to do:** Find syntax examples for common patterns like loops and conditionals

**What the issue was:** The cheatsheet topic returned empty content (just "XanoScript Cheat Sheet" header)

**Why it was an issue:** Had to search through full documentation instead of having a quick reference

**Potential solution:** Populate the cheatsheet topic with actual quick reference content, or update the documentation to indicate which topics are fully implemented.

---

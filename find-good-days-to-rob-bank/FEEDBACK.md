# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 08:33 PST] - run.job Syntax Confusion

**What I was trying to do:** Create a run job that calls a function with test inputs and returns/logs the results.

**What the issue was:** I initially wrote the run.xs file using a `run.job { ... }` syntax with a `stack` block and `response`, similar to how functions work. The validator rejected this with error "Expecting one of these possible Token sequences: 1. ["..."] 2. [Identifier] but found: '{'"

**Why it was an issue:** I didn't know that run.job requires a quoted name string (like `run.job "Job Name" { ... }`) and uses a `main` property to specify the function to call, rather than having its own stack block. The documentation I retrieved only showed the quick reference which had minimal syntax information.

**Potential solution:** 
1. The quick reference for run jobs should include a complete minimal example showing the quoted name and main property
2. The error message could be more helpful - something like "run.job requires a quoted name string, e.g., run.job 'Job Name' { ... }"

---

## [2025-02-26 08:35 PST] - MCP Documentation Mode

**What I was trying to do:** Get comprehensive XanoScript documentation to write correct code.

**What the issue was:** The `mode=quick_reference` option returns very minimal information. For run jobs, it only showed the directory structure without any syntax examples. I had to call `mode=full` to get the actual syntax.

**Why it was an issue:** Quick reference mode should still include the basic syntax patterns for each construct. Without the full mode, I couldn't see that run.job requires a name string and uses `main` property.

**Potential solution:**
1. Include at least one complete minimal example in quick_reference mode for each topic
2. Or suggest in the quick_reference output that users should call with mode=full for complete syntax

---

## [2025-02-26 08:36 PST] - Overall MCP Experience

**Positive:**
- The validate_xanoscript tool works well and gives clear line/column error locations
- The xanoscript_docs tool provides comprehensive documentation when using mode=full
- Having the MCP integrated with mcporter makes it easy to call from CLI

**Suggestions for improvement:**
1. Add a `topic=syntax_errors` or similar that documents common syntax mistakes and their corrections
2. Provide a `validate_and_fix` mode that suggests fixes for common errors
3. Include more cross-references in documentation (e.g., when showing function syntax, mention how to call it from run.job)

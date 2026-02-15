# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 15:25 PST] - xanoscript_docs Topic Parameter Not Working

**What I was trying to do:**
Retrieve specific XanoScript documentation for different topics (quickstart, syntax, functions, integrations, run) to understand how to write XanoScript code for a run job.

**What the issue was:**
Calling `xanoscript_docs` with different topic parameters (quickstart, syntax, functions, integrations, run) all returned the exact same general documentation - the XanoScript overview/README content. The topic parameter had no effect on the output.

Example commands that returned identical content:
- `mcporter call xano xanoscript_docs '{"topic": "quickstart"}'`
- `mcporter call xano xanoscript_docs '{"topic": "syntax"}'`
- `mcporter call xano xanoscript_docs '{"topic": "run"}'`

**Why it was an issue:**
Without topic-specific documentation, I couldn't learn the detailed syntax patterns needed to write correct XanoScript. I had to examine existing implementations in the ~/xs folder to understand the actual syntax.

**Potential solution (if known):**
The MCP server should return topic-specific documentation when a topic is specified, or the documentation index should be updated to reflect what topics are actually available.

---

## [2025-02-15 15:30 PST] - validate_xanoscript Difficult to Call via mcporter CLI

**What I was trying to do:**
Validate XanoScript code files using the `validate_xanoscript` tool through the mcporter CLI.

**What the issue was:**
The mcporter CLI had significant difficulty passing multi-line XanoScript code to the validate_xanoscript tool. Multiple approaches failed:

1. Direct string passing with shell escaping resulted in JSON parsing errors
2. Using stdin (`-`) caused the MCP to receive garbled input (expecting 'function' but found '-')
3. Shell variable interpolation with `sed` and `tr` produced malformed JSON
4. The `mcporter call xano validate_xanoscript` syntax worked differently than expected

The only working solution was to use Python to make direct JSON-RPC calls to the MCP server via stdio.

**Why it was an issue:**
Validating code is a core workflow step. The difficulty in calling the validation tool adds friction and time to the development process.

**Potential solution (if known):**
- Provide a simpler CLI interface like `mcporter validate file.xs`
- Support file path as a parameter in addition to code string
- Improve stdin handling for multi-line content

---

## [2025-02-15 15:35 PST] - xanoscript_docs Missing Syntax Details

**What I was trying to do:**
Learn the specific syntax for XanoScript constructs like `run.job`, variable declaration, conditionals, and API requests.

**What the issue was:**
The documentation returned by `xanoscript_docs` was high-level and overview-style. It mentioned constructs like `run.job`, `function`, `query`, etc., but didn't provide detailed syntax patterns for:
- How to structure a `run.job` definition
- The exact syntax for variable declaration (`var $name { value = ... }`)
- How to write conditionals (`conditional { if (...) { ... } }`)
- API request syntax and available options
- The proper way to access environment variables

**Why it was an issue:**
Without detailed syntax documentation, I had to reverse-engineer the correct patterns by reading existing working implementations from other run jobs in the ~/xs folder.

**Potential solution (if known):**
Add detailed syntax documentation with examples for each XanoScript construct. Include a comprehensive quick reference guide showing actual code patterns.

---

## [2025-02-15 15:40 PST] - No Clear Documentation on Run Job Structure

**What I was trying to do:**
Understand the proper file structure for a Xano Run Job (run.xs vs run.job.xs, folder organization).

**What the issue was:**
The documentation didn't clearly explain:
- The difference between run job files and regular function files
- The proper naming convention (run.xs contains `run.job` construct)
- How the `main` parameter in run.job maps to a function
- That function files go in a `function/` subdirectory

**Why it was an issue:**
I had to examine multiple existing implementations to understand the proper structure:
- run.xs contains a `run.job` construct
- The `main.name` references a function defined in `function/{name}.xs`
- The function uses the `function "name" { ... }` construct

**Potential solution (if known):**
Add a "Run Job Quickstart" topic to xanoscript_docs with a complete example showing file structure, run.xs content, function file content, and how they connect.

---

## [2025-02-15 15:45 PST] - Documentation Lists Invalid Topics

**What I was trying to do:**
Find the available documentation topics to learn XanoScript.

**What the issue was:**
The documentation index lists many topics (quickstart, syntax, types, functions, apis, tasks, run, etc.) but when calling `xanoscript_docs` with these topics, they all return the same general documentation. The actual detailed documentation for these topics may not exist or isn't being returned.

**Why it was an issue:**
Wasted time trying different topics expecting different documentation, when the same content was returned each time.

**Potential solution (if known):**
- Either implement the topic-specific documentation
- Or update the index to only list topics that actually return unique content
- Or return an error/notice when a topic isn't fully implemented

---

## [2025-02-15 15:50 PST] - Missing Filter and Function Reference

**What I was trying to do:**
Learn about available filters (like `|trim`, `|lower`, `|strlen`) and built-in functions for XanoScript.

**What the issue was:**
The documentation mentions filters exist and shows basic examples (`$value|trim|lower`), but doesn't provide:
- A complete list of available filters
- What each filter does
- Filter parameters (like `|round:2`)
- Built-in functions available in the stack context

**Why it was an issue:**
Had to copy filter usage from existing code without understanding what filters are available or how they work.

**Potential solution (if known):**
Add a comprehensive filter and function reference to the syntax documentation.

---

## Summary

The Xano MCP server provides useful functionality (validation works well when called correctly), but the documentation system needs improvement. The main pain points were:

1. **Documentation Quality**: Topic-specific docs return the same general content
2. **CLI Usability**: Validating files is unnecessarily difficult
3. **Missing Reference**: No detailed syntax guide for constructs like run.job, conditionals, API requests
4. **Learning Curve**: Had to reverse-engineer patterns from existing code

The validation tool itself works correctly and caught no errors in my code, which is great! The issue is primarily with the documentation and CLI interface.
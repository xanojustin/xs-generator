# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-18 04:20 PST - Filter Function Discovery Issue

**What I was trying to do:**
Validate an email address format by checking if it contains an "@" symbol using a precondition.

**What the issue was:**
I used the filter `match` (as in `$input.email|match:"@"`) which I incorrectly assumed existed based on common programming patterns. The validation failed with "Unknown filter function 'match'".

**Why it was an issue:**
I had to look up the syntax documentation to find the correct filter. The error message was clear, but I spent time searching for the right filter to use.

**Potential solution (if known):**
- A more comprehensive quick reference of ALL available filters would be helpful
- IDE/editor integration with autocomplete could prevent this
- Maybe a `regex_match` shorthand like `match` would be intuitive for developers

---

## 2025-02-18 04:18 PST - Documentation Lookup Time

**What I was trying to do:**
Get the correct XanoScript syntax for run jobs and API calls before writing code.

**What the issue was:**
The documentation via `xanoscript_docs` is comprehensive but requires multiple calls to get all the needed information (run jobs, syntax, external APIs, quickstart).

**Why it was an issue:**
Each documentation call takes time (1-2 seconds) and I needed to make 4-5 calls to gather all the necessary context. For AI code generation, having a single "run job template" or "quick reference for common patterns" would be more efficient.

**Potential solution (if known):**
- A single `xanoscript_docs({ topic: "run-job-template" })` that includes everything needed for a run job
- Better organization of the quickstart to include run job specific patterns

---

## 2025-02-18 04:15 PST - Filter Naming Discoverability

**What I was trying to do:**
Understand what string matching filters are available.

**What the issue was:**
The filter `contains` exists but I initially looked for `match`, `has`, `includes`, or other common naming patterns from other languages.

**Why it was an issue:**
Filter names don't always match what developers expect from other languages (e.g., JavaScript's `includes()`, Python's `in` operator).

**Potential solution (if known):**
- Add aliases for common filter names (`match` → `contains`, `includes` → `contains`)
- Include "also known as" references in documentation
- A filter search function: `xanoscript_docs({ filter: "match" })` that suggests `contains`

---

## General Observations

**What worked well:**
- The `validate_xanoscript` tool is excellent - caught my error immediately with clear line/column information
- The MCP server is fast and responsive
- The directory-based validation made it easy to validate all files at once

**What could be improved:**
- Having to call `xanoscript_docs` multiple times to get complete context is slow for AI workflows
- No single-page reference for "building a run job from scratch"
- Filter discovery could be easier with aliases or fuzzy matching

**Overall experience:**
The development experience was smooth once I had the right documentation. The validation tool saved me from pushing broken code. The main friction was discovering the correct syntax/filters, which improved as I learned the patterns.

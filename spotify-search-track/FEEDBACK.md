# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 16:15 PST] - Missing base64_encode Filter Documentation

**What I was trying to do:**
Create a Spotify API integration that requires base64 encoding of client credentials for the OAuth token request.

**What the issue was:**
I used `$credentials|base64_encode` assuming it exists as a filter (similar to `url_encode`), but I'm not 100% certain this filter exists in XanoScript. The syntax documentation I retrieved didn't include a comprehensive list of available filters.

**Why it was an issue:**
Without a complete filter reference, I'm guessing at available filters. Common encoding filters like base64_encode, url_encode, json_encode should be documented in one place.

**Potential solution (if known):**
Add a comprehensive filters reference topic to xanoscript_docs that lists all available filters with descriptions and examples.

---

## [2026-02-14 16:15 PST] - Limited Error Information on Validation

**What I was trying to do:**
Validate XanoScript code using the MCP validate_xanoscript tool.

**What the issue was:**
When validation passes, it just says "XanoScript is valid. No syntax errors found." When I intentionally made errors during testing, I didn't get detailed error messages with line numbers.

**Why it was an issue:**
For a code validation tool, detailed error reporting (line numbers, specific syntax issues) would be much more helpful than binary pass/fail.

**Potential solution (if known):**
Enhance validate_xanoscript to return structured error objects with:
- Line number
- Column position
- Error message
- Suggested fix if available

---

## [2026-02-14 16:15 PST] - Documentation Mode Confusion

**What I was trying to do:**
Get documentation for run jobs and XanoScript syntax.

**What the issue was:**
The difference between `mode=quick_reference` and `mode=full` wasn't immediately clear. I tried quick_reference first for efficiency but it was missing important details like the foreach syntax and variable update patterns.

**Why it was an issue:**
Had to make multiple calls to get complete information. A single comprehensive quick reference that includes common patterns would be more efficient.

**Potential solution (if known):**
Consider a `mode=patterns` that focuses on common code patterns (loops, conditionals, API requests) rather than just syntax reference.

---

## [2026-02-14 16:15 PST] - No URL Encoding Filter Confirmed in Docs

**What I was trying to do:**
URL-encode the search query for the Spotify API request.

**What the issue was:**
I used `|url_encode` filter but couldn't confirm it exists from the documentation. The filter was not mentioned in the syntax quick reference.

**Why it was an issue:**
I'm uncertain if my code will actually work at runtime. The validation passed, but that doesn't mean the filter exists.

**Potential solution (if known):**
Include a complete filter catalog in the documentation, organized by category (string, encoding, array, object, etc.)

---

## [2026-02-14 16:15 PST] - Array/Object Manipulation Unclear

**What I was trying to do:**
Build an array of formatted track objects by iterating over the Spotify API response.

**What the issue was:**
The syntax for pushing items to arrays and the foreach loop structure wasn't clearly documented. I had to infer it from examples in the run job documentation.

**Why it was an issue:**
Array manipulation is common in API integrations. Not having clear documentation for `|push`, `|set`, and foreach patterns makes development harder.

**Potential solution (if known):**
Add a dedicated "Working with Arrays and Objects" section to the documentation with examples of:
- Building arrays iteratively
- Accessing nested object properties
- Setting/updating object properties
- Common array filters (push, pop, map, filter if available)

---

## [2026-02-14 16:15 PST] - var.update vs var Syntax Confusion

**What I was trying to do:**
Update a variable's value inside a conditional block.

**What the issue was:**
I saw `var.update` in one example but `var` declaration syntax in another. It's unclear when to use `var.update` versus redeclaring with `var`.

**Why it was an issue:**
In my foreach loop, I'm using `var $formatted_tracks { value = ... }` which might be shadowing rather than updating. The scoping rules aren't clear.

**Potential solution (if known):**
Clarify in the documentation:
- Variable scoping rules (function-level vs block-level)
- When to use var.update vs var
- Whether redeclaring a var inside a loop creates a new variable or updates the existing one

---

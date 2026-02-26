# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 01:32 PST] - Nested Array Type Declaration

**What I was trying to do:** Define an input parameter for a 2D array (array of string pairs) to represent travel paths like `["London", "New York"]`.

**What the issue was:** I initially tried `text[][] paths` but this is not valid XanoScript syntax. The validation error said: "Expecting token of type --> Identifier <-- but found --> '[' <--" with suggestion to use "type[]" instead of "array".

**Why it was an issue:** The error message was slightly confusing because it suggested using `type[]` format, but `text[][]` is already in that format - just with nesting. The real issue is that XanoScript doesn't support nested array type declarations.

**Potential solution:** 
1. Better error message for nested arrays suggesting `json` type
2. Document more explicitly that multi-dimensional arrays require `json` type
3. Consider supporting nested array syntax like `text[][]` in the language

---

## [2025-02-26 01:33 PST] - MCP Tool Parameter Format

**What I was trying to do:** Validate multiple files at once using the `validate_xanoscript` tool.

**What the issue was:** I tried using `file_paths=/Users/justinalbrecht/xs/destination-city/run.xs,/Users/justinalbrecht/xs/destination-city/function/find_destination_city.xs` (comma-separated) but the MCP parsed each character after the comma as separate file paths, resulting in errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** The tool expects an array format but the CLI interface doesn't handle comma-separated values correctly. I had to fall back to validating files one at a time.

**Potential solution:** 
1. Document the correct format for passing arrays via CLI
2. Handle comma-separated values properly in the MCP
3. Add an example for batch validation in the tool description

---

## Overall Development Experience

**What worked well:**
- The `xanoscript_docs` tool is very helpful with detailed examples
- The validation tool gives specific line/column numbers and helpful suggestions
- The quickstart guide covers common mistakes effectively

**What could be improved:**
- More examples of complex input types (nested arrays, objects with arrays, etc.)
- Clearer documentation on the differences between `object` with schema vs `json`
- More function examples showing how to manipulate arrays (the `slice` filter wasn't obvious)

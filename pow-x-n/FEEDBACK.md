# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-21 19:15 PST] - Float type confusion

**What I was trying to do:** Define input parameters for a function that takes floating-point numbers

**What the issue was:** I used `float` as the type name (common in many languages), but XanoScript uses `decimal` for floating-point numbers. The error message was "Expecting --> } <-- but found --> 'float'" which wasn't immediately clear.

**Why it was an issue:** The error message didn't directly say "unknown type float" - instead it said it was expecting a closing brace, which made me think there was a syntax error in my braces. The hint "Suggestion: Use 'decimal' instead of 'number'" was also a bit confusing since I used "float" not "number".

**Potential solution:** 
- Add "float" as an alias for "decimal" since many developers are used to this type name
- Or improve the error message to say something like "Unknown type 'float'. Did you mean 'decimal'?"

---

## [2026-02-21 19:18 PST] - One function per file limitation

**What I was trying to do:** Create a helper function in the same file as the main function (similar to how JavaScript/TypeScript allows multiple exports)

**What the issue was:** The error "Redundant input, expecting EOF but found: // Helper function..." wasn't clear that XanoScript only allows one function definition per file. I thought it was a syntax error.

**Why it was an issue:** Many languages allow multiple function definitions in a single file. The error message didn't explain *why* the input was "redundant" - it should explicitly say something like "Only one function definition is allowed per .xs file. Please move the second function to a separate file."

**Potential solution:**
- Improve error message to explicitly state the one-function-per-file rule
- Or update documentation to prominently mention this constraint

---

## [2026-02-21 19:10 PST] - Directory path expansion

**What I was trying to do:** Validate files using the directory parameter with `~/xs/pow-x-n`

**What the issue was:** The MCP server reported "No .xs files found in directory: ~/xs/pow-x-n" - it didn't expand the tilde (~) to the home directory.

**Why it was an issue:** Shell users commonly use ~ as shorthand for home directory. I had to switch to the absolute path `/Users/justinalbrecht/xs/pow-x-n` for it to work.

**Potential solution:** 
- Expand ~ to $HOME in file paths within the MCP server
- Or document that absolute paths are required

---

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 15:05 PST] - One function per file restriction not obvious

**What I was trying to do:** Create a helper function within the same .xs file as the main function, similar to how many programming languages allow multiple function definitions in one file.

**What the issue was:** The error message "Redundant input, expecting EOF but found: function" was cryptic. It took me a moment to realize that each .xs file can only contain ONE function definition. The parser expects EOF after the first function closes.

**Why it was an issue:** This wasn't documented clearly in the quick reference I received. I had to learn through trial and error. This is a significant architectural constraint that should be highlighted upfront.

**Potential solution (if known):** 
- Add a clear note in the `functions` documentation: "Each .xs file may contain only ONE function definition. Create separate files for helper functions."
- Improve the error message to say something like: "Only one function definition allowed per .xs file. Move additional functions to separate files."

---

## [2025-02-27 15:06 PST] - Directory path expansion not working with ~

**What I was trying to do:** Validate files using `directory=~/xs/convert-sorted-list-to-bst`

**What the issue was:** The MCP tool returned "No .xs files found in directory" when using the tilde (`~`) shorthand for the home directory. I had to use the full absolute path `/Users/justinalbrecht/xs/convert-sorted-list-to-bst`.

**Why it was an issue:** Shell users expect `~` to expand to their home directory. Having to type the full path is inconvenient.

**Potential solution (if known):** 
- Expand `~` to the user's home directory in the validate_xanoscript tool before checking for files
- Or document that absolute paths are required

---

## [2025-02-27 15:08 PST] - No struggles with syntax once documentation was available

**What I was trying to do:** Write XanoScript code for the exercise

**What the issue was:** Actually, once I had the documentation from `xanoscript_docs`, the syntax was clear and well-documented. The quick reference format was helpful.

**Why it was NOT an issue:** The documentation provided clear examples for:
- Function structure
- Run job structure
- Conditional statements
- Variable declarations
- Filter usage with parentheses

**Positive feedback:** The syntax is intuitive and the documentation is comprehensive. The explicit requirement to call `xanoscript_docs` before writing code was crucial - without it, I would have made many incorrect assumptions.

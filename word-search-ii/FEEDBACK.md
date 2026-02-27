# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-26 16:35 PST - Loop Syntax Confusion

**What I was trying to do:** Implement a word search II algorithm that requires iterating over arrays (words and characters).

**What the issue was:** I initially wrote the loop syntax as `each ($array as $item)` which is common in many languages (PHP, JavaScript for-of, etc.), but XanoScript requires a different pattern: `foreach ($array) { each as $item }`.

**Why it was an issue:** The error message was "Expecting --> } <-- but found --> 'each'" which didn't clearly explain the syntax issue. I had to look up the functions documentation to find the correct pattern.

**Potential solution (if known):** 
- The error message could be more helpful, like: "Invalid loop syntax. Use 'foreach ($array) { each as $item }' instead of 'each ($array as $item)'"
- The quickstart documentation could include a more prominent "Common Loop Mistakes" section

---

## 2025-02-26 16:30 PST - Documentation Discovery

**What I was trying to do:** Find the correct XanoScript syntax before writing code.

**What the issue was:** Had to call multiple documentation topics (quickstart, run, functions) to piece together the correct syntax patterns. The quick_reference mode gave an overview but didn't include loop syntax details.

**Why it was an issue:** Took multiple API calls to gather all necessary information. Some key syntax patterns (like loops) were in the functions topic which wasn't obvious from the quick reference.

**Potential solution (if known):** 
- A "syntax cheatsheet" or "common patterns" doc that includes: variable declaration, conditionals, loops (for/while/foreach), and function calls all in one place
- The quick_reference could include a small section on control flow syntax

---

## 2025-02-26 16:45 PST - Validation Path Resolution

**What I was trying to do:** Validate my XanoScript files using the MCP.

**What the issue was:** Initially tried relative paths (`function/word_search_ii.xs`) from the project directory, but the validator returned "File not found". Had to use absolute paths.

**Why it was an issue:** Minor inconvenience - requires knowing to use absolute paths or full paths.

**Potential solution (if known):** 
- The validate tool could support a `working_directory` parameter
- Or at least document in the tool description that absolute paths are required

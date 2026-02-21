# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 06:05 PST] - MCP Tool Parameter Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The mcporter CLI parameter format was unclear. I tried multiple approaches:
1. `--files` parameter (which doesn't exist)
2. JSON piped via stdin with `--raw -` (didn't work - tool received `-` as code)
3. Various JSON formats that failed

**Why it was an issue:** I wasted significant time trying to figure out the correct way to pass parameters to the validation tool. The error messages were confusing because the tool was interpreting the flags as XanoScript code.

**Potential solution (if known):** 
- Document the `key:value` format more prominently in the mcporter help
- Add examples showing the correct parameter format: `mcporter call xano validate_xanoscript file_path:/path/to/file.xs`
- The `key=value` format mentioned in help works too: `file_path=/path/to/file.xs`

---

## [2025-02-21 06:08 PST] - Documentation Discovery

**What I was trying to do:** Understand XanoScript syntax for run jobs and functions

**What the issue was:** Had to call multiple `xanoscript_docs` queries to get complete information. The docs are comprehensive but spread across multiple topics.

**Why it was an issue:** Had to make 4 separate doc calls (main docs, quickstart, functions, run) to get enough context to write the code. This consumed a lot of context window.

**Potential solution (if known):**
- A single "getting started for developers" topic that combines the essential syntax patterns
- Or a topic specifically for "writing functions and run jobs" that covers both in one place

---

## [2025-02-21 06:10 PST] - String Split Syntax Clarification

**What I was trying to do:** Split a string by spaces to get words

**What the issue was:** Needed to confirm the exact syntax for `split` filter with a space delimiter

**Why it was an issue:** The documentation shows `$text|split:"delim"` format but I wanted to be sure about escaping the space character.

**What worked:** `$trimmed|split:" "` worked correctly on first validation

---

## Overall Experience

**Positive:**
- Once I figured out the mcporter call format, validation was fast and accurate
- The XanoScript syntax was clear from the documentation
- Both files validated on first attempt - the docs were sufficient

**Areas for improvement:**
- mcporter CLI parameter passing could be more intuitive
- A consolidated "quick reference for developers" doc topic would save context window

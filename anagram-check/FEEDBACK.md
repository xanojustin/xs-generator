# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 18:30 PST] - Successful Implementation

**What I was trying to do:** Create an anagram detection function using XanoScript

**What happened:** The implementation worked on the first validation attempt with no errors

**Why this is worth noting:** The MCP validation tool and documentation were sufficient to write correct XanoScript code without iteration

---

## [2025-02-18 18:30 PST] - mcporter call syntax confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter CLI

**What the issue was:** The correct syntax for passing array parameters wasn't immediately obvious. I tried several approaches:
- JSON format: `'{"file_paths": [...]}'` - didn't work
- Square brackets without quotes: `file_paths:=[...]` - shell interpreted them
- Finally worked with: `'file_paths=["..."]'` (quoted entire key=value, escaped inner quotes)

**Why it was an issue:** Trial and error was needed to find the right syntax. The mcporter help doesn't clearly show examples for array parameters.

**Potential solution:** Add examples to mcporter help showing how to pass array and object parameters, e.g.:
```
mcporter call xano.validate_xanoscript 'file_paths=["/path/to/file.xs"]'
```

---

## General Feedback

**What worked well:**
- The `xanoscript_docs` MCP tool provided comprehensive documentation
- Existing implementations in `~/xs/` served as excellent reference material
- The validation tool gave clear pass/fail feedback
- XanoScript syntax was intuitive for someone familiar with declarative languages

**Positive observations:**
- The function structure (input/stack/response) is clean and easy to understand
- Filter/pipe syntax (`|to_lower`, `|split:""`) is expressive and readable
- Built-in functions like `regex_replace`, `sort`, `reverse` cover common use cases

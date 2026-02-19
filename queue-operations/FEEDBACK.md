# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 05:05 PST] - Array default value syntax confusion

**What I was trying to do:** Create an optional array input parameter with an empty array as the default value.

**What the issue was:** I initially wrote `text[] initial_queue?=[]` following the pattern for optional fields with defaults, but this syntax is not valid for arrays. The validator gave a cryptic error about expecting identifiers but finding `[`.

**Why it was an issue:** This blocked initial validation and required me to restructure the approach. I had to change from `text[] initial_queue?=[]` to `text[]? initial_queue` and handle the null case in the stack with `$input.initial_queue ?? []`.

**Potential solution:** 
- Allow `=[]` default syntax for arrays similar to other types
- Or provide a clearer error message like "Array default values are not supported in input blocks. Use a nullable type and handle null in the stack with ?? []"
- Documentation should explicitly mention that array defaults work differently than scalar defaults

---

## [2025-02-19 05:06 PST] - No other issues encountered

**What I was trying to do:** Complete the queue implementation with conditionals, loops, and filters.

**What the issue was:** None - after fixing the array default issue, the code validated successfully on the second attempt.

**Why it was an issue:** N/A

**Potential solution:** The MCP validation worked well once the syntax was correct. The error messages were helpful in pinpointing the exact line and column.

---

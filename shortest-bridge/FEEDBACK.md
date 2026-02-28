# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 03:33 PST] - MCP Tool Input Format Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter to validate my .xs files

**What the issue was:** The mcporter call format for JSON parameters was unclear. I tried multiple formats:
- `mcporter call xano xanoscript_docs --input '{"topic": "essentials"}'` - didn't work
- `mcporter call xano xanoscript_docs '{"topic": "essentials"}'` - didn't work
- `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` - didn't work

**Why it was an issue:** I had to experiment with 4+ different syntaxes before finding that `key:value` format works: `mcporter call xano validate_xanoscript directory:/Users/justinalbrecht/xs/shortest-bridge`

**Potential solution:** Add examples in the mcporter help output showing the `key:value` syntax for JSON objects. The current help only shows `mcporter call linear.list_issues team=ENG limit:5` style for simple values, not complex parameters.

---

## [2025-02-28 03:35 PST] - XanoScript Filter Expression Syntax

**What I was trying to do:** Write a while loop that checks if a stack has items using `while ($stack|count > 0)`

**What the issue was:** Got validation error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message was helpful but I had to look at existing code examples to understand the pattern. The fix is `while (($stack|count) > 0)` but this wasn't obvious from just the error.

**Potential solution:** 
1. Include this specific pattern in the syntax documentation examples
2. The error could suggest the fix: "Try: while (($stack|count) > 0)"

---

## [2025-02-28 03:36 PST] - XanoScript Slice Syntax

**What I was trying to do:** Remove the last element from an array using slice: `$stack|slice:0,($stack|count - 1)`

**What the issue was:** Got validation error about expecting `}` but found `(`. The comma syntax and arithmetic inside slice doesn't work as expected.

**Why it was an issue:** Had to grep through existing code to find the pattern: `$stack|slice:0:(($stack|count) - 1)` with double parentheses for arithmetic.

**Potential solution:** 
1. Document the slice filter syntax more explicitly with examples showing arithmetic
2. Add examples like: `array|slice:0:-1` (remove last), `array|slice:0:(($array|count) - 1)` (same but explicit)

---

## [2025-02-28 03:38 PST] - XanoScript Variable Scope Bug (Almost)

**What I was trying to do:** Update visited matrix in BFS section using `$c` variable

**What the issue was:** I accidentally used `$c` instead of `$nc` in one place: `$visited[$nr]|slice:0,$nc ~ [true] ~ $visited[$nr]|slice:($c + 1)` - the last `$c` should have been `$nc`

**Why it was an issue:** This would have been a runtime error or silent bug. The validation passed because `$c` was defined earlier in a different scope (DFS section), but it would have the wrong value.

**Potential solution:** XanoScript could warn about variable usage that might be cross-scope errors. This is probably complex to implement though.

---

## [2025-02-28 03:40 PST] - Documentation Topic Loading Issues

**What I was trying to do:** Load specific documentation topics like `essentials`, `functions`, `run`

**What the issue was:** The mcporter calls weren't returning the topic-specific content - they all returned the README content instead

**Why it was an issue:** I couldn't get detailed syntax documentation for specific topics, had to rely on existing code examples

**Potential solution:** Investigate why the topic parameter isn't working correctly in the MCP tool. The documentation says `xanoscript_docs({ topic: "essentials" })` should work but it returned README content instead.

---

## Summary

Overall the validation tool was very helpful once I figured out the correct mcporter syntax. The error messages were reasonably clear and helped me fix issues quickly. The main pain points were:

1. **Tool calling syntax** - key:value format isn't well documented
2. **Slice/filter syntax** - needed to look at existing code for patterns
3. **Topic-specific docs** - couldn't load detailed docs for specific topics

The existing exercises in `~/xs/` were invaluable as reference - I relied heavily on them to understand correct syntax patterns.

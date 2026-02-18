# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 10:47 PST] - MCP Daemon Confusion

**What I was trying to do:**
Start the mcporter daemon to use the Xano MCP tools.

**What the issue was:**
I tried `mcporter start` and `mcporter daemon start` but both failed. The error said "No MCP servers are configured for keep-alive; daemon not started."

**Why it was an issue:**
I thought I needed to start a daemon/server before calling tools. This was confusing because the docs didn't clarify that stdio-based MCP servers (like Xano's via npx) don't need a daemon - you can call them directly with `mcporter call xano.<tool>`.

**Potential solution (if known):**
Add a note in the MCP tool descriptions or help text that explains: "For stdio-based MCP servers (npx), no daemon is needed - use `mcporter call` directly."

---

## [2025-02-18 10:48 PST] - xanoscript_docs Quick Reference Too Minimal

**What I was trying to do:**
Get documentation for writing a run.job using `xanoscript_docs` with `mode="quick_reference"`.

**What the issue was:**
The quick_reference mode for the "run" topic only returned about 10 lines of content - just the basic structure with no examples or property descriptions. It showed the syntax but not what properties were available or required.

**Why it was an issue:**
I had to make a second call with `mode="full"` to get the actual documentation I needed (properties table, examples, validation rules). This wastes API calls and time.

**Potential solution (if known):**
Either:
1. Include the properties table and at least one complete example in quick_reference mode
2. Document what topics are "thin" in quick mode so users know to request full mode
3. Add a note: "For run jobs, quick_reference only shows structure - use mode='full' for complete docs"

---

## [2025-02-18 10:49 PST] - api.request params Naming Confusion

**What I was trying to do:**
Understand how to send query parameters in a GET request to CoinGecko.

**What the issue was:**
The documentation says: "Important: The `params` parameter is used for the request body (POST/PUT/PATCH), not query parameters." This is counterintuitive naming since "params" usually means query params in most HTTP libraries.

**Why it was an issue:**
I had to manually construct the URL with query string concatenation (`url = "...?ids=" ~ $input.coin_ids ~ "&vs_currencies=" ~ $input.vs_currencies`) instead of having a cleaner way to specify query parameters.

**Potential solution (if known):**
Add a `query` parameter to `api.request` specifically for URL query parameters, or rename `params` to `body` to make it clearer.

---

## [2025-02-18 10:50 PST] - Function Input Block Syntax Gotcha

**What I was trying to do:**
Write a function with an empty input block.

**What the issue was:**
The documentation mentions: "IMPORTANT: braces must be on separate lines" for empty input blocks. I didn't hit this issue because my function has inputs, but this seems like a parser quirk that could be fixed.

**Why it was an issue:**
This is an unusual constraint that differs from most languages where `input {}` would work fine. Users will inevitably trip over this.

**Potential solution (if known):**
Fix the parser to handle `input {}` on a single line, or at least provide a clearer error message when users make this mistake.

---

## [2025-02-18 10:51 PST] - String Concatenation Operator Documentation

**What I was trying to do:**
Concatenate strings to build a URL with query parameters.

**What the issue was:**
I found the `~` operator in the external-apis example, but there was no clear documentation about string operators in the quick reference. I had to infer it was the concatenation operator.

**Why it was an issue:**
Without clear documentation, I wasn't sure if `~` was the right operator or if there were other string manipulation functions I should use.

**Potential solution (if known):**
Add a "String Operators" section to the syntax documentation, clearly showing:
- `~` for concatenation
- Other string manipulation options

---

## [2025-02-18 10:52 PST] - No Inline Documentation for Filters

**What I was trying to do:**
Understand if there were any useful filters for my response (like formatting numbers).

**What the issue was:**
The documentation mentions filters like `|count` and `|first` but doesn't provide a comprehensive list of available filters or what they do.

**Why it was an issue:**
I wanted to format the crypto prices nicely but couldn't find documentation on number formatting filters.

**Potential solution (if known):**
Add a complete filter reference to the syntax topic, including:
- String filters
- Number filters  
- Date/time filters
- Array filters

---

## [2025-02-18 10:53 PST] - Positive: Validation Tool Works Great

**What I was trying to do:**
Validate my XanoScript files before committing.

**What went well:**
The `validate_xanoscript` tool worked perfectly! I used the `directory` parameter to validate all .xs files at once, and it gave clear output showing 2 valid files with no errors.

**Why this was helpful:**
Immediate feedback that my code was syntactically correct before pushing to GitHub.

---

## Summary

**Overall experience:** Good, but documentation gaps caused some friction.

**Top 3 improvements that would help most:**
1. Expand quick_reference mode for run/functions to include at least one complete example
2. Add a `query` parameter to api.request for cleaner URL construction
3. Provide a complete filter reference in the syntax documentation

**What worked well:**
- The validation tool is excellent
- Full mode documentation is comprehensive
- mcporter call interface is intuitive once you know you don't need a daemon

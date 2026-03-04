# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-04 03:32 PST] - Bitwise OR filter not available

**What I was trying to do:** Implement the "Bitwise ORs of Subarrays" exercise using bitwise OR operations (`|bor:` filter)

**What the issue was:** The validation tool returned an error: "Unknown filter function 'bor'"

**Why it was an issue:** This prevented me from implementing the original exercise I had chosen. I had to switch to a different exercise that doesn't require bitwise operations.

**Potential solution (if known):** 
- Add bitwise operation filters: `bor` (bitwise OR), `band` (bitwise AND), `bxor` (bitwise XOR), `bnot` (bitwise NOT)
- Document available math/bitwise operations more clearly in the syntax documentation
- Provide a comprehensive list of all available filters

---

## [2026-03-04 03:33 PST] - MCporter validate_xanoscript parameter passing issues

**What I was trying to do:** Validate XanoScript code using the `validate_xanoscript` tool via mcporter

**What the issue was:** Multiple attempts to pass file paths failed:
1. `--file_path` parameter interpreted the path as code content
2. `--file_paths` parameter didn't work as expected
3. `--directory` parameter didn't work as expected
4. Passing code via stdin (`@-`) didn't work

**Why it was an issue:** Had to read file content into a variable and pass it via the `code=` parameter, which is less convenient than using file paths directly.

**Potential solution (if known):**
- Fix the parameter handling in mcporter to properly distinguish between file paths and code content
- Ensure `--file_path` reads from the specified file instead of treating the path as code
- Support for stdin redirection would be helpful for piping code

---

## [2026-03-04 03:35 PST] - Limited documentation on available filters/functions

**What I was trying to do:** Find a list of all available filters, especially for math and bitwise operations

**What the issue was:** The documentation doesn't provide a comprehensive list of available filters. Searching through the syntax documentation didn't reveal what filters are available for mathematical or bitwise operations.

**Why it was an issue:** Had to discover through trial and error which filters exist (e.g., found that `bor` doesn't exist, but `math.add` and `math.div` do from looking at examples).

**Potential solution (if known):**
- Provide a comprehensive reference list of all available filters organized by category (string, array, math, etc.)
- Include examples for each filter
- Make it clear which operations are available as filters vs. as separate constructs

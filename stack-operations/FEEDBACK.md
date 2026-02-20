# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 00:15 PST] - MCP validate_xanoscript parameter format confusion

**What I was trying to do:** Call the validate_xanoscript tool to check my XanoScript files for syntax errors

**What the issue was:** The documentation says to use parameters like `file_path`, `file_paths`, or `directory`, but when I tried passing JSON like `{"directory": "/path"}`, the tool kept returning "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** I spent several attempts trying different JSON formats and quote escaping before discovering that mcporter uses `key=value` syntax instead of JSON

**Potential solution (if known):** The mcporter help text shows the correct syntax, but the xanoscript_docs output always shows JSON examples. It would be helpful if the documentation matched the actual tool interface, or if the tool accepted both formats.

---

## [2025-02-20 00:20 PST] - XanoScript optional input syntax not documented clearly

**What I was trying to do:** Make an input parameter optional by adding `optional = true` to the input block

**What the issue was:** Validation failed with "The argument 'optional' is not valid in this context" and "Expected value of `optional` to be `null`"

**Why it was an issue:** The documentation mentions input blocks but doesn't clearly explain that optional is not a valid property. I had to look at existing implementations (queue_operations) to learn that all inputs are effectively optional and validation should happen in the stack logic.

**Potential solution (if known):** Add a clear note in the input block documentation that `optional` is not supported, and show the pattern of using conditional validation in the stack instead.

---

## [2025-02-20 00:25 PST] - XanoScript error statement syntax confusion

**What I was trying to do:** Throw an error using the syntax `error "message"` for invalid operations

**What the issue was:** Validation failed with "Expecting --> } <-- but found --> 'error'"

**Why it was an issue:** The syntax seemed intuitive based on other languages, but XanoScript doesn't support this. I had to discover through trial and error and by reading existing implementations that errors should be tracked using `var $error_msg` and returned as part of the response object.

**Potential solution (if known):** Document the error handling patterns more clearly in the quickstart guide. Show examples of:
1. How to handle validation errors (conditional + error_msg variable)
2. What error handling syntax IS supported (if any standalone error statement exists)

---

## [2025-02-20 00:30 PST] - Lack of comprehensive syntax examples in docs

**What I was trying to do:** Find reference documentation for XanoScript syntax, specifically for control flow (if/elseif/else) and error handling

**What the issue was:** The `xanoscript_docs` function with different topics (syntax, quickstart, functions) kept returning similar high-level overviews rather than detailed syntax reference

**Why it was an issue:** I couldn't find definitive documentation on:
- The exact syntax for conditional blocks
- Whether `precondition` is valid (it's in the docs but didn't seem to work)
- How to properly structure if/elseif/else chains
- What statements are allowed in the stack vs in conditional blocks

**Potential solution (if known):** 
1. Create a dedicated "syntax reference" topic that shows all valid statements and their exact syntax
2. Include a complete BNF grammar or equivalent
3. Provide an interactive validator that explains what syntax is expected at the cursor position

---

## [2025-02-20 00:35 PST] - Difficulty discovering correct patterns

**What I was trying to do:** Write idiomatic XanoScript code following best practices

**What the issue was:** Had to read through multiple existing implementations to discover patterns like:
- Using `var $error_msg` for error tracking
- Returning structured response objects with success/error fields
- Using `conditional { if ... elseif ... else }` for control flow
- Not using `optional` in input blocks

**Why it was an issue:** Each incorrect attempt required a validation cycle, which slowed down development. The documentation mentions these constructs exist but doesn't provide enough examples of correct usage.

**Potential solution (if known):**
1. Create a "patterns" or "cookbook" documentation section with common idioms
2. Include a "common mistakes" section in the quickstart guide
3. Provide a linter or formatter that suggests corrections beyond just syntax errors

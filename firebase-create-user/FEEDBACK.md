# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 03:47 PST] - Boolean Type Name Issue

**What I was trying to do:**
Create a function input with an optional boolean parameter `email_verified`.

**What the issue was:**
I initially wrote `boolean email_verified? = false` but the validator rejected it, saying "Expecting --> } <-- but found --> 'boolean' <--"

**Why it was an issue:**
I was confused because the documentation mentions "boolean" as a type in various places, but the actual XanoScript type keyword is `bool`, not `boolean`. The error message was helpful in suggesting the fix, but it took me a moment to understand the disconnect between what I thought was the type name and what it actually is.

**Potential solution (if known):**
The MCP could potentially provide more explicit type names in the documentation, or the validator could accept both `bool` and `boolean` as aliases for better developer experience.

---

## [2025-02-17 03:48 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Write a precondition to validate password length: `$input.password|strlen >= 6`

**What the issue was:**
The validator rejected this with the error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:**
While the syntax documentation mentions that "When concatenating strings that use filters, wrap each filtered expression in parentheses," it wasn't immediately obvious that this also applies to filter expressions used in comparisons within preconditions. I had to wrap the entire filter expression like `($input.password|strlen) >= 6`.

**Potential solution (if known):**
The documentation could have a more prominent section about filter expression wrapping requirements, specifically calling out that any filter used in a comparison or test context needs parentheses around the filtered value. The error message was good though - it told me exactly what was wrong.

---

## [2025-02-17 03:45 PST] - Initial MCP Tool Discovery

**What I was trying to do:**
Understand what tools were available in the Xano MCP and how to use them.

**What the issue was:**
I had to run `mcporter list xano --schema` to discover the available tools. The tools are well-named (`validate_xanoscript`, `xanoscript_docs`) but I didn't immediately know which tool to call for documentation vs validation.

**Why it was an issue:**
It would have been helpful to have a brief overview or quickstart guide for the MCP itself, explaining:
1. Always call `xanoscript_docs` before writing code
2. Use `validate_xanoscript` to check your work
3. The topics available in the docs

**Potential solution (if known):**
A README or getting started guide for the MCP would be helpful. Something like:
- Step 1: Get docs for your use case (`mcporter call xano.xanoscript_docs topic=run`)
- Step 2: Write your code
- Step 3: Validate (`mcporter call xano.validate_xanoscript directory=./my-project`)

---

## [2025-02-17 03:46 PST] - Documentation Path vs File Path

**What I was trying to do:**
Validate the .xs files I created in `~/xs/firebase-create-user/`

**What the issue was:**
When I passed `directory=~/xs/firebase-create-user`, the MCP said "No .xs files found in directory". I had to use the absolute path `/Users/justinalbrecht/xs/firebase-create-user` for it to work.

**Why it was an issue:**
The shell expands `~` to the home directory, but when passing it through mcporter/mcp, it wasn't being expanded. This is a common gotcha with CLI tools.

**Potential solution (if known):**
The MCP could potentially expand `~` to the user's home directory, or the documentation could note that absolute paths are required. The error message could also suggest checking if the path exists and is absolute.

---

## General Feedback

### What Worked Well:

1. **The validator is excellent** - It caught my mistakes quickly and provided helpful suggestions
2. **Error messages are clear** - Both the boolean type issue and the parentheses issue had actionable error messages
3. **Documentation is comprehensive** - Once I found the right topic, the docs had good examples

### Suggestions for Improvement:

1. **Type Reference** - A quick reference card showing all valid type keywords (bool, int, text, email, etc.) would be super helpful
2. **Common Mistakes Section** - A section in the docs covering things like:
   - Use `bool` not `boolean`
   - Wrap filter expressions in parentheses when comparing
   - Empty input blocks need braces on separate lines
3. **MCP Quickstart** - A brief "Getting Started with the Xano MCP" guide

### Overall Experience:

After getting past the initial syntax quirks, the development experience was smooth. The validator was fast and helpful, and the documentation covered everything I needed. Creating a Firebase Auth integration was straightforward once I understood the `api.request` syntax.

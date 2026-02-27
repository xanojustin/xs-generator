# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 20:05 PST] - xanoscript_docs tool failed

**What I was trying to do:** Get XanoScript documentation before writing any code, as instructed in the task

**What the issue was:** The `xanoscript_docs` tool call failed with error: `Error reading XanoScript documentation: p.split is not a function`

**Why it was an issue:** I was instructed to call `xanoscript_docs` before writing ANY code because my training data doesn't include XanoScript syntax. Without the docs, I had to rely on examining existing implementations to understand the syntax.

**Potential solution (if known):** The MCP tool might have a bug when called without parameters. Could also be a parsing issue with the response.

---

## [2025-02-26 20:08 PST] - Only one function per file allowed

**What I was trying to do:** Create a helper function within the same file as the main function (common pattern in many languages)

**What the issue was:** XanoScript validation failed with: `Redundant input, expecting EOF but found: // Helper function...`

**Why it was an issue:** I didn't know that XanoScript only allows one function definition per file. This is different from most programming languages where multiple functions can coexist in a single file. I had to split the helper function into a separate file.

**Potential solution (if known):** The documentation could be clearer about this constraint, or the error message could explicitly say "only one function per file allowed" instead of "expecting EOF".

---

## [2025-02-26 20:10 PST] - $response is a reserved variable name

**What I was trying to do:** Create a variable named `$response` to store the result object before returning it

**What the issue was:** XanoScript validation failed with: `'$response' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:** The error message was helpful (suggested using `$my_response`), but I didn't know ahead of time that `$response` was reserved. The naming pattern of `$variable` made me think I could use any name.

**Potential solution (if known):** A documented list of reserved variable names would be helpful. The error message is good though!

---

## [2025-02-26 20:00 PST] - mcporter syntax confusion

**What I was trying to do:** Call the validate_xanoscript tool with the correct parameter format

**What the issue was:** I initially tried multiple syntaxes that didn't work:
- `--params '{"files": [...]}'` - Failed
- `file_paths:=...` (array syntax) - Didn't work properly
- Eventually found `--args '{"file_paths": [...]}'` worked

**Why it was an issue:** The mcporter CLI syntax wasn't immediately clear from the error messages. The tool expects `file_paths` as an array parameter.

**Potential solution (if known):** More examples in the tool documentation or clearer error messages about expected parameter format.

---

## General Observation: Tree representation

**What I noticed:** The existing exercises use a JSON object representation for trees with `val`, `left`, and `right` properties. This works well but requires manual `get` filter calls to access properties.

**Why it matters:** Working with trees requires lots of `var $left_subtree { value = $input.tree|get:"left":null }` boilerplate. A more native tree type or pattern could simplify this.

**Potential solution (if known):** Not sure if XanoScript has native tree/pointer types, but if not, maybe syntactic sugar for object property access could help.

---

## Overall Experience

The validation tool is **very helpful** - it catches errors with specific line numbers and even gives suggestions! The main friction points were:
1. Initial docs call failing
2. Discovering the one-function-per-file rule
3. Discovering reserved variable names

Once I understood these constraints, development was smooth.

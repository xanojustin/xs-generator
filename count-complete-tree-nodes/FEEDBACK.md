# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 20:35 PST] - Multiple functions per file not allowed

**What I was trying to do:** Create a solution with helper functions in the function/count_complete_tree_nodes.xs file.

**What the issue was:** I initially created one .xs file with multiple function definitions (main function + 3 helper functions). The validator gave me this error:
```
✗ count_complete_tree_nodes.xs: Found 1 error(s):

1. [Line 27, Column 1] Redundant input, expecting EOF but found: function

Code at line 27:
  function "count_nodes_helper" {
```

**Why it was an issue:** I had to split my code into 5 separate files (one per function), which made the project structure more complex than necessary. I wasn't aware that XanoScript only allows one function per file.

**Potential solution (if known):** The MCP could detect this specific error pattern and provide a clearer message like: "XanoScript only allows one function per .xs file. Please split your functions into separate files."

---

## [2025-02-28 20:42 PST] - Bit shift operator not supported

**What I was trying to do:** Use the bit shift operator `<<` to calculate 2^height efficiently (standard algorithm for counting complete tree nodes).

**What the issue was:** I wrote:
```xs
var $full_count { value = (1 << $left_height) - 1 }
```

The validator gave me a cryptic error:
```
1. [Line 33, Column 43] Expecting: one of these possible Token sequences:
  ...
  but found: '<'
```

**Why it was an issue:** The error message listed 29 possible token types but didn't explicitly say "bit shift operators are not supported." I had to guess that `<<` wasn't valid syntax.

**Potential solution (if known):** 
1. The validator could explicitly say: "Bit shift operators (<<, >>) are not supported in XanoScript. Use math operations or loops instead."
2. Or even better: XanoScript could support bit shift operators since they're common in algorithm implementations.

---

## [2025-02-28 20:30 PST] - Run job structure confusion

**What I was trying to do:** Create a run.xs that includes both the run.job and test functions.

**What the issue was:** I incorrectly put function definitions inside run.xs alongside the run.job block. The validator error was:
```
✗ run.xs: Found 1 error(s):

1. [Line 7, Column 1] Redundant input, expecting EOF but found: function
```

**Why it was an issue:** I initially thought run.xs could contain both the job definition and helper functions. I had to look at existing examples to understand that run.xs should only contain the run.job block.

**Potential solution (if known):** The validator could provide a more specific message: "run.xs can only contain run.job or run.service blocks. Functions must be defined in separate files in the function/ directory."

---

## [2025-02-28 20:30 PST] - Documentation format is hard to parse

**What I was trying to do:** Call the xanoscript_docs tool to get syntax documentation.

**What the issue was:** The MCP response comes as a JavaScript object string rather than proper JSON:
```javascript
{
  content: [
    {
      type: 'text',
      text: '---\n' +
        'applyTo: "**/*.xs"\n' +
        '---\n' +
        ...
```

**Why it was an issue:** This made it difficult to parse programmatically. I had to use sed to extract the text content.

**Potential solution (if known):** Return proper JSON with the documentation as a string field, or provide a raw text mode for easier consumption.

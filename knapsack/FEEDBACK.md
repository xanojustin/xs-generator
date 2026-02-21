# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 13:05 PST] - MCP Documentation Not Specific

**What I was trying to do:** Get specific documentation about XanoScript syntax for functions and run jobs

**What the issue was:** The `xanoscript_docs` tool with topics like "functions" and "run" returned generic overview documentation instead of specific syntax details for those constructs

**Why it was an issue:** I had to look at existing implementations in ~/xs/ to understand the exact syntax patterns, which is inefficient and error-prone

**Potential solution:** The MCP should return detailed syntax documentation for specific topics, including:
- Exact syntax for `function` constructs (input blocks, stack blocks, response)
- Exact syntax for `run.job` constructs
- Common patterns and examples for each construct type

---

## [2025-02-21 13:08 PST] - Validation Tool Parameter Format Unclear

**What I was trying to do:** Validate my XanoScript files using the MCP

**What the issue was:** It took multiple attempts to figure out the correct parameter format for `validate_xanoscript`. The tool expects `file_paths` as an array parameter, but the mcporter CLI syntax wasn't intuitive

**Why it was an issue:** Wasted time trying different syntaxes:
- `file_paths: "path1" file_paths: "path2"` - parsed each character separately
- Various JSON formats didn't work directly
- Finally had to use `--args '{"file_paths": [...]}'`

**Potential solution:** 
1. Better documentation in the MCP tool description about expected parameter format
2. Support simpler calling patterns like `validate_xanoscript directory:~/xs/knapsack`
3. Provide clear examples in the tool description

---

## [2025-02-21 13:10 PST] - XanoScript Response in Conditional Blocks

**What I was trying to do:** Handle an edge case (empty input) by returning early from the function

**What the issue was:** XanoScript doesn't allow `response =` inside conditional blocks within the stack. The validation error was: "Expecting --> } <-- but found --> 'response' <--"

**Why it was an issue:** This is a common pattern in many programming languages (early return), but XanoScript requires a different approach. I had to restructure the code to:
1. Declare a result variable before the conditional
2. Set the result variable inside conditionals
3. Use `response = $result` at the end of the function

**Potential solution:** 
1. Document this limitation clearly in the syntax guide
2. Provide examples of how to handle conditional return values
3. Consider allowing `response` in conditionals if it's the only exit point

---

## [2025-02-21 13:12 PST] - XanoScript Array Update Syntax is Verbose

**What I was trying to do:** Update a specific index in an array (the DP array in knapsack)

**What the issue was:** XanoScript doesn't have direct array index assignment like `$dp[$c] = $new_val`. Instead, I had to use slice and merge operations:
```xs
var $dp_before { value = $dp|slice:0:$c }
var $dp_after { value = $dp|slice:($c + 1):($dp|count) }
var $dp { value = $dp_before|merge:[$new_val]|merge:$dp_after }
```

**Why it was an issue:** This is extremely verbose and inefficient for what should be a simple operation. It makes the code harder to read and understand.

**Potential solution:** 
1. Add direct array index assignment syntax like `var.update $dp[$c] { value = $new_val }`
2. Or provide a built-in filter like `$dp|set_at:$c:$new_val`

---

## General Notes

The MCP validation tool works well once you figure out the syntax. The error messages are helpful in pointing to the exact line and column of issues. However, the documentation gap between generic concepts and specific syntax patterns makes development slower than it needs to be.

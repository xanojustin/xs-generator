# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 00:20 PST] - Type Naming Confusion

**What I was trying to do:**
Create a XanoScript function with integer and boolean input parameters with default values.

**What the issue was:**
I used `integer` and `boolean` as type names, but XanoScript expects `int` and `bool`.

```xs
// WRONG - This causes a validation error
integer inventory_quantity? = 0 { description = "..." }
boolean published? = true { description = "..." }

// CORRECT - This validates successfully
int inventory_quantity?=0 filters=min:0 { description = "..." }
bool published?=true { description = "..." }
```

Also, the default value syntax requires no spaces around the `=` sign: `?=0` not `? = 0`.

**Why it was an issue:**
The validation error was `[Line 8, Column 5] Expecting --> } <-- but found --> 'integer' <--` which wasn't immediately clear about the actual problem. The error suggested a syntax issue with the closing brace rather than an invalid type name.

**Potential solution (if known):**
- Include a "Common Type Mistakes" section in the quickstart documentation
- Improve the validator error message to suggest valid type names when an invalid one is found
- Add a table mapping "intuitive" type names to XanoScript type names (e.g., integer→int, boolean→bool, string→text)

---

## [2026-02-14 00:15 PST] - MCP Tool Parameter Passing Confusion

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool.

**What the issue was:**
The mcporter CLI syntax for passing the `code` parameter was not obvious. Multiple attempts failed:

```bash
# Failed - Too many positional arguments
mcporter call xano validate_xanoscript --code '$(cat file.xs)'

# Failed - Parameter not recognized
mcporter call xano validate_xanoscript --code "$(cat file.xs)"

# Failed - JSON stdin not working
cat file.xs | jq -Rs '{code: .}' | mcporter call xano validate_xanoscript

# WORKS - Using key=value format with env var
CODE=$(cat file.xs) && mcporter call xano validate_xanoscript "code=$CODE"
```

**Why it was an issue:**
The help text shows examples like `key=value` and `key:value` but doesn't clearly explain how to pass multi-line content or which format is preferred. When dealing with code that contains quotes and special characters, the parameter passing becomes tricky.

**Potential solution (if known):**
- Add a specific example for the validate_xanoscript tool showing the recommended way to pass code
- Support reading from stdin directly (e.g., `cat file.xs | mcporter call xano validate_xanoscript`)
- Support file path parameter: `--file path/to/file.xs`

---

## [2026-02-14 00:12 PST] - Run Job vs Function Validation Confusion

**What I was trying to do:**
Understand whether the `run.xs` file with `run.job` construct needed different validation than function files.

**What the issue was:**
Initially when I tried to validate a run.xs file with incorrect syntax, the validator error said it expected `function` but found `-`. This made me think run.job files needed a different validation method than function files.

**Why it was an issue:**
There was confusion about whether the validator auto-detects file types or if different constructs (run.job vs function vs query) need different validation approaches. The error message wasn't clear.

**Potential solution (if known):**
- Clarify in the documentation that the validator auto-detects constructs from the code content
- Add documentation about the run.job construct in the quickstart guide (it's mentioned in file structure but not explained)
- Show a complete run.job example in the documentation

---

## General Observations

**What worked well:**
- The `xanoscript_docs` tool with different topics is very helpful
- The quickstart documentation with the type tables is useful once found
- The validator gives line/column numbers which helps locate issues

**What could be improved:**
1. **Complete Examples**: More complete working examples for each construct type (function, run.job, query, task) would be extremely helpful
2. **Error Messages**: More contextual error messages that suggest the fix, not just the problem
3. **Type Reference**: A quick reference card showing all valid types and their syntax
4. **File Naming Conventions**: Clear documentation on file naming (when to use .xs vs run.job vs function names)

**Questions I still have:**
- Can run.xs files contain multiple run.job definitions, or only one per file?
- What's the difference between `run.job` and `task` constructs?
- Is there a standard way to organize multiple related run jobs (e.g., CRUD operations for a resource)?

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 17:20 PST] - MCP Tool Discovery and Configuration

**What I was trying to do:**
Find and use the Xano MCP server to validate XanoScript code.

**What the issue was:**
When running `mcporter list` from the workspace directory, the xano MCP was found. However, when running from a bash script or subprocess, it couldn't find the xano server. The MCP is configured in `/Users/justinalbrecht/.openclaw/workspace/config/mcporter.json` but mcporter needs to be run from that directory to find it.

**Why it was an issue:**
Made it difficult to automate validation from scripts. Had to work around by running mcporter from the correct working directory.

**Potential solution:**
Document that mcporter should be run from the workspace directory, or support a `MCP_CONFIG_PATH` environment variable to specify the config location explicitly.

---

## [2025-02-14 17:25 PST] - validate_xanoscript Parameter Passing

**What I was trying to do:**
Call the `validate_xanoscript` tool via mcporter CLI to validate XanoScript code.

**What the issue was:**
Passing multi-line XanoScript code through command line arguments was extremely difficult. Various approaches failed:
- Direct string passing: shell ate the newlines
- Base64 encoding: command substitution issues
- JSON args file: mcporter didn't support `@file.json` syntax as documented
- Function call syntax: `xano.validate_xanoscript(code: "...")` - struggled with escaping

**Why it was an issue:**
Spent significant time trying different approaches. The only working solution was to use direct MCP protocol communication via Python script (stdio to the npx process).

**Potential solution:**
- Support reading code from stdin: `cat file.xs | mcporter call xano validate_xanoscript`
- Support file path argument: `mcporter call xano validate_xanoscript --file path/to/file.xs`
- Better documentation of the function call syntax with examples for multi-line strings

---

## [2025-02-14 17:30 PST] - XanoScript Type System Confusion

**What I was trying to do:**
Define function inputs with appropriate types for booleans and integers.

**What the issue was:**
Tried to use `boolean` and `integer` types which don't exist. The validator error was:
```
[Line 7, Column 5] Expecting --> } <-- but found --> 'boolean'
```

Had to examine existing code to discover the correct types are:
- `text` for strings AND numbers
- `bool` for booleans (not `boolean`)
- `text[]` for string arrays

**Why it was an issue:**
The error message wasn't clear about what types are available. Had to grep through existing implementations to find the correct syntax.

**Potential solution:**
- Add a `types` topic to xanoscript_docs that lists all valid types
- Improve error messages to suggest valid alternatives
- Document input type syntax more explicitly

---

## [2025-02-14 17:35 PST] - Missing Filter Functions

**What I was trying to do:**
Parse JSON input from a text parameter using `from_json` or `json_parse` filter.

**What the issue was:**
Neither `from_json` nor `json_parse` filters exist. Error:
```
Unknown filter function 'from_json'
Unknown filter function 'json_parse'
```

**Why it was an issue:**
Had to remove JSON parsing functionality entirely and simplify the code. This limits the flexibility of the run job.

**Potential solution:**
- Add JSON parsing filter (e.g., `|json_parse`)
- Add JSON stringify filter (e.g., `|json_stringify` or `|to_json`)
- Document available filters more comprehensively

---

## [2025-02-14 17:40 PST] - Reserved Variable Names

**What I was trying to do:**
Use `$output` as a variable name to store the prediction output.

**What the issue was:**
Got error: `'$output' is a reserved variable name and should not be used as a variable.`

**Why it was an issue:**
Had to rename all instances of `$output` to `$prediction_output`. Not documented which variable names are reserved.

**Potential solution:**
- Document reserved variable names in xanoscript_docs
- Consider allowing `$output` in function scope since it's not the same as response output

---

## [2025-02-14 17:45 PST] - Control Flow Limitations

**What I was trying to do:**
Implement a polling loop using `while` to check prediction status.

**What the issue was:**
`while` loops seem to not be supported or have different syntax. Got error:
```
Expecting --> each <-- but found --> '\n'
```

Also tried `try/catch` for JSON parsing which also wasn't recognized.

**Why it was an issue:**
Had to remove the polling functionality entirely, making the run job simpler but less capable. The run job now only creates predictions and doesn't wait for completion.

**Potential solution:**
- Document supported control flow structures (loops, exception handling)
- Add while loop support if not present
- Add try/catch support for error handling

---

## [2025-02-14 17:50 PST] - xanoscript_docs Topic Parameter Not Working

**What I was trying to do:**
Get specific documentation by calling `xanoscript_docs` with different topics.

**What the issue was:**
No matter what topic I passed (`tasks`, `run`, `quickstart`, `integrations`), the MCP always returned the same general README documentation.

**Why it was an issue:**
Couldn't get specific documentation for run jobs or other topics, making it harder to learn correct syntax.

**Potential solution:**
- Fix the topic filtering in xanoscript_docs
- Ensure each topic returns distinct, relevant documentation

---

## Summary

The Xano MCP validation tool works well once you figure out how to call it. The main struggles were:

1. **CLI usability** - Multi-line code passing is hard
2. **Documentation gaps** - Type system, reserved words, and control flow not well documented
3. **Feature limitations** - Missing JSON parsing, loops, and exception handling
4. **Error messages** - Could be more helpful in suggesting correct alternatives

Despite these issues, I was able to create a working Replicate run job by simplifying the design and following patterns from existing implementations.

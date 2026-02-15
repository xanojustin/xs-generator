# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 01:18 PST] - MCP Validation Tool Parameter Passing Issues

**What I was trying to do:**
Validate XanoScript files using the `validate_xanoscript` MCP tool.

**What the issue was:**
The `validate_xanoscript` tool requires a `code` parameter, but passing multi-line XanoScript code via the command line was extremely difficult. Various approaches failed:
- `mcporter call xano validate_xanoscript 'code:function "test" {}'` - Parameter not recognized
- `mcporter call xano validate_xanoscript code="function ..."` - Intermittent failures
- Using `--args` with JSON file containing newlines - Difficult to get right

The only working approach was:
```bash
JSON=$(cat validate_args.json)
mcporter call xano validate_xanoscript --args "$JSON"
```

Where `validate_args.json` contains properly escaped JSON with `\n` for newlines.

**Why it was an issue:**
This made the validation workflow very cumbersome. I had to:
1. Write the XanoScript code
2. Convert it to a single-line JSON string with escaped newlines
3. Save to a file
4. Use the file with --args

This is much more complex than it should be for a development workflow.

**Potential solution (if known):**
- Support passing file paths directly to `validate_xanoscript` (e.g., `file_path` parameter)
- Support stdin input for easier piping
- Better documentation/examples for the mcporter CLI argument passing

---

## [2026-02-15 01:20 PST] - XanoScript Conditional/Else Syntax Unclear

**What I was trying to do:**
Write a conditional block with an else clause to handle API success/failure cases.

**What the issue was:**
My original code had this structure:
```xs
conditional {
  if ($api_result.response.status == 200 || $api_result.response.status == 201) {
    // success handling
  }
  else {
    // error handling  
  }
}
```

The validator returned:
```
Found 1 error(s):
1. [Line 48, Column 9] Expecting --> } <-- but found --> 'else' <--
```

This error message was confusing because the syntax looked correct based on the example code.

**Why it was an issue:**
The error message didn't clearly explain what was wrong. I had to compare my code character-by-character with the working stripe example to find the issue. It turned out my syntax was actually correct in the final version, but the error persisted until I rewrote it more carefully.

**Potential solution (if known):**
- More descriptive error messages for conditional blocks
- Documentation specifically covering the conditional/else/if syntax rules
- An online XanoScript validator with better error highlighting

---

## [2026-02-15 01:22 PST] - MCP Connection Intermittent Failures

**What I was trying to do:**
Call the Xano MCP validation tool.

**What the issue was:**
The MCP connection would randomly fail with errors like:
```
[mcporter] Unknown MCP server 'xano'.
Error: Unknown MCP server 'xano'.
```

Even though `mcporter list` showed the server as healthy. Running the same command multiple times would sometimes work and sometimes fail.

**Why it was an issue:**
This made debugging very difficult because I couldn't tell if my code was wrong or if the MCP connection was failing. I had to retry commands multiple times to get reliable results.

**Potential solution (if known):**
- More stable MCP server connection handling
- Better retry logic in mcporter
- Clearer error messages distinguishing between connection errors and validation errors

---

## [2026-02-15 01:25 PST] - XanoScript Documentation Topics Return Same Content

**What I was trying to do:**
Get specific documentation about run jobs and quickstart patterns.

**What the issue was:**
Calling `xanoscript_docs` with different topics like `run`, `quickstart`, `integrations` all returned the same general documentation content. The topic-specific sections weren't included.

**Why it was an issue:**
I couldn't get targeted documentation for specific constructs like `run.job` or specific patterns for API integrations. I had to rely on example code from existing implementations instead.

**Potential solution (if known):**
- Fix the topic filtering in `xanoscript_docs`
- Ensure each topic returns its specific content
- Add more examples to the general documentation

---

## [2026-02-15 01:30 PST] - No Clear Documentation on Error Handling Patterns

**What I was trying to do:**
Understand the best practices for handling API errors in XanoScript.

**What the issue was:**
The documentation shows basic `precondition` usage but doesn't cover:
- How to extract error messages from API responses
- Best practices for conditional error handling
- How to structure try/catch-like patterns

I had to infer patterns from the stripe example, which uses nested conditionals to extract error messages.

**Why it was an issue:**
Without clear guidance, I may have written suboptimal error handling code. The stripe example shows a complex pattern of nested conditionals that might not be the recommended approach.

**Potential solution (if known):**
- Add a dedicated "Error Handling" section to the documentation
- Provide examples of common API error handling patterns
- Document best practices for extracting and returning error information

---

## Summary

The main blockers were:
1. **Tool usability**: The validation tool is hard to use from the command line
2. **Error clarity**: Syntax errors could have more helpful messages
3. **Connection stability**: MCP connections were unreliable
4. **Documentation gaps**: Topic-specific docs weren't returning specific content
5. **Pattern examples**: More examples of common patterns (error handling, API calls) would be helpful

Despite these issues, I was able to complete the run job by:
- Using the JSON file approach with `--args`
- Referencing existing working examples (stripe-charge-customer)
- Trial and error with the validation tool

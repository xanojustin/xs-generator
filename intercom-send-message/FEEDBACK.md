# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 22:45 PST] - MCP Documentation Tool Confusion

**What I was trying to do:**
Understand how to use the Xano MCP to get XanoScript documentation before writing code.

**What the issue was:**
Initially, I wasn't sure how to access the MCP tools. I had to explore `mcporter list xano --schema` to discover the available tools (`xanoscript_docs`, `validate_xanoscript`, etc.). The tool names weren't immediately obvious.

**Why it was an issue:**
I needed to know the proper syntax for calling MCP tools through mcporter to get the documentation before writing any XanoScript code.

**Potential solution (if known):**
A quick reference guide in the skill documentation showing common MCP tool calls would be helpful. Something like:
```bash
mcporter call xano.xanoscript_docs topic=run mode=full
mcporter call xano.validate_xanoscript file_path="..."
```

---

## [2026-02-17 22:47 PST] - XanoScript Syntax Learning Curve

**What I was trying to do:**
Write proper XanoScript code for the run job and function.

**What the issue was:**
The documentation was clear, but I had to cross-reference multiple topics (`run`, `functions`, `quickstart`, `integrations/external-apis`) to understand the complete picture. Key gotchas I noticed:
- Must use `elseif` not `else if`
- Must use `params` not `body` for api.request
- Must use `text` not `string` for type declarations
- Must wrap filter expressions in parentheses when used in comparisons

**Why it was an issue:**
Without the docs, I would have written invalid syntax. The docs were comprehensive but required checking multiple topics to piece together a complete run job.

**Potential solution (if known):**
A single "run job complete example" topic that shows a full working example with external API calls would be useful. The current docs have examples but they're spread across topics.

---

## [2026-02-17 22:50 PST] - File Path Handling

**What I was trying to do:**
Validate the XanoScript files after creating them.

**What the issue was:**
The validation command worked perfectly: `mcporter call xano.validate_xanoscript directory="..."`

**Why it was an issue:**
No issue here - validation worked great and caught no errors (which was correct since I followed the docs carefully).

**Potential solution (if known):**
None needed - validation tool worked as expected!

---

## [2026-02-17 22:52 PST] - Environment Variable Access Pattern

**What I was trying to do:**
Figure out how to access environment variables in XanoScript functions.

**What the issue was:**
From the quickstart docs, I learned that `$env` is a reserved variable for accessing environment variables. However, I initially wasn't sure if I needed to declare them somewhere or if they're automatically available.

**Why it was an issue:**
The run.job has an `env` array to declare which env vars are required, but I wasn't 100% clear if that's just for documentation/validation or if it affects runtime behavior.

**Potential solution (if known):**
Clarify in the run documentation whether the `env` array is:
1. Just documentation for what the job needs
2. Actually filters which env vars are available to the function
3. Both

---

## [2026-02-17 22:54 PST] - API Response Structure

**What I was trying to do:**
Access the response data from an api.request call.

**What the issue was:**
The docs clearly showed the response structure with `$result.response.status`, `$result.response.result`, and `$result.response.headers`. This worked perfectly.

**Why it was an issue:**
No issue - the docs were clear about accessing response data.

**Potential solution (if known):**
None needed - well documented!

---

## Summary

**What Worked Well:**
1. The validation tool is excellent - caught no errors because the docs were clear
2. The documentation is comprehensive with many examples
3. The mcporter CLI makes MCP tools easy to use
4. The quickstart doc's "Common Mistakes" section prevented several errors

**Overall Experience:**
Once I understood how to call the MCP tools via mcporter, the development flow was smooth. The biggest challenge was knowing I *had* to call `xanoscript_docs` first since my training data doesn't include XanoScript syntax. After getting the docs, writing the code was straightforward.

**Suggestions for Improvement:**
1. A "MCP Quick Start" in the skill docs showing exact command syntax
2. A complete run job template topic that combines run.job + function + api.request patterns
3. Clarification on the `env` array behavior in run configurations

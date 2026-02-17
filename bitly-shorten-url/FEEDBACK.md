# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 00:45 PST] - MCP Tool Parameter Passing Issues

**What I was trying to do:**
Validate XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:**
The mcporter CLI had difficulty passing parameters to the validate_xanoscript tool. Multiple attempts with different syntaxes failed:
- `mcporter call xano validate_xanoscript '{"file_path": "..."}'` - returned "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"
- `mcporter call xano validate_xanoscript --file_path run.xs` - complained about positional arguments
- `mcporter call xano validate_xanoscript file_path=run.xs` - worked!

**Why it was an issue:**
The tool documentation shows JSON format examples, but the actual working syntax was key=value format. This was confusing and took multiple attempts to figure out.

**Potential solution (if known):**
- Update documentation to clearly show the correct mcporter CLI syntax
- Consider supporting both JSON and key=value formats consistently
- Add examples specific to mcporter CLI usage vs raw MCP protocol

---

## [2025-02-17 00:48 PST] - Unclear Input Optional Syntax

**What I was trying to do:**
Mark input parameters as optional in a function definition using `optional = true`.

**What the issue was:**
The validator returned errors:
```
[Line 5, Column 78] The argument 'optional' is not valid in this context
[Line 5, Column 78] Expected value of `optional` to be `null`
```

I had written:
```xs
text domain { description = "Optional: Custom domain (default: bit.ly)", optional = true }
```

**Why it was an issue:**
The documentation didn't clearly explain how to make input fields optional. Common sense suggested `optional = true` but that wasn't valid.

**Potential solution (if known):**
- Clarify in the `types` or `functions` documentation how optional inputs work
- If all inputs are implicitly optional, state that explicitly
- If there's a different syntax, document it with examples

---

## [2025-02-17 00:50 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:**
Write a conditional that checks if a value is not null AND has a length greater than 0.

**What the issue was:**
The validator complained about this code:
```xs
if ($input.domain != null && $input.domain|strlen > 0) {
```

Error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:**
The error message was helpful but the syntax requirement wasn't documented clearly. I had to guess the correct format. After trial and error, this worked:
```xs
if (($input.domain != null) && (($input.domain|strlen) > 0)) {
```

**Potential solution (if known):**
- Document this parentheses requirement in the `syntax` topic
- Provide examples of complex conditionals with filters in the quickstart guide
- Consider if the parser could be more lenient or provide auto-fix suggestions

---

## [2025-02-17 00:52 PST] - Missing Documentation on Object Merging

**What I was trying to do:**
Merge an existing object with new key-value pairs (building a payload incrementally).

**What the issue was:**
I used this syntax which seemed to work:
```xs
var $payload {
  value = $payload.value ~ { domain: $input.domain }
}
```

**Why it was an issue:**
I couldn't find documentation about the `~` operator for object merging. I guessed based on the Stripe example I saw, but I'm not 100% sure this is the correct or only way to do it.

**Potential solution (if known):**
- Document the `~` operator for object merging in the syntax documentation
- Provide examples of building objects conditionally (like API payloads)
- Explain other object manipulation operators if they exist

---

## [2025-02-17 00:53 PST] - Run Job Documentation Lacking

**What I was trying to do:**
Understand the proper structure for a `run.job` definition.

**What the issue was:**
The `run` topic documentation in xanoscript_docs didn't provide specific details about the run.job construct. I had to look at existing examples (stripe-create-charge) to understand:
- The `main` block structure with `name` and `input`
- The `env` array for environment variables
- How the job references the function

**Why it was an issue:**
Without existing examples, I wouldn't have known how to structure a run job. The documentation index mentions "run" as a topic but it doesn't provide run-specific syntax details.

**Potential solution (if known):**
- Add detailed run.job syntax documentation to the `run` topic
- Include a complete example showing run.job + function + README structure
- Document the relationship between run.job main.name and the function name

---

## Summary

Overall, the MCP tool worked well once I figured out the correct CLI syntax. The main struggles were:
1. Learning the correct mcporter parameter syntax (key=value vs JSON)
2. Understanding how optional inputs work (still unclear - just removed the optional flag)
3. Complex conditional expressions requiring parentheses around filters
4. Lack of run.job specific documentation

The validator was very helpful once I could get it running - the error messages were clear and pointed to exact line/column positions.

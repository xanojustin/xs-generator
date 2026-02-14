# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 09:16 PST] - Validation Tool Parameter Passing Issue

**What I was trying to do:**
Validate the XanoScript files I created using the MCP's `validate_xanoscript` tool.

**What the issue was:**
The validation tool consistently returned the error: `'code' parameter is required` when I tried to pass the file content.

I tried multiple approaches:
1. Passing file_path parameter - didn't work (expects code)
2. Using `mcporter call xano validate_xanoscript '{"code": "..."}'` - didn't work
3. Using `cat file.xs | mcporter call xano validate_xanoscript --json` - returned parse error
4. Using `jq -Rs '{code: .}' file.xs | mcporter call xano validate_xanoscript --json` - returned parse error

The error message from attempts 3 and 4 was:
```
Found 1 error(s):
1. [Line 1, Column 1] Expecting --> function <-- but found --> '-' <--
```

This suggests the validator is receiving a hyphen/dash character instead of the actual code content.

**Why it was an issue:**
Could not validate the .xs files before committing them. Had to rely on pattern matching against existing working implementations instead.

**Potential solution (if known):**
The MCP tool or mcporter CLI may need to properly handle JSON string escaping or stdin piping. Alternatively, the tool could accept a file_path parameter that reads the file directly.

---

## [2025-02-14 09:15 PST] - Documentation Gap: Run Job vs Function Constructs

**What I was trying to do:**
Understand the correct structure for a run.job construct vs a function construct.

**What the issue was:**
The xanoscript_docs topic "run" returned the same generic documentation as other topics, without specific syntax examples for the `run.job` construct. I had to discover the structure by reading existing implementations in the ~/xs folder.

**Why it was an issue:**
The documentation doesn't clearly show the difference between:
- `run.job` (in run.xs files)
- `function` (in function/*.xs files)

Had to reverse-engineer from existing examples.

**Potential solution (if known):**
Add a dedicated "run" topic that shows the specific syntax for run.job constructs, including:
- The main block structure
- How env variables are declared
- How input defaults are specified
- The relationship between run.xs and function files

---

## [2025-02-14 09:15 PST] - No Clear Examples for External API Patterns

**What I was trying to do:**
Understand the correct pattern for making external API calls with headers and authentication.

**What the issue was:**
The documentation mentions `api.request` but doesn't provide detailed examples of:
- How to construct headers with concatenation (using `~` operator)
- How to handle form-encoded vs JSON payloads
- The proper way to access response fields

**Why it was an issue:**
Had to rely on existing implementations (stripe-charge-customer, openai-chat-completion) to understand the correct patterns for:
- Header concatenation: `"Authorization: Bearer " ~ $api_key`
- Response parsing: `$api_result.response.result`
- Status checking: `$api_result.response.status`

**Potential solution (if known):**
Add a comprehensive "External API Integration" topic or section that covers:
- JSON API requests (like OpenAI, Anthropic)
- Form-encoded requests (like Stripe)
- Basic auth patterns (like Twilio)
- Response handling and error extraction
- Timeout configuration

---

## [2025-02-14 09:17 PST] - Filter/Function Documentation Gap

**What I was trying to do:**
Understand what filters and functions are available (like `|get:`, `|set:`, `|push:`, `|first`, `|count`).

**What the issue was:**
The documentation mentions filters exist but doesn't provide a comprehensive list or detailed usage examples.

**Why it was an issue:**
Had to infer from existing code examples:
- `$payload|set:"key":value` for setting object properties
- `$array|push:item` for array operations
- `$array|first` to get first element
- `$array|count` for array length
- `$value|get:"field"` for object property access
- `$number|to_text` for type conversion

Without a reference, it's easy to guess wrong syntax.

**Potential solution (if known):**
Add a complete filter/function reference in the documentation, organized by type:
- Array operations
- Object operations
- String operations
- Type conversions
- Math operations

---

## [2025-02-14 09:18 PST] - Missing Validation for Run.job Files

**What I was trying to do:**
Validate the run.xs file which contains a `run.job` construct.

**What the issue was:**
Based on the validation error message, it seems the validator might only expect `function` constructs, not `run.job` constructs.

**Why it was an issue:**
The run.xs file could not be validated, only the function file.

**Potential solution (if known):**
Ensure the validate_xanoscript tool accepts all XanoScript constructs including:
- run.job
- function
- query
- task
- agent
- etc.

---

## Summary

Overall, the XanoScript language seems well-designed and consistent. The main pain points were:

1. **Validation tooling issues** - Could not get validate_xanoscript to work properly
2. **Documentation gaps** - Had to reverse-engineer patterns from existing code
3. **Missing reference materials** - No complete filter/function reference available

The existing implementations in ~/xs/ were invaluable as reference material. Without them, development would have been much more difficult.

**Recommendation:**
Consider creating a "XanoScript by Example" guide that shows common patterns side-by-side, or a "cookbook" of integration patterns for popular APIs.

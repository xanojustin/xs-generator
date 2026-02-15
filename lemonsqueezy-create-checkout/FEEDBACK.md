# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 23:15 PST] - MCP Tool Parameter Passing Confusion

**What I was trying to do:**
Validate the XanoScript files using the `validate_xanoscript` tool via the Xano MCP.

**What the issue was:**
The initial attempts to pass the code parameter failed. I tried:
1. `mcporter call xano.validate_xanoscript code="$(cat file.xs | jq -Rs .)" --output json` - This caused parsing errors
2. The error showed the entire code content was being interpreted as a single quoted string

**Why it was an issue:**
I couldn't validate my files initially because the proper way to pass file content wasn't clear from the documentation. The error messages were unhelpful - they showed the code being interpreted as a malformed string.

**Potential solution (if known):**
- Better documentation on how to pass file content to the validate_xanoscript tool
- Support for file path references (e.g., `code=@run.xs` or `file_path="run.xs"`)
- A dedicated `validate_xanoscript_file` tool that takes a file path instead of code content

---

## [2026-02-14 23:18 PST] - Working Solution for Code Validation

**What I was trying to do:**
Find a working method to validate XanoScript files.

**What the issue was:**
The working solution required using `--args` with JSON-encoded content:
```bash
CODE=$(cat file.xs) && mcporter call xano.validate_xanoscript --args "$(jq -n --arg code "$CODE" '{code: $code}')"
```

This is non-obvious and quite complex for what should be a simple operation.

**Why it was an issue:**
The barrier to entry for validating XanoScript is high. Users need to understand:
1. How to use `jq` for JSON encoding
2. The `--args` flag behavior
3. Shell variable expansion and quoting

**Potential solution (if known):**
- Add a `file_path` parameter alternative to `code` in the validate_xanoscript tool
- Provide a CLI wrapper that handles file reading internally
- Document the `--args` pattern in the MCP tool description

---

## [2026-02-14 23:20 PST] - XanoScript Syntax: Conditional Logic Ambiguity

**What I was trying to do:**
Write conditional logic to build up the checkout data object incrementally.

**What the issue was:**
The `conditional` block syntax was not entirely clear. I initially wasn't sure if `elseif` was one word or two (like `else if`).

**Why it was an issue:**
Had to search the quickstart documentation to confirm `elseif` is correct, not `else if`. This is a common mistake point.

**Potential solution (if known):**
- Include a syntax cheatsheet in the main xanoscript_docs output
- Error messages could suggest the correct syntax when `else if` is detected

---

## [2026-02-14 23:22 PST] - XanoScript Object Building Pattern Uncertainty

**What I was trying to do:**
Build a nested JSON object for the LemonSqueezy API request, conditionally adding fields.

**What the issue was:**
It was unclear how to properly update nested objects. For example, to add `checkout_data.name` after potentially already having `checkout_data.email`, I had to:
1. Get the existing checkout_data
2. Check if it was null and create empty object if so
3. Update it with the new field
4. Set it back on the parent

**Why it was an issue:**
This pattern is verbose and repetitive. The quickstart mentions `set_ifnotnull` for simple cases, but nested objects require the multi-step dance shown above.

**Potential solution (if known):**
- A `set_nested` filter that can create intermediate objects automatically
- Allow direct assignment like `var.update $attributes.checkout_data.name { value = $input.customer_name }`
- Better documentation on nested object manipulation patterns

---

## [2026-02-14 23:25 PST] - API Request JSON vs Form-Encoded Uncertainty

**What I was trying to do:**
Send a JSON API request to LemonSqueezy with the correct content type.

**What the issue was:**
The quickstart shows `params = $payload` for API requests, but different APIs expect different encodings:
- LemonSqueezy expects `application/vnd.api+json` with JSON body
- Stripe examples show `application/x-www-form-urlencoded` 
- Some APIs might expect form-encoded params

It wasn't immediately clear if XanoScript handles the encoding based on Content-Type or if I need to format the payload differently.

**Why it was an issue:**
Had to guess that `params` with JSON object would be serialized appropriately when Content-Type is set to JSON. No explicit confirmation in docs.

**Potential solution (if known):**
- Clarify in the quickstart how `params` is serialized based on Content-Type header
- Provide explicit examples for JSON vs form-encoded requests
- Consider adding a `json_body` or `form_params` parameter for explicit control

---

## Summary

Overall, the Xano MCP worked well once I figured out the parameter passing pattern. The validation tool caught no errors in my final code, which suggests either:
1. The syntax I wrote was correct, or
2. The validator is lenient

The main friction points were:
1. **Tool invocation complexity** - Passing file content is non-trivial
2. **Documentation discoverability** - Had to call multiple docs topics to get complete picture
3. **Nested object manipulation** - Verbose patterns for building JSON objects conditionally

The xanoscript_docs tool was very helpful and provided comprehensive documentation once I knew which topics to request.

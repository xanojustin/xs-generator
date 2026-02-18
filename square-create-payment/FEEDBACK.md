# FEEDBACK.md - Xano MCP/XanoScript Feedback

## Summary

This run job was created successfully after encountering several XanoScript syntax issues. The final implementation creates a Square payment using the Square API.

---

## [2026-02-17 18:47 PST] - Ternary Operator Not Supported

**What I was trying to do:**
Create a conditional base URL that switches between sandbox and production Square endpoints based on an environment variable.

**What the issue was:**
Used standard ternary syntax: `value = ($env.SQUARE_ENVIRONMENT == "production") ? "https://connect.squareup.com" : "https://connect.squareupsandbox.com"`

The validator returned: `Expecting --> } <-- but found --> '?'`

**Why it was an issue:**
Ternary operators (`? :`) are a standard feature in many languages but don't exist in XanoScript. This forced me to use a more verbose `conditional` block.

**Potential solution (if known):**
Add ternary operator support to XanoScript for concise conditional expressions, or document the workaround (using `conditional` blocks) more prominently in the quickstart guide.

---

## [2026-02-17 18:50 PST] - UUID Generation Function Not Available

**What I was trying to do:**
Generate a unique idempotency key required by Square's API using `uuidv4`.

**What the issue was:**
Tried to use `value = uuidv4` - the validator returned: `Expected an expression but found: 'uuidv4'`

Also tried `random` function: `value = (random * 1000000)|to_int|to_text` - validator returned: `but found: 'random'`

**Why it was an issue:**
Square requires an idempotency key for payment requests. Without built-in UUID or random functions, I had to use a timestamp-based approach which is less ideal.

**Potential solution (if known):**
Add built-in functions for UUID generation (`uuidv4`, `uuid`) and/or random number generation (`random`, `rand`). These are common requirements for API integrations.

---

## [2026-02-17 18:52 PST] - Hash and String Manipulation Filters Not Available

**What I was trying to do:**
Create a more unique idempotency key by hashing the source_id and taking a substring.

**What the issue was:**
Tried: `value = "sq-" ~ (now|to_int|to_text) ~ "-" ~ ($input.source_id|hash:md5|substr:0:8)`

Validator returned:
- `Unknown filter function 'hash'`
- `but found: 'md5'`
- Also `substr` is not available

**Why it was an issue:**
Without hash functions or substring operations, generating unique identifiers or manipulating strings is limited.

**Potential solution (if known):**
Add common string manipulation filters: `hash:md5`, `hash:sha256`, `substr`, `substring`, `slice`, etc.

---

## [2026-02-17 18:53 PST] - Missing Variable Reference Syntax Documentation

**What I was trying to do:**
Reference the `source_id` input variable inside a filter expression.

**What the issue was:**
Used `source_id|hash:md5` instead of `$input.source_id|hash:md5`. The validator expected `$input.` prefix.

**Why it was an issue:**
Inside the `input` block, variables are referenced directly (e.g., `text source_id`), but in the `stack` block, they must be accessed via `$input.source_id`. This distinction was not immediately clear from the docs.

**Potential solution (if known):**
Add a clear section in the quickstart guide showing the difference between:
- Defining inputs: `text source_id`
- Accessing inputs in stack: `$input.source_id`

---

## [2026-02-17 18:45 PST] - MCP Parameter Format Confusion

**What I was trying to do:**
Call the `validate_xanoscript` tool with the correct parameters.

**What the issue was:**
Initially tried various formats:
- `mcporter call xano validate_xanoscript '{"file_path": "/path"}'` - didn't work
- `mcporter call xano.validate_xanoscript 'file_path:"/path"'` - didn't work
- Finally found: `mcporter call xano.validate_xanoscript --args '{"file_path": "/path"}'` - worked

**Why it was an issue:**
The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" appeared even when these parameters were provided, suggesting the JSON wasn't being parsed correctly.

**Potential solution (if known):**
The `--args` flag requirement isn't obvious from the error message. Consider updating the error to mention "Use --args flag for JSON parameters" or provide clearer examples in the tool documentation.

---

## Positive Feedback

**What worked well:**
1. The validator provides very helpful error messages with line numbers and column positions
2. The validation errors include the actual code snippet that failed
3. Once syntax is correct, validation passes quickly
4. The structure of run jobs (run.xs + function/ + table/) is intuitive
5. The Stripe example in the repo was an excellent reference

---

## Suggestions for Documentation Improvements

1. **Quickstart**: Add a "Common Patterns" section showing:
   - How to do conditional variable assignment (ternary workaround)
   - How to generate unique IDs without UUID functions
   - How to reference input variables in different contexts

2. **Filter Reference**: A comprehensive list of available filters (the docs mention filters exist but don't list them all)

3. **Built-in Functions**: A list of available functions like `now`, and clarification on what's NOT available (uuid, random, hash)

4. **Run Job Examples**: More examples of run jobs integrating with popular APIs (the Stripe one is great, more would help)

---

## Final Implementation Notes

The Square Create Payment run job was successfully created with these workarounds:
- Used `conditional` block instead of ternary operator
- Used timestamp (`now|to_int|to_text`) instead of UUID for idempotency key
- Simplified string manipulation to avoid hash/substr filters

All files validated successfully and the implementation follows the same pattern as the Stripe example.

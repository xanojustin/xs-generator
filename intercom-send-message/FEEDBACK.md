# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-15 07:20 PST - xanoscript_docs Tool Error

**What I was trying to do:**
Get XanoScript documentation for run jobs by calling the xanoscript_docs tool with the 'run' topic.

**What the issue was:**
The xanoscript_docs tool threw an error: "Error reading XanoScript documentation: p.split is not a function"

**Why it was an issue:**
This prevented me from getting specific documentation about run job structure and syntax. I had to rely on existing examples in the ~/xs folder instead of proper documentation.

**Potential solution (if known):**
There appears to be a bug in the MCP server's documentation retrieval function. The error suggests a string splitting operation is being called on something that's not a string.

---

## 2026-02-15 07:25 PST - xanoscript_docs Returns Wrong Topic

**What I was trying to do:**
Call xanoscript_docs with specific topics like 'run', 'functions', 'quickstart' to get targeted documentation.

**What the issue was:**
No matter what topic I specified (e.g., 'run', 'functions', 'quickstart'), the tool always returned the same 'syntax' documentation with the message "Matched topics: syntax".

**Why it was an issue:**
I couldn't get documentation specific to run jobs, functions, or other XanoScript constructs. The tool seemed to ignore the topic parameter entirely and always return the syntax reference.

**Potential solution (if known):**
The topic matching logic in the MCP server may not be working correctly, or the documentation files for other topics may not be properly configured.

---

## 2026-02-15 07:30 PST - validate_xanoscript Input Method Confusion (RESOLVED)

**What I was trying to do:**
Validate XanoScript code using the validate_xanoscript tool. I tried multiple approaches that all failed:
1. `mcporter call xano validate_xanoscript -- "$(cat file.xs)"`
2. `cat file.xs | jq -Rs '{code: .}' | mcporter call xano validate_xanoscript`
3. Writing to a temp file and using `--input /tmp/file.json`
4. Using `@/tmp/file.json` syntax

**What the issue was:**
None of the standard mcporter input methods worked. All approaches failed with errors like:
- "Expecting --> function <-- but found --> '-' <--"
- "Too many positional arguments (2) supplied"
- "'code' parameter is required"

**Why it was an issue:**
I couldn't validate my code before committing.

**RESOLUTION:**
A subagent discovered the correct syntax:
```bash
mcporter call "xano.validate_xanoscript(code: $(jq -Rs . ~/xs/intercom-send-message/function/send_message.xs))"
```

Or using variable assignment:
```bash
CODE=$(cat file.xs) && mcporter call xano validate_xanoscript "code=$CODE"
```

The key insight is using `xano.validate_xanoscript(code: ...)` syntax instead of `xano validate_xanoscript`.

---

## 2026-02-15 07:40 PST - XanoScript Syntax Issues Discovered During Validation

**What I was trying to do:**
Validate the Intercom send message function after finding the correct validation syntax.

**What the issues were:**

### 1. `boolean` is not a valid input type
```xs
// ❌ Invalid
boolean use_template?=false { description = "..." }

// ✅ Valid  
text use_template?="false" filters=trim { description = "..." }
```

### 2. Multiline precondition expressions don't parse
```xs
// ❌ Invalid
precondition (
  ($input.a != null) ||
  ($input.b != null)
) { ... }

// ✅ Valid
precondition (($input.a != null) || ($input.b != null)) { ... }
```

### 3. `body` is not a valid api.request parameter
```xs
// ❌ Invalid
api.request {
  body = $payload|json_encode
  ...
}

// ✅ Valid
api.request {
  params = $payload
  ...
}
```

**Why it was an issue:**
These syntax issues weren't obvious from reading examples. The documentation doesn't clearly specify valid input types or api.request parameters.

**Potential solution (if known):**
Better documentation about:
- Valid input types (only `text`, `integer`, `decimal`, `timestamp`, `object`, `array`?)
- api.request parameters (body vs params confusion)
- Expression formatting in preconditions

---

## Summary

The Xano MCP server works but has documentation/usability issues:

1. **Documentation retrieval is broken** - xanoscript_docs returns syntax docs regardless of requested topic
2. **Validation syntax is non-obvious** - The correct mcporter call syntax is `xano.validate_xanoscript(code: ...)` not `xano validate_xanoscript -- ...`
3. **Missing type documentation** - `boolean` input type doesn't exist but isn't documented
4. **api.request parameter confusion** - `body` vs `params` isn't clearly explained

Once the correct validation syntax was discovered, the tool worked well and caught real syntax errors.

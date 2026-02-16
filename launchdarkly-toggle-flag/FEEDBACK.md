# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 00:52 PST - Boolean Type Name

**What I was trying to do:**
Create a function input parameter for a boolean value to control whether a feature flag should be enabled or disabled.

**What the issue was:**
I initially used `boolean enabled` as the input type, but the validator returned:
```
[Line 5, Column 5] Expecting --> } <-- but found --> 'boolean'
```

**Why it was an issue:**
The error message was confusing because it suggested a missing closing brace rather than indicating that `boolean` is not a valid type name. I had to look up the types documentation to discover that the correct type is `bool`, not `boolean`.

**Potential solution:**
The validator could provide a more helpful error message like: "Unknown type 'boolean'. Did you mean 'bool'?" This would be similar to how other language compilers suggest corrections.

---

## 2025-02-16 00:55 PST - Reserved Variable Names

**What I was trying to do:**
Declare a variable to hold the response data that would be returned from the function.

**What the issue was:**
I first tried naming the variable `$response`, which resulted in:
```
[Line 51, Column 13] '$response' is a reserved variable name and should not be used as a variable.
```

Then I tried `$output`, which also failed:
```
[Line 51, Column 13] '$output' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
There's no documentation in the quick reference about which variable names are reserved. I had to guess multiple times before finding a name that worked (`$job_result`).

**Potential solution:**
Add a section to the quickstart or syntax documentation listing all reserved variable names. Common reserved names like `$response`, `$output`, `$result`, `$data`, `$value` should be clearly documented.

---

## 2025-02-16 00:57 PST - Throw Statement Syntax

**What I was trying to do:**
Create error handling with `throw` statements that include descriptive error messages.

**What the issue was:**
I initially wrote throw statements with commas between properties:
```xs
throw {
  name = "AuthenticationError",
  value = "Invalid LaunchDarkly API key"
}
```

This resulted in a syntax error:
```
[Line 65, Column 39] Expecting --> } <-- but found --> ','
```

**Why it was an issue:**
The error message pointed to a line that didn't obviously indicate the comma was the problem. I had to experiment to discover that commas are not allowed between properties in throw blocks (unlike regular object literals).

**Potential solution:**
The documentation examples show throw statements but don't explicitly mention that commas shouldn't be used. A note in the quickstart about "throw statements don't use commas between properties" would help. Alternatively, the validator could accept commas for consistency with object syntax.

---

## 2025-02-16 00:48 PST - MCP Documentation Discovery

**What I was trying to do:**
Find the correct XanoScript syntax for run jobs and functions.

**What the issue was:**
The initial `xanoscript_docs` call without parameters returns a great overview, but finding specific topics requires knowing the exact topic names. The topic list is only shown after the first call.

**Why it was an issue:**
I needed to make multiple documentation calls to get the complete picture: first for the overview, then for `run` topic, then for `quickstart`, then for `types`, then for `integrations`.

**Potential solution:**
Consider adding a `search` parameter to `xanoscript_docs` that allows fuzzy searching. For example, `xanoscript_docs({ search: "boolean type" })` could return relevant sections from multiple topics.

---

## Summary

Overall the Xano MCP validation tool is very helpful - it catches errors quickly and provides line/column information. The main improvements would be:

1. **Better error messages** - Suggest corrections for common mistakes (e.g., "Did you mean 'bool'?")
2. **Document reserved words** - List all reserved variable names in the quickstart
3. **Clarify throw syntax** - Explicitly document that throw blocks don't use commas
4. **Documentation search** - Allow searching across topics rather than requiring exact topic names

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-14 23:50 PST] - crypto.hash Operation Not Available

**What I was trying to do:**
Generate a signed Imgix URL which requires HMAC-SHA256 hashing with base64 encoding to create a signature parameter.

**What the issue was:**
The `crypto.hash` operation I attempted to use does not exist in XanoScript. I tried the following syntax:
```xs
crypto.hash {
  algorithm = "sha256"
  input = $signature_input
  encoding = "base64"
} as $hash_result
```

The validator returned: `[Line 107, Column 5] Expecting --> } <-- but found --> 'crypto'`

**Why it was an issue:**
Imgix requires signed URLs for secure image processing. Without a hashing function, I cannot generate the signature required for secure URLs. I had to fall back to unsigned URLs, which may not work for all Imgix configurations (especially those with secure URL requirements enabled).

**Potential solution (if known):**
- Add a `crypto.hash` operation to XanoScript with support for common algorithms (SHA256, SHA1, MD5)
- Support various output encodings (base64, hex)
- Document the available cryptography operations in the integrations or syntax topics

---

## [2026-02-14 23:48 PST] - MCP validate_xanoscript Parameter Format Unclear

**What I was trying to do:**
Validate XanoScript files using the MCP `validate_xanoscript` tool.

**What the issue was:**
The documentation for the MCP tool doesn't clearly specify the parameter format. I initially tried passing `file_path` which was rejected. Through trial and error, I discovered it requires a `code` parameter with the actual file content.

Error messages:
- `Error: 'code' parameter is required`

**Why it was an issue:**
Had to guess the correct parameter format. The MCP tool listing doesn't show parameter schemas or examples.

**Potential solution (if known):**
- Add parameter documentation to the MCP tool schema
- Support both `code` (string content) and `file_path` (path to file) parameters for convenience
- Include usage examples in the tool description

---

## [2026-02-14 23:45 PST] - Limited Documentation on Available Operations

**What I was trying to do:**
Find documentation on what operations are available in XanoScript, specifically for:
- Cryptography/hashing
- String manipulation beyond filters
- Available API request options

**What the issue was:**
The `xanoscript_docs` MCP tool returns the same generic documentation structure for all topics. The "integrations" topic didn't list available operations. I couldn't find a comprehensive reference of all available stack operations.

**Why it was an issue:**
Without knowing what operations are available, I'm guessing at syntax. For example, I don't know if there's a way to do:
- HMAC hashing
- String splitting/joining
- Date formatting
- Regular expressions

**Potential solution (if known):**
- Create a comprehensive "operations" or "reference" topic that lists all available stack operations
- Document each operation with its parameters and return values
- Include examples for each operation

---

## [2026-02-14 23:42 PST] - Substring Filter Syntax Uncertainty

**What I was trying to do:**
Extract a substring from a hashed value (truncate to 8 characters for Imgix signature).

**What the issue was:**
I guessed the syntax might be `|substr:0:8` based on common patterns, but I couldn't find documentation confirming this. The filters documentation is limited.

**Why it was an issue:**
Without confirmation of the correct filter syntax, the code might fail validation or produce unexpected results.

**Potential solution (if known):**
- Document all available filters in the syntax or quickstart topics
- Include examples of filter chaining and parameterized filters

---

## [2026-02-14 23:40 PST] - Variable Reassignment Pattern Unclear

**What I was trying to do:**
Build up a query string incrementally by appending parameters conditionally.

**What the issue was:**
I wasn't sure if the pattern of declaring `var $query_params` multiple times within different `conditional` blocks is valid, or if I should use `var.update`. The existing examples show `var.update` for modifying objects but not for simple string concatenation.

Example of what I did:
```xs
var $query_params { value = "auto=compress,format" }
conditional {
  if ($input.width != null) {
    var $query_params { value = $query_params ~ "&w=" ~ $input.width }
  }
}
```

**Why it was an issue:**
Unclear whether this creates a new variable in the local scope or updates the outer scope variable. Could lead to bugs if scoping works differently than expected.

**Potential solution (if known):**
- Clarify variable scoping rules in the documentation
- Show patterns for building strings/values incrementally
- Document the difference between `var` and `var.update` more clearly

---

## Summary

The main blockers were:
1. **No crypto operations available** - Had to remove signature generation entirely
2. **MCP parameter format** - Had to guess the correct way to call validate_xanoscript
3. **Limited operation reference** - Couldn't find a comprehensive list of available operations

The validation tool works well once the correct syntax is known, but discovering that syntax was challenging without comprehensive documentation.

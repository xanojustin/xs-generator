# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 19:18 PST] - cloud.algolia.* Operations Not Recognized

**What I was trying to do:**
Create a run job using Algolia search integration as documented in the XanoScript docs.

**What the issue was:**
The `cloud.algolia.save_objects` and `cloud.algolia.save_object` operations failed validation with the error:
```
Expecting: one of these possible Token sequences:
  1. [request]
but found: 'save_objects'
```

**Why it was an issue:**
The documentation clearly lists these as available operations:
- `cloud.algolia.search`
- `cloud.algolia.save_object`
- `cloud.algolia.save_objects`
- `cloud.algolia.delete_object`
- `cloud.algolia.set_settings`

However, the validator only accepts `cloud.algolia.request`, suggesting the documented Algolia-specific operations haven't been implemented in the language server yet.

**Potential solution (if known):**
The MCP/language server needs to be updated to recognize the Algolia-specific operations as documented. Alternatively, the documentation should be updated to show the correct syntax if it's different (e.g., using `cloud.algolia.request` with a `method` parameter).

**Workaround used:**
I had to use `api.request` directly to call Algolia's REST API endpoints instead of the convenient `cloud.algolia.*` operations.

---

## [2025-02-17 19:22 PST] - Reserved Variable Names Not Documented

**What I was trying to do:**
Create a variable to hold the final response data before returning it.

**What the issue was:**
Using `var $response` failed validation with:
```
'$response' is a reserved variable name and should not be used as a variable.
```

Then using `var $output` also failed:
```
'$output' is a reserved variable name and should not be used as a variable.
```

**Why it was an issue:**
These are natural variable names developers would use, but they're reserved without being documented in the cheatsheet or types documentation I reviewed. Trial and error was needed to find acceptable names.

**Potential solution (if known):**
Add a section to the documentation (cheatsheet or syntax topics) listing all reserved variable names that cannot be used with `var`. Common reserved names like `$response`, `$output`, `$input`, `$env` should be clearly documented.

---

## [2025-02-17 19:15 PST] - Documentation/Implementation Mismatch

**What I was trying to do:**
Use the `xanoscript_docs` MCP tool to get accurate documentation before writing code.

**What the issue was:**
The documentation retrieved from `xanoscript_docs(topic: "integrations/search")` showed Algolia operations that don't actually validate. This creates a mismatch between what the docs say is available and what the language server accepts.

**Why it was an issue:**
When the docs say something exists but it doesn't work, it causes confusion and wasted time trying to debug syntax that should be valid.

**Potential solution (if known):**
Either:
1. Update the MCP to return documentation that matches the actual language server capabilities
2. Update the language server to support the documented features
3. Add version notes to the documentation indicating which features are available in which versions

---

## General Observations

### What Worked Well
- The `api.request` function worked perfectly for making HTTP calls to external APIs
- The `mcporter` integration made it easy to call MCP tools
- Validation errors were helpful and included suggestions
- The folder structure and run.job syntax was straightforward

### Suggestions for MCP Improvement
1. **Version compatibility check**: A way to check which features are actually available in the current language server version
2. **Reserved words list**: Documentation of all reserved variable names
3. **Better error context**: The line numbers in validation errors were accurate and helpful

### XanoScript Feedback
- The syntax is clean and readable
- The `var` vs `var.update` distinction is clear
- String concatenation with `~` is intuitive
- The filter syntax (e.g., `|count`, `|to_text`) is powerful

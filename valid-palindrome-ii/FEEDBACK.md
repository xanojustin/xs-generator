# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 20:35 PST] - Nested functions not allowed inside stack blocks

**What I was trying to do:** Create a helper function `is_palindrome_range` inside the main function's stack block to check if a substring is a palindrome. This is a common pattern in other languages to keep helper logic encapsulated.

**What the issue was:** The validation failed with error: `Expecting: one of these possible Token sequences... but found: 'function'`. Nested function definitions are not allowed inside stack blocks.

**Why it was an issue:** I had to inline the helper logic twice (once for skipping left, once for skipping right) instead of calling a reusable helper function. This made the code longer and more repetitive.

**Potential solution (if known):** 
1. Allow nested functions inside stack blocks for better code organization
2. Or, document this limitation more prominently in the functions documentation with examples of how to work around it
3. Consider supporting a `function.define` or similar construct for local helper functions

---

## [2025-02-24 20:32 PST] - Directory validation not finding .xs files

**What I was trying to do:** Use the `directory` parameter to validate all .xs files at once.

**What the issue was:** `mcporter call xano.validate_xanoscript directory="."` returned "No .xs files found in directory: ." even though the files existed.

**Why it was an issue:** I had to validate files individually using `file_path` parameter instead of batch validation.

**Potential solution (if known):** 
1. Check if the MCP server resolves paths correctly when called from different working directories
2. The directory parameter might need absolute paths or might have issues with the glob pattern

---

## [2025-02-24 20:30 PST] - File paths array parameter format unclear

**What I was trying to do:** Use the `file_paths` array parameter to validate multiple files at once.

**What the issue was:** The mcporter CLI rejected the format `file_paths:=["path1","path2"]` with error "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required".

**Why it was an issue:** I had to validate files one at a time instead of batch validation. The documentation says file_paths accepts an array but the CLI syntax wasn't clear.

**Potential solution (if known):** 
1. Provide clearer examples in the MCP documentation for how to pass arrays via CLI
2. The mcporter CLI might need better handling of array parameters

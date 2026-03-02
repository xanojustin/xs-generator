# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-01 20:35 PST] - MCP file_paths parameter format confusion

**What I was trying to do:** Validate multiple XanoScript files at once using the `file_paths` parameter

**What the issue was:** The MCP documentation says `file_paths` accepts an array, but I initially tried passing a comma-separated string like `--file-paths file1.xs,file2.xs`. This resulted in error: `expected array, received string`.

**Why it was an issue:** The mcporter CLI help doesn't clearly show how to pass array parameters. I had to guess and use `--args '{"file_paths":[...]}'` JSON format.

**Potential solution:** The MCP or mcporter could:
1. Accept comma-separated strings and convert internally
2. Better document array parameter syntax in mcporter help
3. Support repeated flags like `--file-paths file1.xs --file-paths file2.xs`

---

## [2026-03-01 20:37 PST] - Directory validation didn't find files

**What I was trying to do:** Use the `directory` parameter to validate all `.xs` files in the exercise folder

**What the issue was:** `mcporter call xano.validate_xanoscript directory=~/xs/emirp-numbers` returned "No .xs files found in directory"

**Why it was an issue:** The tilde (`~`) path expansion or relative path might not be working correctly. Using absolute paths with `file_paths` worked fine.

**Potential solution:** The MCP should expand `~` to the home directory, or the documentation should clarify that absolute paths are required.

---

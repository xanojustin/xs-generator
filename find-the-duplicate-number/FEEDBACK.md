# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-26 20:31 PST] - mcporter Parameter Format Discovery

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my XanoScript files

**What the issue was:** The mcporter CLI expects parameters in `key=value` format, not JSON format like `'{"file_path": "..."}'`. I tried multiple approaches:
1. JSON format: `mcporter call xano validate_xanoscript '{"file_path": "run.xs"}'` → Error about required parameters
2. Double-dash format: `mcporter call xano validate_xanoscript --file_path "run.xs"` → Parsed as XanoScript code, not parameters
3. JSON with file_paths array: Various attempts all failed

**Why it was an issue:** The documentation shows TypeScript-style function signatures with object parameters, but the CLI actually requires `key=value` style arguments. This mismatch caused confusion and wasted time trying different formats.

**Potential solution:** 
- Update the MCP tool documentation to clearly show CLI usage examples with `key=value` format
- Or make the CLI accept both formats for better DX

---

## [2025-02-26 20:32 PST] - Working Directory Issue

**What I was trying to do:** Validate files using relative paths from within the exercise directory

**What the issue was:** Even when running from `~/xs/find-the-duplicate-number/`, using `file_path="run.xs"` returned "File not found"

**Why it was an issue:** The mcporter command seems to resolve paths from its own context, not from the shell's current working directory. Had to use absolute paths (`/Users/justinalbrecht/xs/find-the-duplicate-number/run.xs`) to make it work.

**Potential solution:**
- Document that absolute paths are required, or
- Make mcporter respect the shell's current working directory

---

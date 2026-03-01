# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-28 17:32 PST] - JSON Parameter Passing Confusion

**What I was trying to do:** Call the `validate_xanoscript` tool with a directory parameter to validate all files in the utf8-validation folder.

**What the issue was:** The mcporter CLI syntax for passing JSON parameters was unclear. I initially tried:
- `mcporter call xano validate_xanoscript '{"directory": "/path"}'` - didn't work
- `mcporter call xano validate_xanoscript --params '{...}'` - didn't work
- `mcporter call xano validate_xanoscript --directory /path` - didn't work

The correct syntax required using `--args` flag:
```bash
mcporter call xano validate_xanoscript --args '{"directory":"/path"}'
```

**Why it was an issue:** This was blocking because I couldn't validate the code without knowing the correct parameter syntax. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" wasn't helpful since I was providing those parameters, just in the wrong format.

**Potential solution:** 
1. The MCP tool description could include example mcporter calls showing the `--args` syntax
2. The error message could hint at the correct syntax for passing parameters
3. The `mcporter describe` output could show usage examples for each parameter type

---

## [2025-02-28 17:35 PST] - Incomplete Exercise Detection

**What I was trying to do:** Find an incomplete exercise to work on from the `~/xs/` folder.

**What the issue was:** I discovered that `utf8-validation` already had valid code but was missing documentation files (README.md, CHANGES.md, FEEDBACK.md). The folder structure indicated it was incomplete (only 4 items vs 7 for completed exercises).

**Why it was an issue:** It wasn't immediately obvious whether I should:
1. Create a brand new exercise
2. Complete the existing incomplete one

The instructions say "Pick a random coding exercise that isn't already implemented" but the utf8-validation folder existed with code in it.

**Potential solution:**
1. Add a status indicator in each exercise folder (e.g., `.status` file with "incomplete" or "complete")
2. Or have a manifest file listing completed vs incomplete exercises
3. The existing convention of checking item count works but is implicit knowledge

---

## [2025-02-28 17:37 PST] - XanoScript Syntax Validation Passed

**What I was trying to do:** Validate the existing XanoScript code.

**What the issue was:** The existing code passed validation on the first try. This is actually positive feedback - the code structure was correct.

**Why it was an issue:** None - the validation tool worked as expected once I figured out the correct syntax.

**Note:** The existing implementation appears to be correct. The exercise just needed documentation.

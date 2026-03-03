# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 12:35 PST] - Directory validation not finding files

**What I was trying to do:** Validate all .xs files in the exercise directory using the `directory` parameter

**What the issue was:** When running `mcporter call xano.validate_xanoscript directory="."` from within the exercise folder, it returned "No .xs files found in directory: ."

**Why it was an issue:** The directory validation feature appears to not work as expected, requiring me to validate files individually using `file_path` parameter instead

**Potential solution:** The directory parameter may need an absolute path, or the recursive file finding may not be working properly. The workaround of using individual file_path validation works fine.

---

## [2026-03-03 12:35 PST] - Shell quoting issues with file_paths array parameter

**What I was trying to do:** Use the `file_paths` array parameter to validate multiple files at once

**What the issue was:** Shell escaping of JSON arrays in zsh is problematic. Command: `mcporter call xano.validate_xanoscript file_paths='["/Users/..."]'` resulted in "unmatched " error

**Why it was an issue:** Could not batch validate files using the array parameter due to shell quoting issues

**Potential solution:** The mcporter CLI might need better handling of array parameters, or documentation on proper shell escaping for complex JSON types. Individual file validation works as a workaround.

---

## [2026-03-03 12:35 PST] - Positive validation experience

**What I was trying to do:** Validate XanoScript files

**What went well:** Both files passed validation on the first attempt. The error messages from previous exercises helped me understand proper syntax patterns.

**Feedback:** The validation tool is helpful and catches syntax errors early. The quick_reference documentation is excellent for getting the syntax right.

---

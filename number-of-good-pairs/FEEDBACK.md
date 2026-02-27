# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 07:35 PST] - Parameter Passing Syntax

**What I was trying to do:** Call the `validate_xanoscript` tool to validate my .xs files

**What the issue was:** Initially struggled with the correct parameter passing syntax for mcporter. Tried several approaches:
- `'{"file_paths": ["run.xs", "function/number_of_good_pairs.xs"]}'` - JSON format didn't work
- `'{"directory": "."}'` with relative path - didn't find files
- Finally worked with `directory="/Users/justinalbrecht/xs/number-of-good-pairs"` format

**Why it was an issue:** The tool kept returning "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" even when parameters were provided.

**Potential solution:** The MCP could provide clearer documentation on the expected parameter format, or the mcporter help output could show more examples for JSON parameter passing.

## [2025-02-27 07:36 PST] - Documentation Topic Parameter

**What I was trying to do:** Retrieve specific XanoScript documentation topics using `xanoscript_docs`

**What the issue was:** The documentation appeared to return the same readme content regardless of which topic was requested. Tried topics "essentials", "functions", and "run" but all returned similar content.

**Why it was an issue:** Couldn't access specific syntax documentation for functions vs run jobs, had to rely on existing code examples.

**Potential solution:** The MCP should ensure topic-specific documentation is returned when a topic parameter is provided.

## Overall Assessment

Despite the documentation access issues, the validation tool worked perfectly. The XanoScript syntax was intuitive enough that I could write valid code on the first attempt by following the patterns from existing exercises. The structure (run.job calling function) is clean and easy to understand.


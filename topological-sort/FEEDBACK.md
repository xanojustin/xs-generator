# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-23 22:35 PST - MCP Tool Parameter Passing Confusion

**What I was trying to do:** Validate XanoScript files using the validate_xanoscript tool

**What the issue was:** The parameter passing syntax for mcporter call was unclear. Initially tried various JSON quoting approaches that all failed with "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:** Wasted several attempts trying to figure out the correct syntax:
- `mcporter call xano validate_xanoscript '{"file_path":"..."}'` - failed
- `mcporter call xano.validate_xanoscript '{"file_path":"..."}'` - failed
- Various other quoting attempts failed

**Potential solution:** The skill documentation (mcporter/SKILL.md) mentions `--args` flag, but it's easy to miss. Perhaps a clearer example in the tool description itself would help, or making the JSON-in-positional-arg work more reliably.

**What worked:** `mcporter call xano.validate_xanoscript --args '{"file_path":"..."}'`

---

## 2025-02-23 22:32 PST - xanoscript_docs Returns Same Content for All Topics

**What I was trying to do:** Get specific documentation for functions, run jobs, and syntax by calling xanoscript_docs with different topics

**What the issue was:** Called `mcporter call xano xanoscript_docs '{"topic": "functions"}'` and `'{"topic": "run"}'` and `'{"topic": "syntax"}'` but all returned identical general overview content

**Why it was an issue:** Couldn't get specific syntax details for run.job structure or function-specific patterns, had to rely on reading existing example files instead

**Potential solution:** The topic parameter filtering might not be working correctly, or the documentation system might need separate content files per topic

---

## 2025-02-23 22:30 PST - No Issues with XanoScript Syntax

**What I was trying to do:** Write a topological sort implementation in XanoScript

**What happened:** The code passed validation on the first attempt

**Note:** After studying existing examples (fizzbuzz, course-schedule), the syntax patterns were clear enough to write correct code without needing additional documentation. The existing exercises serve as good reference material.


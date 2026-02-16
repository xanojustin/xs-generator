# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 04:47 PST] - run.job construct not recognized by validator

**What I was trying to do:**
Create a run.xs file using the `run.job` construct, following the pattern from existing implementations in the ~/xs folder.

**What the issue was:**
The `run.job` syntax appears to work based on existing files, but I was concerned when the validator output suggested it expected `function` at line 1. However, when validating the actual files, they all passed - including the run.xs file with `run.job` construct.

**Why it was an issue:**
Initial confusion about whether `run.job` was valid syntax, since the documentation and error messages weren't clear about this construct being valid.

**Potential solution (if known):**
Add explicit documentation about the `run.job` construct in the xanoscript_docs output, explaining it's a valid construct for defining run jobs.

---

## [2026-02-16 04:50 PST] - mcporter validate_xanoscript tool requires complex parameter passing

**What I was trying to do:**
Validate XanoScript files using the MCP `validate_xanoscript` tool via mcporter CLI.

**What the issue was:**
The tool requires a `code` parameter containing the file content, but passing multi-line XanoScript code through shell commands is extremely difficult due to:
1. Quote escaping issues (nested double quotes inside XanoScript strings)
2. Newline handling (shell arguments don't preserve newlines well)
3. Special character escaping

I tried multiple approaches:
- Direct inline strings with escaped quotes
- Using `{{STDIN}}` placeholder
- Using `@filename` notation
- Using `--args` with inline JSON

None of these worked reliably.

**Why it was an issue:**
The validation tool is essentially unusable from the command line without writing a wrapper script. This makes it difficult to validate files quickly during development.

**Potential solution (if known):**
1. Support a `file_path` parameter that reads directly from a file
2. Support stdin input properly
3. Document the expected parameter format more clearly with working examples
4. Provide a simpler CLI interface like: `mcporter call xano validate_xanoscript --file path/to/file.xs`

---

## [2026-02-16 04:55 PST] - xanoscript_docs returns same content for different topics

**What I was trying to do:**
Get specific documentation for different topics (`quickstart`, `functions`, `run`) to understand the proper syntax for writing a run job.

**What the issue was:**
All three topic queries returned identical content - the general README/documentation overview rather than topic-specific documentation. The topics listed in the documentation index (like `quickstart`, `functions`, `run`) don't seem to actually return differentiated content.

**Why it was an issue:**
I needed specific syntax examples for:
- Run job structure (`run.job` construct)
- Function definition patterns
- Proper input/stack/response syntax

Instead, I had to rely on reading existing implementations from the ~/xs folder.

**Potential solution (if known):**
Ensure the `xanoscript_docs` tool actually returns topic-specific content when different topics are requested. The current implementation seems to ignore the topic parameter or always return the default README.

---

## [2026-02-16 05:00 PST] - Missing documentation for run.job construct

**What I was trying to do:**
Understand the exact syntax for the `run.job` construct, including:
- What fields are required vs optional
- The proper format for the `main` block
- How to specify multiple functions or alternative entry points

**What the issue was:**
The documentation returned by `xanoscript_docs` doesn't mention `run.job` at all. I had to infer the syntax from existing files in the ~/xs folder. The Quick Reference table lists many constructs (`workspace`, `table`, `function`, `task`, etc.) but `run.job` is not among them, even though there's a `run` folder mentioned in the workspace structure.

**Why it was an issue:**
Had to rely entirely on copy-pasting from existing implementations without understanding what each field does or what alternatives exist.

**Potential solution (if known):**
Add `run.job` to the Quick Reference table and provide documentation about:
- Required/optional fields
- The `main` block structure
- The `env` array format
- How to specify different entry points

---

## [2026-02-16 05:05 PST] - MCP server location dependent on working directory

**What I was trying to do:**
Call the Xano MCP from different directories to validate files.

**What the issue was:**
The MCP server configuration is stored in `/Users/justinalbrecht/.openclaw/workspace/config/mcporter.json`, and mcporter can only find it when running from that directory or directories with their own config. Running from other directories (like `~/xs/twilio-verify-phone`) resulted in "Unknown MCP server 'xano'" errors.

**Why it was an issue:**
Had to remember to `cd` to the correct directory before each mcporter call, which was error-prone and not intuitive.

**Potential solution (if known):**
1. Support a global config location (e.g., `~/.config/mcporter/config.json`)
2. Support an environment variable like `MCPORTER_CONFIG` to specify the config location
3. Support a `--config` flag to specify the config file path

---

## Summary

The main struggles were:

1. **Validation workflow is cumbersome** - Had to write a Python wrapper script to validate files reliably
2. **Documentation gaps** - Missing info on `run.job` construct and topic-specific docs don't work
3. **CLI usability** - Complex parameter passing requirements and directory-dependent config

Despite these issues, I was able to successfully create the Twilio Verify run job by:
- Using existing implementations as reference
- Writing a Python validation helper
- Carefully testing each file individually
# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-03 02:35 PST] - Parameter Format Uncertainty

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths

**What the issue was:** The MCP tool expects `file_paths` as an array, but I initially tried:
1. `files='[...]'` - wrong parameter name
2. `file_paths='/path1,/path2'` - comma-separated string
3. Both resulted in errors

**Why it was an issue:** The error messages didn't clearly indicate the expected format. Had to inspect the schema with `--schema` to understand the correct JSON array format.

**Potential solution:** 
- Provide clearer examples in the error messages
- Accept comma-separated strings as a convenience fallback
- Document common parameter patterns in the MCP tool descriptions

---

## [2026-03-03 02:32 PST] - Lack of run.job Documentation

**What I was trying to do:** Understand the `run.job` construct for the entry point file

**What the issue was:** The `xanoscript_docs` tool has topics for `functions`, `tasks`, `apis`, etc., but I couldn't find specific documentation for `run.job`. Had to examine existing exercise files to understand the pattern.

**Why it was an issue:** The workflow requires `run.job` as the entry point, but there's no clear documentation on its structure or available options.

**Potential solution:**
- Add a `run` topic to `xanoscript_docs` covering `run.job` and related constructs
- Include example patterns for common use cases (testing, batch jobs, etc.)

---

## [2026-03-03 02:30 PST] - Initial MCP Discovery

**What I was trying to do:** Determine if the Xano MCP was available and how to access it

**What the issue was:** No clear indication in the initial prompt about how to access the MCP or whether it was already configured.

**Why it was an issue:** Had to manually check `mcporter list` and `npm list` to discover the MCP was already configured and available.

**Potential solution:**
- Consider having the cron task include MCP status in the initial context
- Document expected MCP configuration in the task prompt

---

## Overall Impressions

The XanoScript syntax itself was well-documented through the `xanoscript_docs` tool. The `essentials` and `functions` topics provided clear examples that made implementation straightforward. The validation tool is fast and helpful.

Main areas for improvement:
1. Better parameter format documentation/error messages
2. Documentation for `run.job` construct
3. Clearer MCP setup/discovery process

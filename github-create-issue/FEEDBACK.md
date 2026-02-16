# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-16 12:18 PST - MCP Tool Parameter Format Confusion

**What I was trying to do:**
Validate the XanoScript files I created using the Xano MCP's validate_xanoscript tool.

**What the issue was:**
I initially tried calling the tool with JSON parameters like:
```
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
```

But this resulted in an error: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

I then tried using `--file_path` syntax like traditional CLI flags, which caused validation errors because the tool interpreted `--file_path` as literal code to validate.

**Why it was an issue:**
The MCP tool expects parameters in a key=value format (e.g., `file_path=/path/to/file.xs`) rather than JSON or standard CLI flags. This is non-standard compared to most CLI tools and wasn't immediately obvious from the documentation.

**Potential solution (if known):**
- Add clearer examples in the tool description showing the exact format: `mcporter call xano validate_xanoscript file_path=/path/to/file.xs`
- Consider supporting JSON parameter format as well for consistency with other tools
- The Examples section in `mcporter describe` shows `file_path: "/path/to/file.md"` with a colon which is also confusing since the actual working format uses equals sign

---

## 2025-02-16 12:15 PST - Documentation Not Specific to Run Jobs

**What I was trying to do:**
Understand the exact syntax for creating a run.job configuration and the proper file structure for a Xano Run Job project.

**What the issue was:**
When I called `xanoscript_docs({ topic: "run" })`, I received generic documentation that didn't have specific examples for run.job syntax. The documentation showed the directory structure includes a `run/` folder, but the existing implementations in ~/xs/ use `run.xs` at the root level instead.

**Why it was an issue:**
There was a mismatch between the documented structure (`run/` folder) and the actual working implementations (`run.xs` file). I had to inspect existing implementations to understand the correct pattern.

**Potential solution (if known):**
- Add specific run.job syntax examples to the documentation
- Clarify when to use `run.xs` vs the `run/` folder structure
- Include a complete working example of a run job with the function it calls

---

## 2025-02-16 12:15 PST - Lack of Syntax Reference for run.job Construct

**What I was trying to do:**
Write the correct syntax for the run.job configuration in `run.xs`.

**What the issue was:**
The documentation doesn't provide clear syntax for the run.job construct. I had to infer it from looking at existing implementations. I was unsure about:
- Whether to use `run.job` or `run.service`
- The exact structure of the `main` block
- How to specify the `env` array
- Whether the input values should use `=` or `:` syntax

**Why it was an issue:**
Without clear syntax documentation, I had to reverse-engineer the format from existing files, which could lead to errors if those files have variations I'm not aware of.

**Potential solution (if known):**
- Add a dedicated `run` topic to xanoscript_docs with complete run.job syntax
- Document all available fields in the run.job configuration
- Provide examples showing different configuration options

---
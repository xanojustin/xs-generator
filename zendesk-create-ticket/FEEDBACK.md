# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-14 04:18 PST - MCP validate_xanoscript Tool Parameter Passing Issues

**What I was trying to do:**
Validate XanoScript files using the Xano MCP's `validate_xanoscript` tool before committing.

**What the issue was:**
The `validate_xanoscript` tool requires a `code` parameter containing the XanoScript code to validate. However, passing the code content via `mcporter call` proved extremely difficult:

1. Passing a file path resulted in: `Error: 'code' parameter is required`
2. Using `--code @filename` syntax failed with exit code 1
3. Attempting to JSON-encode the file content and pass it inline caused parsing errors
4. The hyphen in `run.job` construct appeared to cause parsing issues ("Expecting --> function <-- but found --> '-'")

**Why it was an issue:**
Without working validation, I couldn't confirm the XanoScript syntax was correct before committing. I had to manually compare my code against existing implementations to ensure correctness, which is error-prone and time-consuming.

**Potential solution (if known):**
- Accept a `file_path` parameter in addition to `code` for easier file validation
- Provide a CLI tool that can validate files directly (like `xano validate file.xs`)
- Document the proper way to pass multi-line code strings via mcporter

---

## 2026-02-14 04:15 PST - Documentation Lacks Run Job Structure Details

**What I was trying to do:**
Create a proper run.job structure following the pattern in the xs/ folder.

**What the issue was:**
The `xanoscript_docs({ topic: "run" })` documentation only returned the general README content without specific syntax details for the `run.job` construct. I had to examine existing implementations (stripe-charge-customer, twilio-send-sms) to understand:
- The proper file structure (run.xs, function/*.xs, README.md)
- The run.job syntax with `main`, `input`, and `env` blocks
- How to reference functions from the run job

**Why it was an issue:**
Without specific documentation, I had to reverse-engineer the format from existing files, which may not represent current best practices.

**Potential solution (if known):**
- Add a dedicated `run` topic with complete run.job syntax documentation
- Include examples of the full run job structure
- Document the relationship between run.xs and function/*.xs files

---

## 2026-02-14 04:20 PST - Inconsistent Validation Errors on Valid Syntax

**What I was trying to do:**
Validate function files with syntax matching existing implementations.

**What the issue was:**
Even simple test functions like `function "test" { stack {} }` returned validation errors about unexpected characters. This suggests the validator may have issues with:
- How mcporter is passing parameters to the MCP
- Character encoding or escaping
- The JSON-RPC parameter serialization

**Why it was an issue:**
The validation tool is unreliable through the mcporter interface, making it unusable for CI/CD or pre-commit hooks.

**Potential solution (if known):**
- Add a standalone validation CLI to the @xano/developer-mcp package
- Fix the mcporter parameter passing for multi-line strings
- Provide a local validation endpoint that accepts files directly

---

## General Notes

The XanoScript language itself is well-documented and the examples in the repository are helpful. The main friction points are:

1. **Tool Integration**: The MCP validation tool is hard to use via mcporter
2. **Run Job Documentation**: Specific run.job syntax could be better documented
3. **No Local CLI**: Having a local `xano` CLI for validation (similar to `stripe` or `vercel` CLIs) would be extremely helpful

The syntax patterns I was able to infer from existing code:
- `function "name" { input {} stack {} response = {} }` structure
- `run.job "Name" { main = { name: "func", input: {} } env = [] }` structure  
- Using `?=` for default values in input parameters
- Using `filters=trim` for input sanitization
- Using `|get:"key"` and `|set:"key":value` for object manipulation

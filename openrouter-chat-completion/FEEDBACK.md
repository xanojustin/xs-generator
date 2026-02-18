# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-17 22:18 PST] - Job Name Parsing Issue with Spaces

**What I was trying to do:**
Create a run.job with a descriptive name "OpenRouter Chat Completion"

**What the issue was:**
The XanoScript validator rejected the job name because it contained spaces. The error message was cryptic:
```
Expecting: one of these possible Token sequences...
but found: 'Chat'
```

**Why it was an issue:**
The error didn't clearly indicate that spaces in job names are not allowed. I had to guess that the issue was the space in the name and switch to snake_case.

**Potential solution (if known):**
- Improve error messages to explicitly state "Job names must be in snake_case and cannot contain spaces"
- Or allow quoted strings with spaces (though snake_case seems to be the convention)

---

## [2025-02-17 22:20 PST] - MCP Tool Naming Convention Unclear

**What I was trying to do:**
Call the Xano MCP validate_xanoscript tool

**What the issue was:**
Initially, I wasn't sure how to access the MCP tools. The `xanoscript_docs` topic mentioned `validate_xanoscript` but I wasn't sure if it was a tool or a function. I had to look at `mcporter list` output to discover the actual tool name.

**Why it was an issue:**
The documentation says "Use `xanoscript_docs({ topic: "..." })`" which looks like a function call syntax, but the actual MCP tool is named `xano.validate_xanoscript`.

**Potential solution (if known):**
- Clarify in docs that MCP tools are accessed via `xano.tool_name` format
- Provide clear examples of mcporter command usage alongside the docs

---

## [2025-02-17 22:22 PST] - String Escaping When Validating via CLI

**What I was trying to do:**
Pass multi-line XanoScript code to the validate_xanoscript tool via mcporter

**What the issue was:**
When passing code with quotes through bash command substitution, the quotes needed to be escaped. This was tricky to get right and caused initial validation attempts to fail due to malformed JSON rather than actual XanoScript errors.

**Why it was an issue:**
Passing multi-line code with special characters through shell commands is error-prone.

**Potential solution (if known):**
- Add a `validate_file` tool that accepts a file path instead of raw code
- Or provide guidance in docs on how to properly escape code for CLI validation

---

## [2025-02-17 22:25 PST] - Documentation on Naming Conventions Could Be Prominent

**What I was trying to do:**
Follow best practices for naming files and identifiers

**What the issue was:**
While the docs mention "All folder and file names use `snake_case`", this information is somewhat buried in the workspace structure section. It's easy to miss when you're focused on writing code.

**Why it was an issue:**
I initially created a job with spaces in the name because that seemed natural/readable, only to have it fail validation.

**Potential solution (if known):**
- Add a "Common Pitfalls" or "Naming Rules" section at the top of the quickstart
- Include a prominent warning box about snake_case requirement
- Consider adding linting warnings in the validator about non-snake_case names

---

## [2025-02-17 22:28 PST] - env Array Syntax in run.job

**What I was trying to do:**
Specify required environment variables in the run.job

**What the issue was:**
The syntax for the `env` array wasn't immediately clear. I wasn't sure if it should be:
- `env = ["VAR1", "VAR2"]` (correct)
- `env = [VAR1, VAR2]`
- `env = "VAR1,VAR2"`

**Why it was an issue:**
While the example in docs shows the correct format, a more explicit description of the array syntax would help.

**Potential solution (if known):**
- Add a type annotation in the docs: `env: String[]`
- Show an example with single and multiple env vars more prominently

---

## General Observations

### What Worked Well:

1. **xanoscript_docs tool is comprehensive** - Once I found it, the documentation was very helpful and well-organized
2. **Error messages include line/column info** - This made debugging much easier
3. **Quickstart guide is practical** - The common patterns section saved me time
4. **Validation tool is fast** - Got immediate feedback on syntax errors

### Suggestions for Improvement:

1. **Add a "Getting Started with MCP" guide** that explains:
   - How to list available tools
   - How to call tools via mcporter
   - Common workflows (docs → write → validate → commit)

2. **Create a CLI validation helper** that wraps the MCP call with proper escaping, like:
   ```bash
   xano-validate ./my-file.xs
   ```

3. **Consider a linter tool** that warns about:
   - Non-snake_case names
   - Missing required fields
   - Common anti-patterns

4. **Document the relationship between MCP tools and XanoScript constructs** more explicitly

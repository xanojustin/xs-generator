# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 05:17 PST] - MCP Parameter Parsing Issues

**What I was trying to do:**
Validate XanoScript files using the MCP's validate_xanoscript tool.

**What the issue was:**
The JSON parameter format for mcporter calls was unclear. Initially tried:
```bash
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
```
This returned: "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required"

**Why it was an issue:**
The error persisted even when passing valid JSON. After checking the examples in `mcporter list xano`, I realized the correct format uses `key=value` syntax:
```bash
mcporter call xano validate_xanoscript directory=/Users/justinalbrecht/xs/messagebird-send-sms
```

**Potential solution (if known):**
- Add clearer documentation in the tool description showing both JSON and key=value formats
- Include examples of both parameter passing styles
- Consider supporting both formats in the MCP for flexibility

---

## [2026-02-18 05:18 PST] - xanoscript_docs Returns Generic Content

**What I was trying to do:**
Get topic-specific XanoScript documentation for tasks, run jobs, and external APIs.

**What the issue was:**
Calling `xanoscript_docs` with different topics (`tasks`, `run`, `integrations/external-apis`) all returned the same generic documentation content about workspace structure and general syntax, not the specific topics requested.

**Why it was an issue:**
I needed specific guidance on:
- How to structure run jobs
- Task/cron job syntax details
- External API integration patterns

Instead, I had to infer from the generic docs and by reading existing implementations in the ~/xs/ folder.

**Potential solution (if known):**
- Ensure the MCP returns topic-specific content when a topic is specified
- If content isn't available for a sub-topic, return a clear message rather than generic content
- Consider including more examples in the main docs for run jobs specifically

---

## [2026-02-18 05:20 PST] - Run Job vs Task Naming Confusion

**What I was trying to do:**
Understand the difference between `task` (scheduled jobs) and `run` (run jobs).

**What the issue was:**
The documentation mentions both `task` (in `task/{name}.xs`) and `run/` folder for job configurations, but the relationship between them isn't clear. The existing implementations in ~/xs/ use `run.xs` as the entry point, not `run.job` as a file extension.

**Why it was an issue:**
Initially I thought the file should be named `run.job.xs` based on the construct name, but existing implementations use just `run.xs`.

**Potential solution (if known):**
- Clarify in docs that `run.xs` is the standard filename for run job configurations
- Explain the difference between scheduled tasks (task/*.xs) and run jobs (run.xs)
- Add a quick reference specifically for run job structure

---

## [2026-02-18 05:21 PST] - No API Integration Best Practices

**What I was trying to do:**
Follow best practices for external API integration in XanoScript.

**What the issue was:**
The documentation shows basic `api.request` usage but lacks guidance on:
- Header formatting (array of strings vs object)
- Form-encoded vs JSON payload handling
- Timeout defaults and recommendations
- Error handling patterns specific to APIs

**Why it was an issue:**
Had to infer the correct syntax by looking at existing implementations like stripe-create-charge. For example, MessageBird uses JSON payloads, while Stripe uses form-encoded - knowing when to use each wasn't clear from docs.

**Potential solution (if known):**
- Add a dedicated section on external API patterns
- Show examples for both JSON and form-encoded requests
- Document common header patterns
- Include timeout recommendations (30s seems standard)

---

## [2026-02-18 05:22 PST] - Success - Files Validated

**What worked well:**
Once I used the correct mcporter syntax (`key=value`), the validation worked perfectly:
```bash
mcporter call xano validate_xanoscript directory=/Users/justinalbrecht/xs/messagebird-send-sms
# Validated 2 file(s): 2 valid, 0 invalid
```

The error messages from validation are clear and helpful when there are issues.

---

## Summary

The MCP validation tool works well once you know the correct syntax. The main areas for improvement are:
1. Parameter format documentation
2. Topic-specific documentation content
3. Run job vs task clarification
4. More API integration examples

The existing implementations in ~/xs/ were extremely helpful as reference material.

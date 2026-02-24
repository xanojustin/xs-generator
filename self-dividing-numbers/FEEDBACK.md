# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-24 14:00 PST] - Documentation Topic Specificity

**What I was trying to do:** Get detailed documentation on run jobs and functions topics

**What the issue was:** The `xanoscript_docs` MCP tool returns the same general documentation regardless of the topic parameter. I called it with topics "quickstart", "functions", and "run" but received identical high-level documentation each time.

**Why it was an issue:** I needed specific syntax details for run jobs (the `run.job` construct) and function calls. Without detailed documentation, I had to rely on reading existing example files to understand the correct syntax patterns.

**Potential solution:** The MCP should return topic-specific documentation sections as indicated in the documentation index table (e.g., the "Run job and service configurations for the Xano Job Runner" section for the "run" topic).


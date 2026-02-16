# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 07:45 PST] - xanoscript_docs Topic Parameter Not Working

**What I was trying to do:**
Get specific documentation about the "run" topic for creating run jobs by calling `xanoscript_docs({ topic: "run" })`.

**What the issue was:**
The xanoscript_docs function returned the same general documentation regardless of which topic I requested. I tried multiple topics:
- `xanoscript_docs({ topic: "run" })`
- `xanoscript_docs({ topic: "tasks" })`
- `xanoscript_docs({ topic: "quickstart" })`
- `xanoscript_docs({ topic: "integrations" })`

All returned identical content - the general XanoScript overview with the quick reference table.

**Why it was an issue:**
Without topic-specific documentation, I couldn't find the correct syntax for:
- run.job constructs (I tried `run.job`, `job` - neither worked)
- How to call functions from within tasks
- The proper structure for job runner configurations

I had to guess and iterate through validation errors, which was time-consuming.

**Potential solution (if known):**
Ensure the topic parameter is properly parsed and returns the specific documentation for that topic. The documentation index lists many topics (run, tasks, quickstart, etc.) but they all return the same general README content.

---

## [2026-02-16 07:50 PST] - run_api_docs and cli_docs Parameter Passing Issues

**What I was trying to do:**
Get documentation about the Run API and CLI using `run_api_docs` and `cli_docs` functions.

**What the issue was:**
Both functions returned errors saying required parameters were missing even when I provided them:

```
run_api_docs({ topic: "start" })  // Error: 'topic' parameter is required
cli_docs({ topic: "run" })        // Error: 'topic' parameter is required
```

I tried multiple JSON formats and the key=value format but couldn't get the parameters to pass correctly.

**Why it was an issue:**
Couldn't access the Run API documentation which would have helped me understand the proper run job structure.

**Potential solution (if known):**
The mcporter CLI might need clearer documentation on parameter passing format, or the MCP server might not be parsing JSON parameters correctly.

---

## [2026-02-16 07:55 PST] - Confusion About run.job vs task vs job Constructs

**What I was trying to do:**
Create a "run job" as specified in the requirements, in a `run/` folder with proper run job configuration.

**What the issue was:**
The documentation mentions a `run/` folder for "Job and service configurations for the Xano Job Runner" but doesn't specify what construct to use inside those files. I tried:
- `run.job "name" { ... }` - Invalid construct
- `job "name" { ... }` - Invalid construct
- `task "name" { ... }` - Valid, but in `task/` folder, not `run/`

**Why it was an issue:**
It was unclear how to properly structure a run job for the Xano Job Runner. The documentation mentions the run folder but doesn't provide the construct syntax for files within it.

**Potential solution (if known):**
Add specific documentation about:
1. What construct to use for run jobs (is it `function`, `task`, or something else?)
2. The difference between `task/` and `run/` folders
3. Example run.job files with proper syntax

---

## [2026-02-16 08:00 PST] - Task Cannot Call Functions Directly

**What I was trying to do:**
Call the `fetch_weather` function from within the `weather_check` task.

**What the issue was:**
Multiple syntax attempts failed validation:

```xs
// Attempt 1: Direct call with braces
fetch_weather {
  city = "San Francisco"
  units = "imperial"
} as $result
// Error: Expecting '}' but found 'fetch_weather'

// Attempt 2: Assignment syntax
$weather_result = fetch_weather(city: "San Francisco", units: "imperial")
// Error: Expecting '}' but found '$weather_result'
```

**Why it was an issue:**
I couldn't find the correct syntax for calling a function from within a task. The documentation shows function definitions but not how to call them from other constructs.

**Workaround:**
I ended up duplicating the API call logic directly in the task file instead of calling the reusable function.

**Potential solution (if known):**
Document the proper syntax for calling functions from tasks, queries, and other constructs. If functions can only be called from specific contexts, clarify those restrictions.

---

## [2026-02-16 08:05 PST] - validate_xanoscript JSON Parameter Parsing

**What I was trying to do:**
Call `validate_xanoscript` with the `file_path` parameter using JSON format.

**What the issue was:**
The JSON parameter format didn't work as expected:

```bash
mcporter call xano validate_xanoscript '{"file_path": "/path/to/file.xs"}'
// Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

The parameter was being passed but not recognized.

**Workaround:**
Using the `key:value` format worked:
```bash
mcporter call xano validate_xanoscript file_path:/path/to/file.xs
```

**Why it was an issue:**
Inconsistent parameter passing formats between different MCP tools is confusing. Some expect JSON, others expect key:value format.

**Potential solution (if known):**
Standardize parameter passing or document the expected format clearly for each tool.

---

## Summary

The main blockers were:
1. **Documentation**: Topic-specific documentation wasn't returned, making it hard to learn the correct syntax
2. **Construct confusion**: Unclear what construct to use for run jobs (`run.job`, `job`, `task`, or `function`)
3. **Function calling**: Couldn't find syntax to call functions from tasks
4. **Parameter passing**: JSON parameters didn't work for some tools

The validation tool was extremely helpful once I figured out the correct format - it provided clear error messages that helped me fix syntax issues.

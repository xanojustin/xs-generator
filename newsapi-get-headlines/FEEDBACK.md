# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 08:47 PST] - validate_xanoscript parameter confusion

**What I was trying to do:**
Validate the XanoScript files I created using the MCP validate_xanoscript tool.

**What the issue was:**
I initially tried to call the validator with `--file` flag like:
```
mcporter call xano validate_xanoscript --file ~/xs/newsapi-get-headlines/run.xs
```

This resulted in an error: "Too many positional arguments (2) supplied; only 1 parameter remain on validate_xanoscript."

**Why it was an issue:**
The error message wasn't clear about the correct parameter format. I had to use `mcporter describe` to find out the tool expects a `code` parameter (the actual code content as a string), not a file path.

**Potential solution:**
1. The tool could support a `file_path` parameter as an alternative to `code` for easier CLI usage
2. Better error messaging that suggests the correct format
3. Documentation showing how to validate files (e.g., `CODE=$(cat file.xs) && mcporter call xano validate_xanoscript "code=$CODE"`)

---

## [2026-02-15 08:48 PST] - Missing filter documentation led to validation error

**What I was trying to do:**
Convert the page_size input from text to integer using a filter.

**What the issue was:**
I used `$input.page_size|to_integer` which failed validation with "Unknown filter function 'to_integer'".

**Why it was an issue:**
I didn't have the correct filter name. The documentation index mentioned `to_text` for type conversion, so I assumed `to_integer` or `to_int` would exist. I had to call `xanoscript_docs({ topic: "syntax", mode: "quick_reference" })` to find the correct filter is `to_int`.

**Potential solution:**
1. Include a comprehensive list of all available filters in the main documentation
2. Better error messages that suggest similar/alternative filters (e.g., "Unknown filter 'to_integer'. Did you mean 'to_int'?")
3. A dedicated "filters" topic in xanoscript_docs that lists all available filters with examples

---

## [2026-02-15 08:49 PST] - xanoscript_docs returns same content for all topics

**What I was trying to do:**
Get specific documentation for the "run" topic to understand run job structure better.

**What the issue was:**
Calling `mcporter call xano xanoscript_docs '{"topic": "run"}'` returned the same general documentation as calling without any topic parameter. I tried multiple topics (run, quickstart, syntax, functions) and they all returned the same content.

**Why it was an issue:**
I couldn't access specific topic documentation that might have had more detailed information about run jobs, functions, or syntax specifics.

**Potential solution:**
1. Fix the topic filtering in the MCP so specific topics return relevant content
2. If the topics are working but returning the same content intentionally, clarify this in the documentation
3. Provide a way to see what content is actually available for each topic

---

## [2026-02-15 08:50 PST] - No example of run.job construct in docs

**What I was trying to do:**
Understand the proper structure and syntax for the `run.job` construct.

**What the issue was:**
The documentation mentions run jobs in the file structure section (`run/`), but there's no example of what a `run.job` block actually looks like in XanoScript. I had to look at existing implementations in the ~/xs folder to understand the syntax.

**Why it was an issue:**
As someone who doesn't know XanoScript syntax (per the instructions), I needed to see an example of how to define a run.job with its `main`, `input`, and `env` properties.

**Potential solution:**
Add a "Run Jobs" section to the documentation with examples like:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: {
      param1: "value1"
      param2: "value2"
    }
  }
  env = ["ENV_VAR_1", "ENV_VAR_2"]
}
```

---

## [2026-02-15 08:51 PST] - xanoscript_docs content repetition is inefficient

**What I was trying to do:**
Gather comprehensive documentation by calling multiple topics.

**What the issue was:**
Each call to xanoscript_docs returns a large document (~300 lines) that includes the same introductory content (file structure, quick reference, etc.) regardless of the topic requested. This is inefficient for context window usage.

**Why it was an issue:**
I was trying to be thorough by reading multiple topics, but each one included the same boilerplate, wasting tokens.

**Potential solution:**
1. When a specific topic is requested, only return the content for that topic
2. Have a dedicated "index" or "overview" topic that returns the full structure
3. The quick_reference mode helps, but it could be even more targeted

---

## [2026-02-15 08:52 PST] - SUCCESS - Validation worked well once understood

**What I was trying to do:**
Validate the corrected XanoScript files.

**What worked well:**
Once I understood to pass the code content as a string parameter, the validation worked great:
- Clear error messages with line/column numbers
- Specific error descriptions ("Unknown filter function 'to_integer'")
- Fast response time

**Why this is good:**
The validation is precise and helpful for fixing syntax errors quickly.

**Suggestion:**
The validation experience is good - just needs better documentation on how to use it.

---

## Summary

The Xano MCP is functional and the validation tool is helpful, but:
1. Documentation discoverability could be improved
2. Topic-specific content isn't working as expected
3. Error messages for MCP tool usage (not XanoScript validation) could be more helpful
4. Run job examples should be explicitly documented

Overall, I was able to complete the task successfully by combining the general documentation with examples from existing implementations in the ~/xs folder.

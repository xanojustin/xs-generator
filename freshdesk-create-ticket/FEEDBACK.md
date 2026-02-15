# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 12:47 PST] - MCP Tool Parameter Passing Difficulty

**What I was trying to do:**
Validate XanoScript code using the `validate_xanoscript` MCP tool.

**What the issue was:**
Passing multi-line XanoScript code to the MCP tool was extremely difficult. The `mcporter call` command expects arguments as JSON, but properly escaping multi-line code strings for shell command line usage is error-prone.

Attempted approaches:
1. Direct string interpolation - failed due to quote escaping issues
2. `xargs -0` approach - failed with parameter errors  
3. `sed` escaping - collapsed newlines, causing parse errors
4. JSON file with `@-` redirect - mcporter doesn't support `@` syntax
5. Finally worked: piping to `jq -Rs` to create JSON, saving to temp file, then using `$(cat file)`

**Why it was an issue:**
This significantly slowed down the validation workflow. Each attempt required multiple tries and the error messages weren't helpful for diagnosing the parameter passing issue.

**Potential solution:**
1. Allow the `validate_xanoscript` tool to accept a `file_path` parameter as an alternative to `code`
2. Support reading from stdin (e.g., `cat file.xs | mcporter call xano.validate_xanoscript`)
3. Add a `--file` flag to the mcporter call command for file-based input

---

## [2026-02-15 12:48 PST] - Documentation Scattered Across Multiple Topics

**What I was trying to do:**
Understand the complete structure of a run job and how to make external API calls.

**What the issue was:**
The documentation for run jobs was split across multiple topics (`run`, `functions`, `apis`, `integrations`, `quickstart`, `syntax`) and I had to call `xanoscript_docs` multiple times with different topics to piece together the complete picture.

Specifically:
- `run` topic covered the run.job structure
- `functions` covered function definitions
- `integrations` covered `api.request` syntax
- `quickstart` covered basic syntax patterns
- `syntax` covered operators and filters

**Why it was an issue:**
It was hard to know which topics I needed to consult. I had to make educated guesses about which topic would contain the information I needed.

**Potential solution:**
1. Add a "complete example" or "tutorial" topic that shows a full, working example end-to-end
2. Include cross-references in each topic ("For API calls, see integrations topic")
3. Add a topic index/search capability to the docs tool

---

## [2026-02-15 12:50 PST] - Unclear Filter/Function Availability

**What I was trying to do:**
Find a `base64_encode` filter/function to encode the Freshdesk API credentials.

**What the issue was:**
The documentation didn't list all available filters/functions. I assumed `base64_encode` might exist based on common patterns, but I had no way to verify without trying it and running validation.

**Why it was an issue:**
Trial-and-error is inefficient. I ended up checking existing examples in the ~/xs folder to see how other implementations handled authentication encoding.

**Potential solution:**
1. Add a comprehensive filter/function reference topic
2. Document string encoding/decoding utilities
3. Include common auth patterns (Basic Auth, Bearer tokens, etc.) in examples

---

## [2026-02-15 12:52 PST] - String Concatenation Syntax Confusion

**What I was trying to do:**
Concatenate strings with filters in the expression for Basic Auth encoding.

**What the issue was:**
Initially wrote:
```xs
value = "Basic " ~ $api_key ~ ":X"|base64_encode
```

But the syntax docs mention that filters need parentheses when used with concatenation. However, I wasn't sure if the entire concatenation should be wrapped or just the filtered part.

**Why it was an issue:**
The documentation example showed:
```xs
value = ($status|to_text) ~ ": " ~ ($data|json_encode)
```

But it wasn't clear if filters apply to the immediate variable or the whole expression. I had to experiment to get it right.

**Potential solution:**
1. Add more examples of complex concatenation patterns
2. Document operator precedence with filters
3. Show before/after examples of common mistakes

---

## Overall Summary

The Xano MCP and XanoScript language work well once you understand them, but getting started has friction:

1. **Tool usability**: The validate tool needs file path support
2. **Documentation discoverability**: Hard to find complete information across topics
3. **Reference completeness**: Missing comprehensive filter/function list
4. **Auth patterns**: Common patterns like Basic Auth aren't documented with examples

The validation feedback was good once I got the code to the tool - clear error messages with line/column positions. The run job structure is clean and intuitive.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-15 00:18 PST] - Shell Escaping Issues with validate_xanoscript

**What I was trying to do:**
Validate XanoScript code using the `validate_xanoscript` MCP tool via the `mcporter` CLI.

**What the issue was:**
When passing XanoScript code directly to `mcporter call xano.validate_xanoscript`, shell escaping of special characters (quotes, newlines, backticks, etc.) made it nearly impossible to pass multi-line code blocks through the command line. The `code=-` stdin option didn't work either.

**Why it was an issue:**
The command:
```bash
mcporter call xano.validate_xanoscript code='...complex xanoscript...'
```
would fail due to shell interpretation of quotes, `$` variables, backticks for expressions, and newlines.

**Potential solution:**
1. Support a `--file` option to read code directly from a file path
2. Make the `code=-` stdin reading work properly
3. Provide a CLI wrapper like `xano validate <file.xs>` that handles this internally

**Workaround used:**
Had to use Python subprocess to properly escape JSON and call mcporter with the `--config` flag pointing to the config file.

---

## [2025-02-15 00:20 PST] - Missing `uri_encode` filter in documentation

**What I was trying to do:**
URL-encode query parameters for the Algolia API request.

**What the issue was:**
I initially used `uri_encode` filter (common naming in other languages) but the correct filter is `url_encode`. The documentation lists `url_encode` clearly, but my first instinct was the wrong name.

**Why it was an issue:**
Would have caused a validation error if not caught. Minor issue but good to know common filter naming conventions.

**Potential solution:**
Add `uri_encode` as an alias for `url_encode` since both terms are commonly used interchangeably.

---

## [2025-02-15 00:22 PST] - Config file path not automatically discovered

**What I was trying to do:**
Run `mcporter call xano.validate_xanoscript` from a different working directory.

**What the issue was:**
When running from outside the workspace directory, mcporter couldn't find the Xano MCP server because it looks for `config/mcporter.json` relative to the current directory.

**Why it was an issue:**
Had to explicitly pass `--config /Users/justinalbrecht/.openclaw/workspace/config/mcporter.json` for the command to work.

**Potential solution:**
1. Support a `MCPorter_CONFIG` environment variable
2. Look for config in parent directories recursively
3. Store config in a global location like `~/.config/mcporter/config.json`

---

## [2025-02-15 00:25 PST] - Integer default values in input syntax

**What I was trying to do:**
Define optional integer inputs with default values like `int hits_per_page?=10`.

**What the issue was:**
Was unsure whether integer defaults should be quoted as strings (`"10"`) or left as bare numbers (`10`). The documentation shows `text role?="user"` with quotes for strings, but doesn't explicitly show integer examples.

**Why it was an issue:**
Uncertainty about whether `int hits_per_page?=10` or `int hits_per_page?="10"` is correct. Tried the bare number version and it validated successfully.

**Potential solution:**
Add explicit examples in the types documentation showing:
- `int count?=0` for integer defaults
- `bool active?=true` for boolean defaults
- `decimal price?=0.00` for decimal defaults

---

## General Observations

### What Worked Well
1. The `xanoscript_docs` tool with `file_path` parameter provided context-aware documentation
2. Validation errors include line/column numbers which is very helpful
3. The quick reference mode is concise and useful

### Suggestions for Improvement
1. **CLI ergonomics**: A simpler `xano validate <file.xs>` command would be more user-friendly than the full mcporter syntax
2. **Batch validation**: Support validating multiple files at once
3. **VS Code extension**: Direct IDE integration with real-time validation
4. **Filter discovery**: A way to list all available filters by category

### Documentation Gaps
1. More real-world examples of API integrations (like the ones being built in this repo)
2. Common patterns for external API error handling
3. Best practices for environment variable management in run jobs

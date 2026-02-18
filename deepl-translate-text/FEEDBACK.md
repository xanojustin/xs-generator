# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 14:22 PST] - MCP Server Discovery Issue

**What I was trying to do:** Call the Xano MCP `validate_xanoscript` tool using `mcporter call xano.validate_xanoscript`

**What the issue was:** mcporter returned "Unknown MCP server 'xano'" even though `mcporter list` showed xano as available.

**Why it was an issue:** I couldn't validate my code and was blocked from proceeding.

**Potential solution:** The xano MCP is configured as a stdio-based server (command: npx @xano/developer-mcp), not a URL-based one. I had to use the `--stdio` flag:
```bash
mcporter call --stdio "npx @xano/developer-mcp" validate_xanoscript directory="."
```

The mcporter CLI could potentially auto-detect stdio vs http servers and handle this transparently, or at least provide a better error message suggesting the `--stdio` flag.

---

## [2026-02-18 14:25 PST] - run.job Input Optional Syntax Confusion

**What I was trying to do:** Define an optional input parameter in the run.job's input block using `source_lang?: "EN"` syntax.

**What the issue was:** The validator rejected this with "Expecting ':' but found '?'" error.

**Why it was an issue:** The documentation shows that in function input blocks, you can use `text field?` for optional inputs. I assumed the same syntax would work in run.job input blocks. It doesn't.

**Potential solution:** The documentation could clarify that run.job input blocks only accept concrete values (no optional syntax with `?`). The run.job input is essentially a JSON-like object literal, not an input schema definition like in functions.

---

## [2026-02-18 14:26 PST] - Index Direction Syntax Unclear

**What I was trying to do:** Create a btree index with descending sort order using `direction: "desc"`.

**What the issue was:** The validator reported "The key 'direction' is not valid in this context" and "Expected value of `direction` to be `null'`".

**Why it was an issue:** Many SQL databases and ORMs support index direction specification. I assumed XanoScript would too. The error message about `null` was particularly confusing.

**Potential solution:** The table/index documentation could explicitly state which properties are valid in index definitions. If direction isn't supported, that should be documented. If the error message is accurate and direction should be null, the documentation should explain why this property exists.

---

## [2026-02-18 14:15 PST] - No xanoscript_docs MCP Tool Output

**What I was trying to do:** Get XanoScript documentation via the MCP before writing code.

**What the issue was:** The `xanoscript_docs` tool is available but I didn't initially call it because I wasn't sure of the exact syntax.

**Why it was an issue:** The task instructions explicitly stated I MUST call `xanoscript_docs` before writing ANY code. I should have called it first thing.

**Potential solution:** Not really an MCP issue - more of a user error. But clearer documentation about the workflow (docs → write → validate) would help.

---

## [2026-02-18 14:20 PST] - String Concatenation Syntax Anxiety

**What I was trying to do:** Build headers and URLs with string concatenation using the `~` operator.

**What the issue was:** I wasn't 100% confident about the syntax for complex concatenations with filters.

**Why it was an issue:** The documentation clearly states you need parentheses around filtered expressions when concatenating, but I kept second-guessing myself.

**Example that worked:**
```xs
"Authorization: DeepL-Auth-Key " ~ $env.DEEPL_API_KEY
```

**Potential solution:** More examples of string concatenation patterns in the cheatsheet would help. Specifically showing the difference between simple concatenation and concatenation with filters.

---

## Summary

The MCP validation tool worked well once I figured out the stdio invocation. The validation errors were clear and pointed to exact line numbers. The main friction points were:

1. MCP stdio vs HTTP server invocation not being obvious
2. Different syntax rules between run.job inputs vs function inputs
3. Index definition properties not being well documented

Overall the experience was positive - the validation caught my errors before they would have caused runtime issues.

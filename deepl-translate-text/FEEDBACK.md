# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-13 21:17 PST] - Initial Setup Confusion

**What I was trying to do:**
Understand how to call the Xano MCP tools through mcporter.

**What the issue was:**
Initially unclear on whether I should use `mcporter call xano.xanoscript_docs` or some other syntax. The skill docs for mcporter mention `mcporter call <server.tool>` but it took a moment to realize the server name was "xano".

**Why it was an issue:**
Minor friction getting started - wasn't immediately obvious that the MCP server was already configured and named "xano".

**Potential solution (if known):**
Perhaps include a quick reference in the task description or docs showing the exact mcporter command pattern: `mcporter call xano.<tool_name>`.

---

## [2026-02-13 21:18 PST] - Understanding File Path Requirements

**What I was trying to do:**
Call xanoscript_docs with a file_path parameter to get context-aware docs for the run job I was creating.

**What the issue was:**
The docs mention using `file_path` for context-aware docs, but I wasn't sure if I should pass the path before or after creating the file. The schema shows `file_path` as optional, but doesn't clearly explain when to use it vs when to use `topic`.

**Why it was an issue:**
Took an extra moment to decide to just use `topic=run` instead of trying to use `file_path` for a file that didn't exist yet.

**Potential solution (if known):**
Add guidance in the docs: "Use `topic` when learning general patterns, use `file_path` when you need syntax validation for an existing file."

---

## [2026-02-13 21:20 PST] - Syntax Validation Success

**What I was trying to do:**
Validate the XanoScript files I created.

**What went well:**
The validation tool worked perfectly! Both files passed on the first try with clear "XanoScript is valid" messages.

**Why this matters:**
The validation provides immediate feedback and builds confidence that the code is correct before committing.

---

## [2026-02-13 21:21 PST] - Function Call Pattern Clarity

**What I was trying to do:**
Understand the exact syntax for conditional blocks and error handling.

**What the issue was:**
The quickstart docs show `elseif` (one word) but I initially thought it might be `else if` (two words) based on other languages. The docs do show this as a "common mistake" which helped, but it's easy to miss.

**Why it was an issue:**
Common language patterns from JavaScript/TypeScript don't apply - need to be vigilant about XanoScript-specific syntax.

**Potential solution (if known):**
The docs already call this out as a common mistake - perhaps make it more prominent with a warning emoji or highlight box.

---

## [2026-02-13 21:22 PST] - String Concatenation with Filters

**What I was trying to do:**
Concatenate strings that include filtered values (like `$input.target_lang|to_upper`).

**What the issue was:**
Had to remember to wrap filtered expressions in parentheses: `($input.target_lang|to_upper)` instead of `$input.target_lang|to_upper`.

**Why it was an issue:**
This is called out in the docs as a common mistake, and I did catch myself almost making it. The syntax is logical once understood but differs from typical template languages.

**Potential solution (if known):**
The docs cover this well - the quick_reference explicitly shows the parentheses requirement. Just need to remember to check it.

---

## [2026-02-13 21:23 PST] - API Request Body Parameter Naming

**What I was trying to do:**
Send a POST request with a JSON body to the DeepL API.

**What the issue was:**
The docs explicitly warn against using `body` instead of `params` for `api.request`. This is counter-intuitive since most developers expect to use `body` for POST request payloads.

**Why it was an issue:**
Mental model mismatch - in most HTTP libraries, `params` is for query parameters and `body` is for request body. XanoScript uses `params` for both.

**Potential solution (if known):**
The docs already document this clearly in the "Common Mistakes" section. Perhaps also add a note in the `api.request` documentation itself explaining this design decision.

---

## [2026-02-13 21:24 PST] - Optional Parameter Handling

**What I was trying to do:**
Make the `source_lang` parameter optional and only add it to the payload if provided.

**What went well:**
The pattern for optional fields was well-documented in the quickstart. Using `conditional` with `if` blocks worked perfectly:

```xs
conditional {
  if ($input.source_lang != null && $input.source_lang != "") {
    var.update $payload {
      value = $payload|set:"source_lang":($input.source_lang|to_upper)
    }
  }
}
```

**Why this matters:**
Clear patterns for optional fields make the code more robust and self-documenting.

---

## [2026-02-13 21:25 PST] - Environment Variable Access

**What I was trying to do:**
Access environment variables in the function to get the DeepL API key.

**What went well:**
The `$env.variable_name` syntax was straightforward and clearly documented. The separation of `env` declaration in run.job (which variables are required) from actual access in the function ($env.var_name) is clean.

---

## Summary

Overall, the Xano MCP worked well for this task. The main friction points were:

1. **Initial discovery** - Understanding the mcporter call pattern
2. **Syntax differences** - Remembering XanoScript-specific patterns (elseif vs else if, parentheses for filters)
3. **API naming conventions** - `params` instead of `body` for POST payloads

The documentation was comprehensive and the validation tool provided quick feedback. The "Common Mistakes" section in the quickstart was particularly helpful.
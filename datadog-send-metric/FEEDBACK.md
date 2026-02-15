# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-14 18:17 PST] - Issue Title: Conditional block as expression not supported

**What I was trying to do:**
Set a variable with a default value that could be overridden by an environment variable. I wanted to use a conditional expression inline to check if the env var exists and use it, otherwise use a default.

**What the issue was:**
I tried to use a `conditional` block inside a `var` value assignment:
```xs
var $site {
  value = conditional {
    if ($env.datadog_site != null && $env.datadog_site != "") { $env.datadog_site }
    else { "datadoghq.com" }
  }
}
```

The validator gave this error:
```
[Line 15, Column 15] Expecting: Expected an expression but found: 'conditional'
```

**Why it was an issue:**
The documentation shows that conditional blocks can be used as expressions (under "Conditional as Expression" section), but this appears to not work inside a `var` value assignment. I had to restructure my code to use a standalone conditional block with `var.update` instead.

**Potential solution (if known):**
Either the documentation should clarify where conditional expressions are/aren't allowed, or the parser should support conditional blocks as expressions in var value assignments. Alternatively, a ternary operator or nullish coalescing with default value support would be cleaner:
```xs
var $site { value = $env.datadog_site ?? "datadoghq.com" }
```

---

## [2025-02-14 18:20 PST] - Issue Title: Reserved variable names not documented

**What I was trying to do:**
Capture the result of an API request in a variable named `$response`.

**What the issue was:**
The validator gave this error:
```
[Line 55, Column 10] '$response' is a reserved variable name and cannot be used
```

I couldn't find a list of reserved variable names in the documentation I retrieved.

**Why it was an issue:**
`$response` is a natural name for API response data. Without knowing which names are reserved, developers have to guess and check through validation errors. I had to rename it to `$api_result`.

**Potential solution (if known):**
Add a section to the syntax documentation listing all reserved variable names (like `$response`, `$auth`, `$input`, `$env`, etc.) so developers know what to avoid.

---

## [2025-02-14 18:15 PST] - Issue Title: Documentation retrieval requires multiple calls

**What I was trying to do:**
Get comprehensive XanoScript documentation to write code correctly.

**What the issue was:**
I had to make multiple separate calls to `xanoscript_docs` with different topics (run, syntax, functions, apis, integrations, quickstart) to piece together the information needed. There's no single "complete" documentation option.

**Why it was an issue:**
Each call takes time (900ms+), and I had to make 5-6 separate calls to get all the context I needed. This slows down development.

**Potential solution (if known):**
Add a `topic=all` option that returns a consolidated quick reference, or allow multiple topics in one call: `topics=["run", "syntax", "functions"]`.

---

## [2025-02-14 18:18 PST] - Issue Title: Error messages could be more specific

**What I was trying to do:**
Debug the conditional block syntax error.

**What the issue was:**
The error message "Expected an expression but found: 'conditional'" was somewhat vague. It told me what was wrong but not why or what the alternatives are.

**Why it was an issue:**
As a developer new to XanoScript, I didn't know if I had a syntax error in the conditional or if conditionals simply aren't allowed in that context.

**Potential solution (if known):**
Error messages could include suggestions or links to relevant documentation, e.g., "Conditional blocks cannot be used in variable value assignments. Use a standalone conditional block with var.update instead."

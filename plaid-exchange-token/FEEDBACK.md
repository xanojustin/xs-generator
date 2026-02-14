# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-14 02:47 PST - Issue: Using conditional as expression causes parse error

**What I was trying to do:**
Use a conditional block inside a variable assignment to determine the Plaid API base URL based on the environment.

**What the issue was:**
The syntax `value = conditional { ... }` resulted in a parse error: "Expecting: Expected an expression but found: 'conditional'"

Code that failed:
```xs
var $base_url {
  value = conditional {
    if ($env.plaid_environment == "production") { "https://production.plaid.com" }
    elseif ($env.plaid_environment == "development") { "https://development.plaid.com" }
    else { "https://sandbox.plaid.com" }
  }
}
```

**Why it was an issue:**
The documentation shows conditional blocks can be used as expressions, but this didn't work in practice. I had to restructure the code to use `var.update` inside a standalone conditional block instead.

**Potential solution:**
Either fix the parser to accept conditional blocks as expressions, or update the documentation to clarify when conditional-as-expression is valid.

---

## 2026-02-14 02:52 PST - Issue: $response is a reserved variable name

**What I was trying to do:**
Create a variable named `$response` to hold the function result before returning it.

**What the issue was:**
Got validation error: "'$response' is a reserved variable name and should not be used as a variable."

**Why it was an issue:**
This isn't clearly documented in the main syntax reference. I discovered it through trial and error.

**Potential solution:**
Add a note to the syntax documentation listing reserved variable names like `$response`, `$input`, `$auth`, `$env`, etc.

---

## 2026-02-14 02:45 PST - Issue: JSON escaping challenges with mcporter CLI

**What I was trying to do:**
Validate XanoScript code using the mcporter CLI with the `--args` flag.

**What the issue was:**
Passing multi-line XanoScript code through the CLI as JSON required complex escaping. Newlines and special characters caused JSON parse errors.

Tried approaches:
- Direct string interpolation failed due to quote escaping
- Using `jq` with shell variables had scope issues
- JSON control characters in the code broke the parser

**Why it was an issue:**
Validating code became a multi-step debugging process instead of a simple command.

**Potential solution:**
- Add a `mcporter call xano.validate_xanoscript --file path/to/file.xs` option
- Or accept raw code from stdin: `cat file.xs | mcporter call xano.validate_xanoscript --stdin`

---

## 2026-02-14 02:55 PST - Issue: MCP daemon connection inconsistency

**What I was trying to do:**
Run validation commands from different working directories.

**What the issue was:**
Got "Unknown MCP server 'xano'" errors when running from /tmp even though `mcporter list` showed xano as available. Had to run from the workspace directory (/Users/justinalbrecht/.openclaw/workspace).

**Why it was an issue:**
The MCP server config is tied to a specific working directory, making it hard to validate files in other locations.

**Potential solution:**
Document that stdio-based MCP servers need to be run from their configured CWD, or make the daemon more location-agnostic.

---

## General Notes

- The documentation is generally good but could benefit from more "common mistakes" sections
- Having the quick reference mode (`mode=quick_reference`) was very helpful for context efficiency
- The validation tool works well once you can actually pass the code to it

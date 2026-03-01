# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-28 21:20 PST] - MCP validate_xanoscript SUCCESS

**What I was trying to do:** Validate XanoScript files using the Xano MCP server.

**What the solution was:** The correct syntax for mcporter is using `--args` with a JSON payload:
```bash
mcporter call xano validate_xanoscript --args '{"directory": "/path/to/dir"}'
```

Or for specific files:
```bash
mcporter call xano validate_xanoscript --args '{"file_paths": ["/path/to/file1.xs", "/path/to/file2.xs"]}'
```

**Result:** Both files passed validation immediately:
```
Validated 2 file(s): 2 valid, 0 invalid

✅ Valid files:
  /Users/justinalbrecht/xs/kth-missing-positive-number/function/kth_missing_positive_number.xs
  /Users/justinalbrecht/xs/kth-missing-positive-number/run.xs
```

---

## [2026-02-28 21:05 PST] - MCP validate_xanoscript Tool Access Issues

**What I was trying to do:** Validate XanoScript files using the Xano MCP server's `validate_xanoscript` tool as required by the exercise instructions.

**What the issue was:** Multiple attempts to invoke the `validate_xanoscript` tool failed because I was using incorrect syntax:

1. **Attempt 1 - JSON parameter directly:**
   ```
   mcporter call xano validate_xanoscript '{"file_paths": [...]}'
   ```
   Result: `Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required`

2. **Attempt 2 - Flag-style parameters:**
   ```
   mcporter call xano validate_xanoscript --directory '/path/to/dir'
   ```
   Result: Tool interpreted `--directory` as a positional argument

3. **Attempt 3 - Sub-agent delegation:**
   Spawned a sub-agent to call the tool
   Result: Sub-agent hung/running indefinitely without returning results

4. **Attempt 4 - Direct Node.js SDK:**
   Attempted to use `@modelcontextprotocol/sdk` directly
   Result: Module not found - SDK not installed in environment

**Why it was an issue:** The exercise workflow explicitly requires validation via the MCP tool before committing, but the correct syntax was not obvious from the help text or documentation.

**Solution discovered:** Use `--args` flag with JSON payload:
```bash
mcporter call xano validate_xanoscript --args '{"directory": "."}'
```

**Potential improvement:** Add clear examples to the mcporter documentation showing the `--args` syntax for JSON payloads.

---

## [2026-02-28 21:10 PST] - Documentation Retrieval Limitations

**What I was trying to do:** Get detailed XanoScript documentation for specific topics (functions, run jobs, syntax).

**What the issue was:** Calling `xanoscript_docs` with different topic parameters returned identical content (the README/overview) instead of topic-specific documentation.

**Commands tried:**
- `mcporter call xano xanoscript_docs '{"topic": "functions"}'`
- `mcporter call xano xanoscript_docs '{"topic": "essentials"}'`
- `mcporter call xano xanoscript_docs '{"topic": "run"}'`
- `mcporter call xano xanoscript_docs '{"topic": "syntax"}'`

All returned the same general README content instead of topic-specific details.

**Why it was an issue:** Without topic-specific documentation, I had to rely solely on reverse-engineering patterns from existing code examples, which is error-prone and doesn't help understand edge cases or advanced features.

**Potential solutions:**
1. Fix the topic filtering in `xanoscript_docs` 
2. Provide separate documentation files for each topic
3. Include more inline examples in the main README

---

## [2026-02-28 21:15 PST] - Variable Declaration vs Update Uncertainty

**What I was trying to do:** Understand when to use `var` vs `var.update` for variable reassignment.

**What the issue was:** The documentation doesn't clearly explain the distinction between:
```xs
var $x { value = $x + 1 }     // Re-declaration?
var.update $x { value = $x + 1 }  // Explicit update?
```

Looking at existing examples, both patterns appear in working code:
- fizzbuzz.xs uses `var $results { value = $results|merge:... }` (re-declaration style)
- fizzbuzz.xs also uses `var.update $i { value = $i + 1 }` (explicit update)
- two_sum.xs uses both patterns

**Why it was an issue:** Unclear whether re-declaring a variable with `var` in the same scope is valid or if `var.update` is required. This led to confusion about the proper pattern.

**Potential solutions:**
1. Add a section in docs explaining variable scoping and the `var` vs `var.update` distinction
2. Include a style guide recommendation
3. Provide linting rules that catch potential redeclaration issues

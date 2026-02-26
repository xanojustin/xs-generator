# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-26 04:05 PST] - Successful Implementation with No Issues

**What I was trying to do:** Create a complete XanoScript coding exercise (run job + function) that counts numbers with an even number of digits.

**What the issue was:** No issues encountered. The code validated successfully on the first attempt.

**Why it was an issue:** N/A — This is a positive feedback entry documenting a smooth experience.

**What worked well:**
1. The `xanoscript_docs` MCP tool provided clear, comprehensive documentation
2. The `cheatsheet` and `quickstart` topics were particularly helpful for syntax reference
3. The `validate_xanoscript` tool worked flawlessly and gave clear output
4. Understanding that stack variables can use shorthand (`$count` vs `$var.count`) simplified the code
5. The filter chaining syntax (`$num|abs|to_text|strlen`) was intuitive

**Potential improvements (minor suggestions):**
1. Consider adding more examples in the cheatsheet for common math operations like modulo (`%`)
2. The documentation mentions that expressions in conditionals should use backticks, but I used regular parentheses and it worked — might be worth clarifying when backticks are strictly required vs optional

---

## [2026-02-26 04:06 PST] - Tool Parameter Format Learning

**What I was trying to do:** Call the `validate_xanoscript` tool with multiple file paths

**What the issue was:** Initially tried `file_paths:=` syntax which didn't work. Had to use `--args` with JSON format.

**Why it was an issue:** The mcporter CLI has specific syntax requirements. The error message "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" was clear, but discovering the correct invocation pattern took a moment.

**Potential solution:** 
- Include a quick example in the MCP tool description showing both single file and multiple file validation syntax
- Example: `mcporter call xano.validate_xanoscript --args '{"file_paths": ["/path/to/file1.xs", "/path/to/file2.xs"]}'`

---

**Overall Assessment:** The Xano MCP server and XanoScript documentation are well-designed and functional. This exercise was completed without any blocking issues.

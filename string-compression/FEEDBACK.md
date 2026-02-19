# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-19 01:35 PST] - Unknown filter function 'substring'

**What I was trying to do:** Implement string compression by accessing individual characters of a string by index.

**What the issue was:** I assumed there would be a `substring` filter to extract portions of a string (common in many languages). The MCP validation failed with:
```
[Line 17, Column 57] Unknown filter function 'substring'
[Line 24, Column 53] Unknown filter function 'substring'
```

**Why it was an issue:** I had to look at existing implementations (palindrome-check) to discover the correct pattern. The solution was to use `split:""` to convert the string to a character array, then use `|get:$i` to access individual characters.

**Potential solution (if known):** 
- Add documentation about string indexing in the quickstart guide
- Consider adding a `substring` filter for easier string manipulation
- Or document the `split:""` + `|get` pattern as the recommended approach for character access

---

## [2025-02-19 01:30 PST] - MCP tool parameter confusion

**What I was trying to do:** Call the `validate_xanoscript` tool via mcporter.

**What the issue was:** The first attempt failed because I didn't know the correct parameter name:
```
Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

**Why it was an issue:** I initially tried `files` parameter which didn't work. Had to try `file_paths` to get it working.

**Potential solution (if known):** The error message was actually helpful in showing the valid options. No change needed, but perhaps document the mcporter usage patterns more explicitly.


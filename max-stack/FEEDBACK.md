# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-02 00:31 PST - MCP Tool Parameter Format Discovery

**What I was trying to do:** Validate XanoScript files using the `validate_xanoscript` tool

**What the issue was:** The MCP tool expects parameters in `key:value` format (not JSON), which is different from what I initially assumed based on standard JSON-RPC expectations.

**Why it was an issue:** I initially tried passing JSON-formatted parameters like `'{"file_path": "/path/to/file"}'` which the tool rejected with "One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required". The correct format is `file_path:/path/to/file`.

**Potential solution:** The documentation could include a clear example of the expected parameter format for mcporter calls. Something like:
```
mcporter call xano validate_xanoscript file_path:/path/to/file.xs
```

---

## 2025-03-02 00:32 PST - xanoscript_docs Returns Same Content for All Topics

**What I was trying to do:** Get specific documentation for `essentials`, `functions`, and `run` topics using `xanoscript_docs`

**What the issue was:** All three calls returned identical general documentation instead of topic-specific content. The documentation appeared to be the same "Quick Reference" overview regardless of which topic was requested.

**Why it was an issue:** I was expecting topic-specific documentation to help understand the nuances of writing functions vs run jobs, but received the same general overview each time.

**Potential solution:** Either:
1. The topic parameter isn't being passed correctly (similar to the validation tool parameter format issue)
2. The topics don't exist and the tool falls back to the README
3. The documentation structure is different than expected

It would help to have a working example of how to retrieve topic-specific docs, or a list of valid topics that actually return different content.

---

## 2025-03-02 00:33 PST - Successful First-Pass Validation

**What I was trying to do:** Write valid XanoScript code for a Max Stack exercise

**What went well:** The code passed validation on the first attempt for both the function and run job files.

**Key learnings that helped:**
1. Studying existing implementations (min-stack) provided a clear pattern to follow
2. The documentation showed the basic block structure: `<construct> "<name>" { input { ... } stack { ... } response = $var }`
3. Understanding that types are `text`, `int`, `bool`, not `string`, `integer`, `boolean`

**Why this matters:** The existing exercise files serve as the most valuable documentation for understanding XanoScript patterns.

---

## General Observations

1. **Pattern Learning from Examples:** The existing exercises in `~/xs/` are the most helpful resource. Each exercise demonstrates practical XanoScript patterns.

2. **Validation Tool is Fast:** The validation tool responds quickly and provides clear pass/fail feedback.

3. **Type System Clarity:** The type names (`text`, `int`, `bool`, `type[]`) are distinct from JavaScript/TypeScript conventions, but the documentation makes this clear.

4. **No Syntax Highlighting Issues:** The XanoScript syntax uses `{ }` blocks which can sometimes confuse editors, but the validation tool correctly parses the structure.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-03-03 12:00 PST - MCP Tool Parameter Passing

**What I was trying to do:** Call the `validate_xanoscript` MCP tool to validate my XanoScript files

**What the issue was:** The mcporter CLI wrapper had difficulty passing parameters correctly to the MCP tool. When using `mcporter call xano validate_xanoscript`, the tool reported "Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required" despite providing the parameters.

Attempts that failed:
- `mcporter call xano validate_xanoscript '{"file_path": "/path/to/file"}'`
- `mcporter call xano validate_xanoscript --file_path /path/to/file`
- Various JSON and CLI argument combinations

**Why it was an issue:** I had to resort to raw JSON-RPC calls via npx to access the MCP tool, which is cumbersome:
```bash
echo '{"jsonrpc": "2.0", "id": 1, "method": "tools/call", "params": {"name": "validate_xanoscript", "arguments": {"file_path": "/path"}}}' | npx @xano/developer-mcp
```

**Potential solution:** The mcporter wrapper should properly forward parameters to the underlying MCP tool. Either:
1. Fix mcporter to properly serialize JSON parameters
2. Add a direct `mcporter validate` subcommand that handles the JSON-RPC wrapping internally
3. Document the correct mcporter syntax for MCP tools with object parameters

---

## 2025-03-03 12:05 PST - Documentation Topic Parameter

**What I was trying to do:** Get specific XanoScript documentation topics using `xanoscript_docs`

**What the issue was:** Calling `xanoscript_docs` with different topic parameters (`essentials`, `functions`, `run`) all returned the same general documentation overview instead of topic-specific content.

**Why it was an issue:** I expected topic-specific documentation to help understand syntax patterns, but received identical content for all topics. This made it harder to find specific information about:
- Loop patterns and iteration
- Run job syntax specifics
- Variable declaration nuances

I had to rely on reading existing exercise implementations to understand the patterns instead of using the documentation.

**Potential solution:** The `xanoscript_docs` tool should return topic-specific content when a topic parameter is provided, or remove the topic parameter if it's not functional to avoid confusion.

---

## 2025-03-03 12:10 PST - Positive Feedback: Validation Tool Works Well

**What worked well:** Once I figured out the raw JSON-RPC approach, the `validate_xanoscript` tool worked excellently:
- Clear error messages with line/column positions
- Fast validation
- Both `file_path` and structured output worked as expected

**Why this matters:** The validation tool is critical for the development workflow and it performs its core function very well.

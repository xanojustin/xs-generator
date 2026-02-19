# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-18 17:35 PST] - MCP Server Connection Issue

**What I was trying to do:** Validate the XanoScript code using the MCP server

**What the issue was:** The `mcporter call xano.validate_xanoscript` command failed with "Unknown MCP server 'xano'" error, even though `mcporter list` showed the xano server was configured.

**Why it was an issue:** The validation tool was unavailable using the standard syntax, blocking progress until I found a workaround.

**Potential solution (if known):** The issue was that the daemon wasn't running and the xano MCP uses stdio transport. I had to use the `--stdio` flag with the full command: `mcporter call --stdio "npx @xano/developer-mcp" validate_xanoscript file_path=function.xs`

It would be helpful if:
1. The daemon auto-started when calling MCP tools
2. Or the error message suggested using `--stdio` for stdio-based servers when the daemon isn't running
3. Or the SKILL.md documented this requirement explicitly

## [2026-02-18 17:35 PST] - Lack of Hash Map/Dictionary Data Structure

**What I was trying to do:** Implement an optimal O(n) solution for Two Sum using a hash map to store seen values

**What the issue was:** Looking through the documentation, I couldn't find a clear reference to a hash map or dictionary data structure with O(1) lookup. The available types are text, int, bool, decimal, type[], json, and object (which requires a schema).

**Why it was an issue:** The optimal Two Sum solution requires hash map operations for O(n) time complexity. Without this, I had to fall back to a nested loop O(n²) solution.

**Potential solution (if known):** If XanoScript supports hash maps, document it in the types or functions docs with examples. If not, this is a significant limitation for algorithmic problems requiring fast lookups.

## [2026-02-18 17:35 PST] - Array Index Access Pattern Unclear

**What I was trying to do:** Access array elements by index using `$input.nums|get:$i`

**What the issue was:** The documentation mentions the `get` filter for object key access, but it's unclear if this works for array index access. I assumed it would based on pattern similarity, but there's no explicit example of array[index] syntax in the docs.

**Why it was an issue:** Without clear documentation, I had to guess at the syntax for array index access. Common alternatives could be `$array[$index]` or `get:$array:$index`.

**Potential solution (if known):** Add explicit examples in the quickstart or syntax docs showing:
- Array index access: `$array|get:$index`
- Multi-dimensional array access if supported

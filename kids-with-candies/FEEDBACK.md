# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-24 08:05 PST] - File Path Handling Issue

**What I was trying to do:** Validate multiple files using the `file_paths` parameter with comma-separated values

**What the issue was:** The `file_paths` parameter doesn't properly handle comma-separated paths. When I passed `file_paths=/Users/justinalbrecht/xs/kids-with-candies/function/kidsWithCandies.xs,/Users/justinalbrecht/xs/kids-with-candies/run.xs`, the MCP parsed each character as a separate file path, resulting in errors like "File not found: U", "File not found: s", etc.

**Why it was an issue:** This made batch validation via `file_paths` unusable. I had to fall back to using the `directory` parameter instead.

**Potential solution:** The MCP should either:
1. Properly parse comma-separated values in the `file_paths` array parameter
2. Document that `file_paths` requires a different format (e.g., JSON array)
3. Or clarify that `directory` is the preferred approach for multiple files

## [2025-02-24 08:06 PST] - Tilde (~) Path Expansion

**What I was trying to do:** Use `~` (tilde) to reference the home directory in file paths

**What the issue was:** The MCP doesn't expand `~` to the home directory. When I used `~/xs/kids-with-candies/...`, the validator tried to find a literal file named `~`.

**Why it was an issue:** Shell users expect `~` to work for home directory references. The error message was confusing because it showed the path being split into individual characters.

**Potential solution:** Add tilde expansion support in the validation tool, or document that absolute paths are required.


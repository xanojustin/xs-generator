# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 11:15 PST] - db.create vs db.add confusion

**What I was trying to do:** Create a new record in the email_log table after successfully sending an email via the Resend API.

**What the issue was:** I used `db.create email_log { ... }` which resulted in a validation error: `Expecting: one of these possible Token sequences: ... 6. [add] ... but found: 'create'`

**Why it was an issue:** The naming is counterintuitive - most ORMs and database libraries use `create` for inserting new records (Rails ActiveRecord, Prisma, etc.). XanoScript uses `db.add` instead. This wasn't mentioned in the quick reference documentation I retrieved.

**Potential solution:** Include a note in the database quick reference that `db.add` is used for creating records, or support both `create` and `add` as aliases for developer familiarity.

---

## [2025-02-18 11:10 PST] - Documentation access workflow

**What I was trying to do:** Get comprehensive XanoScript documentation before writing code.

**What the issue was:** The `xanoscript_docs` tool works well, but I had to make multiple separate calls to get different topics (run, functions, external-apis, quickstart, syntax). Each call took ~1-3 seconds and the output was quite verbose even in `quick_reference` mode.

**Why it was an issue:** For AI code generation, having to make 5+ separate tool calls to gather all needed context is inefficient. A single "get all essentials" topic or a more compact cheatsheet format would speed up development.

**Potential solution:** Consider adding a `topic=essentials` or `topic=cheatsheet` that returns the most commonly needed patterns in a very compact format (db operations, api requests, conditionals, variables).

---

## [2025-02-18 11:09 PST] - MCP tool naming consistency

**What I was trying to do:** Call the validation tool using the pattern I saw in the schema output.

**What the issue was:** The schema shows `validate_xanoscript` as the function name, but when using mcporter, I had to figure out the correct invocation pattern. Initially I wasn't sure if it was `xano.validate_xanoscript` or just `validate_xanoscript`.

**Why it was an issue:** Minor confusion about the server name prefix when using mcporter vs direct MCP calls.

**Potential solution:** The mcporter output showing examples was helpful (`mcporter call xano.validate_xanoscript`). No change needed, just noting the learning curve.

---

## General Notes

- The validation tool is excellent - clear error messages with line/column numbers
- The suggested valid token sequences in error messages are very helpful
- Having both `file_path`, `file_paths`, and `directory` options for validation is flexible and useful
- The separation of `params` vs `body` in `api.request` is counterintuitive (params is actually the request body for POST/PUT), but the documentation explicitly warns about this which is great

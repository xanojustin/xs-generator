# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 05:47 PST] - List Type Syntax Confusion

**What I was trying to do:**
Create a function input parameter for a list of attendee email addresses.

**What the issue was:**
I initially used `list attendees?` as the type declaration, but this is not valid XanoScript syntax. The validation error was: "Expecting --> } <-- but found --> 'list' <--"

**Why it was an issue:**
The types documentation shows `text[]` for arrays, but it's easy to miss that `list` is not a standalone primitive type. The error message was somewhat cryptic - it made it seem like there was a closing brace issue rather than an invalid type.

**Potential solution (if known):**
- The types quick reference could explicitly show examples of array declarations in the context of function inputs
- A more descriptive error like "Invalid type 'list'. Did you mean 'text[]'?" would be helpful
- An input parameter examples section in the functions documentation would help

---

## [2026-02-16 05:46 PST] - Foreach Loop Variable Declaration Unclear

**What I was trying to do:**
Iterate over the attendees list and build a list of attendee objects for the Google Calendar API.

**What the issue was:**
I was initially unsure of the correct syntax for using `foreach` and building a list incrementally. The documentation shows `foreach` syntax but not common patterns like building a list from another list.

**Why it was an issue:**
I had to figure out the pattern of initializing an empty list `var $attendee_list { value = [] }` and then appending to it with `var $attendee_list { value = $attendee_list ~ [$attendee_obj] }`. This is a common pattern but not explicitly documented.

**Potential solution (if known):**
- Add a "Common Patterns" section to the quickstart showing list transformation patterns
- Example: "Building a new list from an existing list" or "Mapping array elements"

---

## [2026-02-16 05:45 PST] - Environment Variable Access Documentation

**What I was trying to do:**
Access environment variables (`$env.VAR_NAME`) in my function.

**What the issue was:**
The documentation mentions `env` in the run.job section for declaring required environment variables, but doesn't clearly show how to access them within the function stack.

**Why it was an issue:**
I assumed `$env.VAR_NAME` based on the pattern of `$input`, but wasn't 100% sure until I tested it. This is a critical piece of information for any run job that uses API keys or configuration.

**Potential solution (if known):**
- Add a clear section in the run documentation showing `$env.VAR_NAME` syntax
- Include an example that shows both declaring env vars in run.job AND accessing them in the function

---

## [2026-02-16 05:45 PST] - API Request Response Structure Unclear

**What I was trying to do:**
Access the response data from an `api.request` call.

**What the issue was:**
The documentation shows `api.request` syntax but doesn't clearly document the structure of the response object.

**Why it was an issue:**
I had to guess that the response would be in `$api_result.response.status` and `$api_result.response.result`. The precondition example shows status checking but doesn't explain what else is available.

**Potential solution (if known):**
- Document the full response object structure for `api.request`
- Example: `$result.response.status`, `$result.response.result`, `$result.response.headers`, etc.

---

## [2026-02-16 05:45 PST] - String Concatenation with Filters Gotcha

**What I was trying to do:**
Build a URL with URL-encoded components using string concatenation.

**What the issue was:**
The syntax documentation mentions that filters need parentheses when concatenating, but this is easy to miss and would be a common source of errors.

**Why it was an issue:**
I had: `url = "https://.../" ~ $calendar_id|url_encode ~ "/events"` which would fail without parentheses around `($calendar_id|url_encode)`.

**Potential solution (if known):**
- Make this a highlighted warning/callout in the syntax documentation
- Consider if the parser could be more forgiving here, or provide a better error message

---

## [2026-02-16 05:50 PST] - MCP Tool Success

**What worked well:**
- The `xanoscript_docs` tool was very helpful for getting syntax reference
- The `validate_xanoscript` tool caught my type error immediately
- The quick_reference mode provided concise, useful information

**Suggestions:**
- Consider adding a "common patterns" or "cookbook" topic to the docs
- An interactive validator that suggests fixes (like "Did you mean text[]?") would be excellent

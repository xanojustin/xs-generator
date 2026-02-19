# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 17:05 PST] - Filter naming confusion

**What I was trying to do:** Add a maximum length validation to a text input field to limit input to 1000 characters.

**What the issue was:** I used `filters=max_length:1000` based on common programming conventions, but the validator rejected it saying "Filter 'max_length' cannot be applied to input of type 'text'".

**Why it was an issue:** The error message was slightly misleading - it suggested the filter couldn't be applied to text, when actually the filter name was wrong. I had to look up the documentation to discover that text length validation uses `max:<n>` (not `max_length`).

**Potential solution:** The error message could be improved to suggest the correct filter name, like: "Unknown filter 'max_length'. Did you mean 'max'?"

---

## [2025-02-18 17:08 PST] - regex_replace syntax is unintuitive

**What I was trying to do:** Remove all non-alphanumeric characters from a string using regex_replace.

**What the issue was:** My initial attempt was `$lowercase|regex_replace:[^a-z0-9]:"":"g"` which failed with a parser error "Expecting --> ] <-- but found --> 'a'".

**Why it was an issue:** The syntax for regex_replace is different from most programming languages. It requires:
1. The pattern wrapped in `/.../` slashes as a string
2. The format is `"/pattern/"|regex_replace:"replacement":"subject"` (subject comes LAST)

This is opposite of many languages where the subject comes first (e.g., `subject.replace(pattern, replacement)`).

**Potential solution:** 
1. Consider a more conventional syntax like `$subject|regex_replace:"/pattern/":"replacement"`
2. Better documentation with multiple examples in the error message or hover hints
3. A validation warning that suggests the correct syntax when parsing fails near regex_replace

---

## [2025-02-18 17:10 PST] - Documentation discovery

**What I was trying to do:** Find the correct syntax for regex_replace and input validation filters.

**What the issue was:** I had to grep through the full syntax documentation to find the regex_replace example. It wasn't in an obvious location.

**Why it was an issue:** The docs are comprehensive but finding specific filter syntax requires scanning through large JSON responses. A searchable/filterable reference would help.

**Potential solution:** 
1. Add a `xanoscript_docs({ filter: "regex_replace" })` option to get specific filter documentation
2. Include a "Common Filters Quick Reference" in the main docs output

---

## General Observations

**What worked well:**
- The MCP validate_xanoscript tool is fast and gives clear line/column error locations
- The validate tool gives helpful suggestions ("Use 'text' instead of 'string'")
- Having the xanoscript_docs topic system is useful for looking up specific areas

**What could improve:**
- More intuitive error messages that suggest the correct syntax
- A "cookbook" of common patterns (string cleaning, validation, etc.)
- Auto-completion hints for filter names and syntax

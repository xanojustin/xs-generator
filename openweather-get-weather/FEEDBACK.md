# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-16 22:15 PST] - Initial MCP Discovery

**What I was trying to do:**
Call the xanoscript_docs tool to get documentation before writing any XanoScript code.

**What the issue was:**
I initially tried `mcporter call xanoscript_docs` without specifying the server name, which failed with "Unknown MCP server 'xanoscript_docs'". I had to run `mcporter list` first to discover the server was named "xano", then use `mcporter call xano.xanoscript_docs`.

**Why it was an issue:**
The error message didn't suggest that I needed to prefix the tool with the server name. It took an extra step to figure out the correct syntax.

**Potential solution:**
- Better error message suggesting to use `mcporter list` to see available servers
- Or include the server name in the error: "Unknown MCP server 'xanoscript_docs'. Did you mean 'xano.xanoscript_docs'?"

---

## [2026-02-16 22:16 PST] - Documentation Structure Was Excellent

**What I was trying to do:**
Understand how to write a run.job and make API calls.

**What went well:**
The xanoscript_docs tool provided excellent, well-organized documentation with:
- Clear quick reference tables
- Complete syntax examples
- Common mistakes section
- Type mapping (e.g., string → text, boolean → bool)

**Why this helped:**
The documentation was comprehensive enough that I could write valid XanoScript on my first attempt without trial and error.

**Potential improvement:**
- Consider adding a "cheatsheet" mode that's even more compact for quick lookups during coding

---

## [2026-02-16 22:18 PST] - API Request params Parameter Confusion

**What I was trying to do:**
Make a GET request to OpenWeatherMap API.

**What could have been confusing:**
The documentation clearly states that `params` is used for the request body (not query parameters), which is counterintuitive naming. However, the docs explicitly call this out with "Note: The `params` parameter is used for the **request body** (not query parameters)."

**Why this matters:**
Without that warning, I would have definitely made the mistake of putting query parameters in the params field. The documentation saved me here.

**Potential solution:**
The documentation already handles this well, but maybe consider aliasing `body` as an alternative parameter name in the future for clarity.

---

## [2026-02-16 22:19 PST] - Filter Expression Parentheses

**What I was trying to do:**
Build a URL string with the `url_encode` filter for the city name.

**What I had to remember:**
The documentation emphasizes that filters in expressions need parentheses: `($input.city|url_encode)` not `$input.city|url_encode`.

**Why this matters:**
This is different from many other template languages and could easily trip up developers. The documentation's "Common Mistakes" section calling this out was very helpful.

---

## [2026-02-16 22:20 PST] - Validation Was Instant and Helpful

**What I was trying to do:**
Validate the .xs files I created.

**What went well:**
The validate_xanoscript tool worked perfectly with the directory parameter. It validated all 2 files instantly and confirmed they were all valid.

**Why this helped:**
Knowing my code passed validation before pushing to GitHub gave me confidence. The batch validation with the directory parameter was convenient.

**Potential improvement:**
- Would be nice to have the validator catch style suggestions (like trailing whitespace) in addition to syntax errors
- Error message formatting could include line numbers and column positions when validation fails

---

## [2026-02-16 22:21 PST] - Overall Experience

**Summary:**
The Xano MCP worked well overall. The documentation was the highlight - comprehensive, well-organized, and prevented common mistakes. The validation tool was fast and accurate.

**Minor suggestions:**
1. Add a tool to generate a starter template for run.job or run.service
2. Consider adding a "lint" or "format" tool for consistent code style
3. The MCP could provide autocomplete suggestions for common patterns

**Files created:**
- `~/xs/openweather-get-weather/run.xs` - Run job configuration
- `~/xs/openweather-get-weather/function/fetch_weather.xs` - Weather fetching function
- `~/xs/openweather-get-weather/README.md` - Documentation

**Result:** All files passed validation on first attempt. Zero syntax errors.

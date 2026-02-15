# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-15 04:47 PST] - Lack of Syntax Examples for Complex Expressions

**What I was trying to do:**
Create a function that builds a URL by concatenating strings and using the `url_encode` filter on the address input.

**What the issue was:**
I initially wrote the string concatenation without parentheses around the filtered expression:
```xs
var $api_url { 
  value = "https://maps.googleapis.com/maps/api/geocode/json?address=" ~ $encoded_address|url_encode ~ "&key=" ~ $env.google_maps_api_key
}
```

This caused validation errors. The correct syntax requires parentheses around filtered expressions when used in concatenation.

**Why it was an issue:**
The quick_reference docs mention this in the syntax section, but it's easy to miss. I had to discover the correct pattern through trial and error with the validator.

**Potential solution (if known):**
Add more prominent examples in the quickstart or syntax docs showing string concatenation with filters. Perhaps include a "Common Mistakes" section.

---

## [2026-02-15 04:48 PST] - Unclear Error Response Structure

**What I was trying to do:**
Check the API response status from the Google Maps Geocoding API to validate success/failure.

**What the issue was:**
I wasn't sure what structure the `api.request` result would have. I assumed `$geocode_response.response.status` would contain the HTTP status code, but the Google API returns a string status like "OK" or "ZERO_RESULTS" in the response body.

**Why it was an issue:**
The documentation doesn't clearly explain the structure of the `api.request` result object. I had to guess that it would be `$response.response.status` for the HTTP status and `$response.response.body` or similar for the parsed JSON.

**Potential solution (if known):**
Add documentation for the `api.request` stack item showing:
- What fields are available in the result
- How HTTP responses are parsed
- Examples of accessing response data

---

## [2026-02-15 04:49 PST] - Input Block Empty Syntax Ambiguity

**What I was trying to do:**
Understand the correct syntax for functions with no inputs.

**What the issue was:**
The functions quick_reference mentions that for no-input functions, braces must be on separate lines:
```xs
input {
}
```

However, it's not clear if this is strictly required or just a style preference.

**Why it was an issue:**
Minor ambiguity - I wasn't sure if a single-line `input {}` would work or cause parsing errors.

**Potential solution (if known):**
Clarify in the documentation whether this is a parser requirement or just a recommended style.

---

## [2026-02-15 04:50 PST] - Missing `default` Filter

**What I was trying to do:**
Provide default values for optional fields like `partial_match` which may not exist in all API responses.

**What the issue was:**
The documentation explicitly states there is no `default` filter. I had to work around this by accessing the property directly and letting it be null.

**Why it was an issue:**
Most templating languages have a default/coalesce filter. Its absence is notable and requires alternative approaches.

**Potential solution (if known):**
Consider adding a `default` filter or document the recommended pattern for handling optional/null values (using `first_notnull` or conditionals).

---

## [2026-02-15 04:51 PST] - No `url_encode` Filter Documentation

**What I was trying to do:**
URL-encode the address parameter for the Google Maps API call.

**What the issue was:**
I assumed a `url_encode` filter would exist based on common patterns, but it's not documented in the syntax quick_reference filter table.

**Why it was an issue:**
I had to guess/hope that this filter exists. It did work, but I wasn't sure until validation passed.

**Potential solution (if known):**
Add `url_encode` (and potentially `url_decode`) to the documented filter list. Also consider adding other common string manipulation filters that developers expect.

---

## Summary

Overall the MCP validator was very helpful - it caught syntax errors immediately and helped me iterate quickly. The main pain points were:

1. **Incomplete filter documentation** - Some useful filters exist but aren't documented
2. **Unclear result object structures** - Hard to know what fields are available on operation results
3. **String concatenation with filters** - Parentheses requirement is easy to miss

The validation tool itself worked flawlessly and provided clear error messages when syntax was incorrect.

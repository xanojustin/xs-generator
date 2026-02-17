# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 07:50 PST] - Object Type Not Valid in Input Block

**What I was trying to do:**
Create an input block for my function that accepts a notes object with key-value pairs (similar to how Stripe metadata works).

**What the issue was:**
I declared the input as `object notes { description = "..." }` but XanoScript doesn't recognize `object` as a valid input type. The validation error was:
```
[Line 7, Column 20] Expecting: expecting at least one iteration which starts with one of these possible Token sequences::
  <[NewlineToken]>
but found: 'description'
```

**Why it was an issue:**
I wanted to accept a nested object structure for the notes parameter. The error message was cryptic - it didn't clearly say "object is not a valid type."

**Potential solution (if known):**
The MCP's suggestion to use "json" instead of "object" worked perfectly. The error message could be improved to directly say "'object' is not a valid type. Did you mean 'json'?" Also, the documentation could be clearer about what types are valid for inputs vs variable declarations.

---

## [2026-02-17 07:52 PST] - Base64 Encode Filter Documentation

**What I was trying to do:**
Create a Basic Auth header for Razorpay API which requires base64 encoding of `key_id:key_secret`.

**What the issue was:**
I couldn't find clear documentation about the `base64_encode` filter in the quick reference. I had to guess based on common naming conventions that it might exist.

**Why it was an issue:**
Without clear documentation of available filters, I'm guessing at what's available. If `base64_encode` didn't exist, I would have needed to find a workaround.

**Potential solution (if known):**
A comprehensive filter reference in the quickstart or a dedicated filters topic would be helpful. The syntax docs mention 100+ filters but don't list them all in the quick reference.

---

## [2026-02-17 07:48 PST] - HTTP Basic Auth Pattern

**What I was trying to do:**
Implement HTTP Basic Authentication for the Razorpay API.

**What the issue was:**
There was no clear example of how to do Basic Auth in the external-apis documentation. I had to infer the pattern from the Stripe example (Bearer token) and adapt it.

**Why it was an issue:**
Basic Auth is a very common authentication pattern. Having an explicit example would have saved time and reduced guesswork.

**Potential solution (if known):**
Add a section to the `integrations/external-apis` documentation showing common auth patterns:
- Bearer token (already shown)
- Basic Auth (username:password base64 encoded)
- API Key in header
- API Key in query parameter

---

## General Observations

### What Worked Well
1. The validation tool is very helpful - it gives specific line/column numbers
2. The suggestions feature ("Use json instead of object") is excellent
3. The run.job documentation was clear and easy to follow
4. Having existing examples (like stripe-create-charge) made it easy to understand the pattern

### Suggestions for MCP Improvement
1. **Add a filter reference topic** - A comprehensive list of all available filters with examples
2. **Add auth patterns topic** - Common authentication patterns for external APIs
3. **Improve error messages** - More direct suggestions like "'object' is not valid, use 'json' instead"
4. **Type compatibility matrix** - Show which types work where (input block vs var declaration vs response)

---

*This feedback was generated during the creation of the razorpay-create-order run job.*
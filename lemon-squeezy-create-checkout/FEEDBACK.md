# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-17 08:15 PST] - Validation Tool Parameter Parsing Issues

**What I was trying to do:**
Validate the XanoScript files I created using the `validate_xanoscript` MCP tool before committing to GitHub.

**What the issue was:**
The validate_xanoscript tool consistently returned an error saying that one of 'code', 'file_path', 'file_paths', or 'directory' parameter was required, even when those parameters were provided.

I tried multiple approaches:
1. JSON object with `directory` parameter: `'{"directory":"/path"}'`
2. JSON object with `file_paths` parameter: `'{"file_paths":["/path/file.xs"]}'`
3. JSON object with `code` parameter containing inline code
4. Using command-line style flags: `--file_path /path/file.xs`
5. Piping file content to stdin

All attempts resulted in the same error:
```
Error: One of 'code', 'file_path', 'file_paths', or 'directory' parameter is required
```

**Why it was an issue:**
This blocked me from validating the XanoScript syntax using the MCP tool. I had to rely on manual comparison with existing working examples to ensure my code was correct, which is less reliable than automated validation.

**Potential solution (if known):**
- The MCP tool may have issues parsing JSON parameters through mcporter
- Consider testing the parameter passing mechanism between mcporter and the Xano MCP server
- Perhaps add example calls to the tool documentation showing the exact working syntax
- The tool metadata shows it accepts these parameters, but something in the transport layer isn't passing them correctly

---

## [2026-02-17 08:16 PST] - Documentation Index Returns Same Content

**What I was trying to do:**
Get specific documentation for run jobs, quickstart patterns, and integrations to learn XanoScript syntax.

**What the issue was:**
Calling `xanoscript_docs` with different topics (`quickstart`, `run`, `integrations`) all returned the same index/overview document rather than topic-specific content.

For example:
```bash
mcporter call xano xanoscript_docs '{"topic": "quickstart"}'
mcporter call xano xanoscript_docs '{"topic": "run"}'
mcporter call xano xanoscript_docs '{"topic": "integrations"}'
```

All returned the same general index page with the list of available topics, not the specific content for each topic.

**Why it was an issue:**
I couldn't access detailed documentation for specific topics like run job syntax or integration patterns. I had to rely on the general structure information and examples from existing implementations in the ~/xs folder.

**Potential solution (if known):**
- The topic parameter may not be being passed correctly to the underlying documentation service
- Consider verifying the topic routing logic in the MCP server
- Perhaps add a test to verify that different topics return different content

---

## [2026-02-17 08:17 PST] - Figuring Out Proper api.request Structure

**What I was trying to do:**
Create a function that makes an external API call to Lemon Squeezy's checkout endpoint.

**What the issue was:**
Without access to the integrations/external-apis documentation, I had to infer the proper structure from existing examples. I was particularly unsure about:

1. How to structure the JSON:API payload (Lemon Squeezy uses JSON:API format)
2. Whether the `params` field automatically serializes objects to JSON
3. How to properly chain filters like `|to_text` and `|json_encode`
4. Whether string concatenation with `~` works the same in all contexts

**Why it was an issue:**
I had to make educated guesses based on the Stripe example, but different APIs have different requirements. Lemon Squeezy uses JSON:API format which is more complex than Stripe's form-encoded approach.

**Potential solution (if known):**
- Having access to working examples for different API styles (REST, JSON:API, GraphQL, form-encoded) would be helpful
- A cookbook-style documentation showing common integration patterns would reduce guesswork
- The existing example worked, but I was uncertain if my adaptations were correct

---

## [2026-02-17 08:18 PST] - No Clear Guidance on Error Handling Best Practices

**What I was trying to do:**
Implement proper error handling for the Lemon Squeezy API integration.

**What the issue was:**
I saw the pattern used in other examples:
```xs
conditional {
  if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
    // success
  }
  else {
    throw {
      name = "ErrorName"
      value = "Error message"
    }
  }
}
```

But I don't know if this is the idiomatic approach or if there are better alternatives like:
- `precondition` blocks
- Try-catch patterns
- Built-in error handling for HTTP requests

**Why it was an issue:**
Without access to proper documentation, I'm uncertain if my error handling follows best practices. The code works syntactically, but might not be optimal.

**Potential solution (if known):**
- Documentation showing different error handling patterns and when to use each
- Guidance on naming conventions for custom errors
- Examples of how to include structured error data (not just strings)

---

## Summary

**Overall Experience:**
The MCP server provides useful tools, but there appear to be issues with parameter passing that prevented me from using the validation tool effectively. The documentation access also had issues where specific topics returned the same index content.

**What Worked:**
- The general structure information from the index was helpful
- Existing implementations in ~/xs served as valuable references
- The function/tool listing from mcporter worked well

**What Didn't Work:**
- validate_xanoscript tool parameter parsing
- Topic-specific documentation retrieval
- Could not validate my files before committing

**Files Created Without Validation:**
Due to the validation tool issues, the following files were created based on pattern matching with existing examples rather than automated validation:
- `run.xs` - Run job configuration
- `function/lemon_squeezy_create_checkout.xs` - Function implementation
- `README.md` - Documentation

These files follow the same structure as the working Stripe example but have not been formally validated by the MCP tool.

# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-16 14:20 PST] - Object type not valid for optional inputs

**What I was trying to do:**
Create a function with an optional `object` type input parameter for custom Notion properties.

**What the issue was:**
The validator returned: `Expecting token of type --> Identifier <-- but found --> '?' <--` and suggested using "json" instead of "object".

**Code that failed:**
```xs
input {
  text database_id filters=trim
  text title filters=trim
  text? content
  object? properties  // Error here
  text[]? tags
}
```

**Why it was an issue:**
The documentation mentions `object` as a type in various places, but optional object types require `json` instead. This is inconsistent and confusing.

**Potential solution (if known):**
Clarify in the documentation when to use `object` vs `json`. It seems `json` is the correct type for optional complex/object inputs.

---

## [2025-02-16 14:22 PST] - For loop syntax is foreach, not for

**What I was trying to do:**
Loop over an array of keys from a JSON object to process custom Notion properties.

**What the issue was:**
I used `for ($custom_keys) as $key {` which is common in many languages, but XanoScript requires `foreach` with an `each as` block.

**Code that failed:**
```xs
for ($custom_keys) as $key {
  var $value { value = $input.properties|get:$key }
  var.update $page_properties {
    value = $page_properties|set:$key:$value
  }
}
```

**Why it was an issue:**
The error message was cryptic: "Expecting: expecting at least one iteration which starts with one of these possible Token sequences". It didn't clearly indicate that `for` is not valid syntax and `foreach` should be used instead.

**Potential solution (if known):**
Add a more helpful error message like: "Use `foreach` instead of `for` for array iteration" or include `for` as an alias for `foreach`.

---

## [2025-02-16 14:25 PST] - Conditional as expression not supported

**What I was trying to do:**
Use a conditional block inline to set a variable value based on a condition (similar to ternary operators in other languages).

**What the issue was:**
I tried to use `conditional { if (...) { ... } else { ... } }` as an expression to assign a value to a variable.

**Code that failed:**
```xs
var $error_message {
  value = conditional {
    if ($api_result.response.result|has:"message") {
      $api_result.response.result|get:"message"
    }
    else {
      "Unknown Notion API error"
    }
  }
}
```

**Why it was an issue:**
The error was: "Expecting: Expected an expression but found: 'conditional'". This suggests conditional blocks cannot be used as expressions, only as statements. This is different from many programming languages where ternary expressions are common.

**Potential solution (if known):**
Either:
1. Add support for conditional expressions (ternary-like syntax)
2. Provide a clearer error message explaining that conditional must be used as a statement
3. Document this limitation clearly in the syntax reference

The workaround is to use a two-step approach:
```xs
var $error_message { value = "Unknown Notion API error" }

conditional {
  if ($api_result.response.result|has:"message") {
    var.update $error_message {
      value = $api_result.response.result|get:"message"
    }
  }
}
```

---

## [2025-02-16 14:15 PST] - run_api_docs requires explicit topic parameter

**What I was trying to do:**
Call `run_api_docs` without parameters to get general documentation.

**What the issue was:**
The call returned an error: "'topic' parameter is required. Use run_api_docs with topic='start' for overview."

**Why it was an issue:**
The xanoscript_docs tool works without parameters (returns the overview/README), but run_api_docs requires a topic. This inconsistency is slightly confusing.

**Potential solution (if known):**
Make run_api_docs consistent with xanoscript_docs - return the overview when no topic is specified.

---

## [2025-02-16 14:18 PST] - Documentation example for API request uses "result" instead of "status"

**What I was trying to do:**
Check if an API request was successful.

**What the issue was:**
I initially tried using `$api_result.response.result` for status checking, but the actual field is `$api_result.response.status`.

**Why it was an issue:**
The naming is slightly confusing - `result` contains the response body, while `status` contains the HTTP status code.

**Potential solution (if known):**
Add a clearer example in the integrations/quickstart documentation showing the full response structure:
```
$api_result.response.status     // HTTP status code (200, 404, etc.)
$api_result.response.result     // Response body/payload
```

---

## General Observations

1. **Type system clarity**: The distinction between `object` and `json` types is not clearly documented. It appears `json` is for optional complex types.

2. **Loop syntax**: The `foreach ... each as` syntax is unique. While documented, the error messages when using `for` could be more helpful.

3. **Expression limitations**: The lack of ternary/conditional expressions requires more verbose code with `var` declarations followed by `conditional` blocks with `var.update`.

4. **Overall experience**: The validate_xanoscript tool is excellent - it catches errors quickly and provides helpful suggestions. The documentation system via MCP is very useful once you understand the topic structure.


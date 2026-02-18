# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-18 04:47 PST] - Empty Input Block Comment Issue

**What I was trying to do:**
Create a XanoScript function with no input parameters (for listing ngrok tunnels, which doesn't require any input).

**What the issue was:**
I initially wrote the input block with a comment inside:
```xs
input {
  // No input required - lists all active tunnels
}
```

This caused a validation error:
```
Expecting: one of these possible Token sequences:
  1. [object]
  2. [enum]
  ...
  25. [dblink]
but found: '}'
```

**Why it was an issue:**
The XanoScript parser doesn't allow comments inside empty input blocks. This wasn't clear from the documentation. I had to remove the comment entirely and use either `input {}` or remove the input block.

**Potential solution (if known):**
- Update documentation to clarify that comments inside empty blocks are not allowed
- Or allow comments in empty blocks (more developer-friendly)
- Provide clearer error messages indicating "comments not allowed in empty blocks"

---

## [2025-02-18 04:47 PST] - Run Job Input Syntax Confusion

**What I was trying to do:**
Create a run.xs file that specifies input parameters for the main function call.

**What the issue was:**
I wrote:
```xs
run.job "Ngrok List Tunnels" {
  main = {
    name: "list_ngrok_tunnels"
    input: {
      // No input required - lists all active tunnels
    }
  }
  env = ["ngrok_api_key"]
}
```

The error was:
```
Expecting: Expected an object {}
but found: '{'
```

**Why it was an issue:**
The `input:` syntax in run.job blocks appears to not accept empty objects with comments. The comment was interpreted as problematic content. I had to remove the entire input block from the main object.

**Potential solution (if known):**
- Clarify in documentation that empty input blocks in run.job should be omitted entirely
- Better error message: "Empty input blocks not allowed, remove 'input:' entirely if no parameters needed"

---

## [2025-02-18 04:47 PST] - Missing Input Clause Requirement

**What I was trying to do:**
Create a function with no input parameters by omitting the input block entirely.

**What the issue was:**
I wrote:
```xs
function "list_ngrok_tunnels" {
  description = "List all active ngrok tunnels using the ngrok API"
  stack {
    // ... implementation
  }
  response = $formatted_response
}
```

The error was:
```
function is missing an input clause
```

**Why it was an issue:**
Even for functions with no inputs, an empty `input {}` block is required. This wasn't clear from the documentation examples which mostly show functions with parameters.

**Potential solution (if known):**
- Update documentation to explicitly state that `input {}` is required even when there are no parameters
- Make the input clause optional (more intuitive for parameter-less functions)
- Provide an example of a parameter-less function in the quickstart guide

---

## [2025-02-18 04:46 PST] - Documentation Topic Retrieval Issue

**What I was trying to do:**
Retrieve specific topic documentation using `xanoscript_docs({ topic: "quickstart" })` to learn XanoScript syntax patterns.

**What the issue was:**
Calling `xanoscript_docs` with different topics (quickstart, functions, tasks, run) all returned the same generic index/documentation overview instead of the specific topic content.

**Why it was an issue:**
I couldn't access the specific syntax examples I needed. I had to resort to reading existing implementation files in the ~/xs folder to understand the correct syntax, which is less efficient.

**Potential solution (if known):**
- Fix the MCP tool to return topic-specific content
- Ensure the topic parameter is properly parsed and routed
- Add error messaging if a topic is not found rather than returning generic content

---

## [2025-02-18 04:45 PST] - Comment Syntax Unclear

**What I was trying to do:**
Add comments to my XanoScript code to document the functionality.

**What the issue was:**
From the documentation, I saw that "XanoScript only supports `//` for comments. Other comment styles like `#` are not supported." However, it wasn't clear where comments are allowed vs. not allowed.

**Why it was an issue:**
Comments inside empty blocks cause parse errors. There's no clear documentation about comment placement restrictions.

**Potential solution (if known):**
- Document that comments cannot be placed inside empty blocks `{}`
- Provide a "Comment Best Practices" section in the documentation
- List all locations where comments are/aren't allowed

---

## General Observations

### Positive:
- The validation tool (`validate_xanoscript`) is very helpful and provides specific line/column error locations
- Error messages are generally descriptive about what's expected vs. what was found
- Once syntax is correct, validation passes reliably

### Areas for Improvement:
1. **Documentation Depth**: The high-level documentation is good, but lacks specific syntax examples for edge cases (empty inputs, optional parameters, etc.)

2. **Example Library**: Having more diverse examples in the docs would help - especially parameter-less functions, complex conditionals, and different API authentication patterns

3. **Consistent Syntax**: The difference between `input:` (in run.job) and `input { }` (in functions) is subtle and easy to confuse

4. **Topic Documentation**: The xanoscript_docs tool should return specific content for each topic rather than the same generic index

5. **Empty Block Handling**: Either allow comments in empty blocks or provide clearer error messages

---

## Suggested Documentation Additions

### 1. Parameter-less Function Template
```xs
function "my_function" {
  description = "A function with no input parameters"
  input {}
  stack {
    // Your logic here
  }
  response = $result
}
```

### 2. Run Job with No Input Template
```xs
run.job "My Job" {
  main = {
    name: "my_function"
    // No input block needed if function requires no parameters
  }
  env = ["my_env_var"]
}
```

### 3. Comment Placement Guide
```xs
// This comment is fine - outside any block

function "example" {
  // This comment is fine - between clauses
  input {
    text name  // Comments after code are OK
  }
  // This is fine too
  stack {
    // Comments inside non-empty blocks are OK
  }
}
```

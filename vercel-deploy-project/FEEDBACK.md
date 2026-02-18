# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-18 00:17 PST - Table Index Type Syntax

**What I was trying to do:**
Create a secondary index on the deployment_log table for querying by project_id and created_at.

**What the issue was:**
I initially used `type: "index"` which is invalid. The validator returned:
```
Expected value of `type` to be one of `primary`, `btree`, `gin`, `btree|unique`, `search`, `vector`
```

I also incorrectly tried to use `direction: "desc"` which is not valid for index definitions.

**Why it was an issue:**
The quick_reference documentation for tables only shows the primary index example, without listing all valid index types. I had to guess and was wrong.

**Potential solution:**
Update the tables quick_reference to include all valid index types with examples:
```xs
index = [
  {type: "primary", field: [{name: "id"}]}
  {type: "btree", field: [{name: "project_id"}]}
  {type: "btree|unique", field: [{name: "email"}]}
  {type: "gin", field: [{name: "search_data"}]}
]
```

---

## 2026-02-18 00:18 PST - String Concatenation in Filter Expressions

**What I was trying to do:**
Build a URL with query parameters conditionally based on whether team_id was provided.

**What the issue was:**
Initially I wasn't sure if I could use string concatenation inside the URL parameter directly. I wasn't sure about operator precedence between `~` and conditional logic.

**Why it was an issue:**
The documentation shows basic concatenation but not complex conditional building patterns. I ended up building the query string separately using a var and conditional block, which works but is verbose.

**Potential solution:**
Add examples of conditional URL building to the external-apis documentation, showing both the verbose approach (separate var) and any concise patterns if they exist.

---

## 2026-02-18 00:20 PST - While Loop Variable Scoping

**What I was trying to do:**
Create a polling loop that checks deployment status until complete.

**What the issue was:**
Wasn't sure if variables declared outside the while loop would be accessible inside the `each` block, and whether updates would persist across iterations.

**Why it was an issue:**
The documentation shows while loops but doesn't clearly explain the interaction between `while`, `each`, and variable scoping. I had to assume that `var.update` would work based on the pattern shown in the quickstart.

**Potential solution:**
Add a specific example for polling patterns in the integrations/external-apis docs, as this is a common pattern when working with async APIs.

---

## 2026-02-18 00:21 PST - MCP Tool Discovery

**What I was trying to do:**
Find the Xano MCP server and understand what tools were available.

**What the issue was:**
The user mentioned I should call `xanoscript_docs` but I had to use mcporter to discover the available tools first. The naming convention wasn't immediately obvious (mcporter vs xano.validate_xanoscript).

**Why it was an issue:**
No clear error message or guidance on how to access the MCP when it's not immediately found. Had to use `mcporter list` to discover the xano server was available.

**Potential solution:**
If the task template mentions `xanoscript_docs`, also mention the mcporter CLI pattern: `mcporter call xano.xanoscript_docs` or show how to list available MCP servers.

---

## 2026-02-18 00:22 PST - JSON Response Path Access

**What I was trying to do:**
Access nested properties from the Vercel API response like `$deploy_response.response.result.id`.

**What the issue was:**
The documentation mentions `response.result` contains the parsed JSON, but doesn't explicitly show multi-level path access patterns. I assumed dot notation would work but wasn't 100% certain.

**Why it was an issue:**
Minor uncertainty about whether nested object access uses dot notation consistently or if there are special filters needed.

**Potential solution:**
Add an explicit example showing nested access: `$result.response.result.choices|first|get:"message"|get:"content"` is good, but also show simple nested property access like `$result.response.result.id`.

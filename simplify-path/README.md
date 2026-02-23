# Simplify Path

## Problem
Given a string `path`, which is an absolute path (starting with a slash `'/'`) to a file or directory in a Unix-style file system, convert it to the simplified canonical path.

In a Unix-style file system:
- A period `'.'` refers to the current directory
- A double period `'..'` refers to the directory up a level
- Any multiple consecutive slashes (i.e. `'//'`) are treated as a single slash `'/'`

The canonical path should have the following format:
- The path starts with a single slash `'/'`
- Any two directories are separated by a single slash `'/'`
- The path does not end with a trailing `'/'`
- The path only contains the directories on the path from the root directory to the target file or directory (i.e., no period `'.'` or double period `'..'`)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/simplify_path.xs`):** Contains the solution logic using a stack-based approach

## Function Signature
- **Input:** `text path` - An absolute file path string starting with `/`
- **Output:** `text` - The simplified canonical path

## Algorithm
The solution uses a stack-based approach:
1. Split the path by `'/'` delimiter
2. Iterate through each part:
   - Skip empty strings (from consecutive slashes like `'//'`)
   - Skip `'.'` (current directory)
   - Pop from stack for `'..'` (go up one level, if stack not empty)
   - Push valid directory names onto the stack
3. Join stack elements with `'/'` and prepend `'/'`

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `"/home/"` | `"/home"` | Basic path with trailing slash |
| `"/home//foo/"` | `"/home/foo"` | Multiple consecutive slashes |
| `"/home/user/Documents/../Pictures"` | `"/home/user/Pictures"` | Parent directory navigation |
| `"/../"` | `"/"` | Attempting to go above root |
| `"/home/././foo/"` | `"/home/foo"` | Current directory references |
| `"/a/../../b/../c//.//"` | `"/c"` | Complex mixed case |
| `"/"` | `"/"` | Root only |

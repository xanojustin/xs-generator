# Design Browser History

## Problem
Design a browser history management system that simulates how a web browser's back and forward navigation works.

You have a browser with one tab where you start on a homepage. You can:
- **Visit** another URL from the current page (this clears all forward history)
- **Go back** in history by a number of steps
- **Go forward** in history by a number of steps

### Operations
- `init(homepage)` - Initialize the browser history with a homepage URL
- `visit(url)` - Visit a new URL from the current page, clearing forward history
- `back(steps)` - Move back in history by the given number of steps (or as many as possible)
- `forward(steps)` - Move forward in history by the given number of steps (or as many as possible)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs to initialize browser history
- **Function (`function/design_browser_history.xs`):** Contains the browser history implementation with state management

## Function Signature
- **Input:**
  - `operation` (text): The operation to perform - `"init"`, `"visit"`, `"back"`, or `"forward"`
  - `history` (text[]): Array of URLs representing the browser history stack
  - `current_index` (int): Current position in the history array
  - `url` (text?, optional): URL parameter for `"init"` and `"visit"` operations
  - `steps` (int?, optional): Number of steps for `"back"` and `"forward"` operations

- **Output:**
  - `history` (text[]): Updated history array
  - `current_index` (int): Updated current position
  - `current_url` (text): The URL at the current position after the operation

## Test Cases

| Operation | Input State | Parameters | Expected Output |
|-----------|-------------|------------|-----------------|
| `init` | `history: []`, `current_index: 0` | `url: "google.com"` | `history: ["google.com"]`, `current_index: 0`, `current_url: "google.com"` |
| `visit` | `history: ["google.com"]`, `current_index: 0` | `url: "facebook.com"` | `history: ["google.com", "facebook.com"]`, `current_index: 1`, `current_url: "facebook.com"` |
| `visit` | `history: ["google.com", "facebook.com", "youtube.com"]`, `current_index: 2` | `url: "twitter.com"` | `history: ["google.com", "facebook.com", "twitter.com"]`, `current_index: 2`, `current_url: "twitter.com"` |
| `back` | `history: ["google.com", "facebook.com", "youtube.com"]`, `current_index: 2` | `steps: 1` | `current_index: 1`, `current_url: "facebook.com"` |
| `back` | `history: ["google.com", "facebook.com"]`, `current_index: 1` | `steps: 5` | `current_index: 0`, `current_url: "google.com"` (can't go back more than available) |
| `forward` | `history: ["google.com", "facebook.com", "youtube.com"]`, `current_index: 1` | `steps: 1` | `current_index: 2`, `current_url: "youtube.com"` |
| `forward` | `history: ["google.com", "facebook.com"]`, `current_index: 0` | `steps: 10` | `current_index: 1`, `current_url: "facebook.com"` (can't go forward more than available) |

### Example Walkthrough
```
1. init("google.com")     -> history: ["google.com"], current: "google.com"
2. visit("facebook.com")  -> history: ["google.com", "facebook.com"], current: "facebook.com"
3. visit("youtube.com")   -> history: ["google.com", "facebook.com", "youtube.com"], current: "youtube.com"
4. back(1)                -> current: "facebook.com"
5. back(1)                -> current: "google.com"
6. forward(1)             -> current: "facebook.com"
7. visit("twitter.com")   -> history: ["google.com", "facebook.com", "twitter.com"], current: "twitter.com"
                           (youtube.com is cleared from forward history)
8. back(5)                -> current: "google.com" (can't go back more than 2 steps)
```
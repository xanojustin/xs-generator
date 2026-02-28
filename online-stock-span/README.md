# Online Stock Span

## Problem
Design an algorithm that collects daily price quotes for some stock and returns **the span** of that stock's price for the current day.

The **span** of the stock's price today is defined as the maximum number of consecutive days (starting from today and going backward) for which the stock price was less than or equal to today's price.

For example, if the price of a stock over the next 7 days were `[100, 80, 60, 70, 60, 75, 85]`, then the stock spans would be `[1, 1, 1, 2, 1, 4, 6]`.

### Key Insight
- Day 0 (price 100): span is 1 (just today)
- Day 1 (price 80): span is 1 (80 < 100, so only today counts)
- Day 2 (price 60): span is 1 (60 < 80, so only today counts)
- Day 3 (price 70): span is 2 (70 >= 60, so today + yesterday)
- Day 4 (price 60): span is 1 (60 < 70, so only today)
- Day 5 (price 75): span is 4 (75 >= 60, 70, 60, so today + 3 previous days)
- Day 6 (price 85): span is 6 (85 >= 75, 60, 70, 60, 80, so today + 5 previous days)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/online_stock_span.xs`):** Contains the solution logic using a monotonic decreasing stack

## Function Signature
- **Input:** `prices` (int[]) - Array of daily stock prices
- **Output:** `spans` (int[]) - Array where each element is the span for the corresponding day

## Algorithm
This solution uses a **monotonic decreasing stack** for O(n) time complexity:

1. For each price, we maintain a stack of `[price, span]` pairs
2. The stack is always in decreasing order of price
3. For each new price, we pop all elements with price <= current price
4. We accumulate the spans of popped elements to get the current span
5. Push the current `[price, span]` onto the stack
6. The span represents how many consecutive days (including today) had prices <= current price

**Time Complexity:** O(n) - each element is pushed and popped at most once  
**Space Complexity:** O(n) - for the stack

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[100, 80, 60, 70, 60, 75, 85]` | `[1, 1, 1, 2, 1, 4, 6]` | Classic example from LeetCode |
| `[10]` | `[1]` | Single day - span is always 1 |
| `[5, 4, 3, 2, 1]` | `[1, 1, 1, 1, 1]` | Strictly decreasing - each day only counts itself |
| `[1, 2, 3, 4, 5]` | `[1, 2, 3, 4, 5]` | Strictly increasing - each day counts all previous |
| `[10, 10, 10, 10]` | `[1, 2, 3, 4]` | Equal prices - consecutive days accumulate |

## Example Walkthrough

For input `[100, 80, 60, 70, 60, 75, 85]`:

| Day | Price | Stack State (price, span) | Output Span |
|-----|-------|---------------------------|-------------|
| 0 | 100 | [(100, 1)] | 1 |
| 1 | 80 | [(100, 1), (80, 1)] | 1 |
| 2 | 60 | [(100, 1), (80, 1), (60, 1)] | 1 |
| 3 | 70 | [(100, 1), (80, 1), (70, 2)] | 2 (popped 60, span=1+1) |
| 4 | 60 | [(100, 1), (80, 1), (70, 2), (60, 1)] | 1 |
| 5 | 75 | [(100, 1), (80, 1), (75, 4)] | 4 (popped 60, 70, 60; span=1+1+2+1) |
| 6 | 85 | [(85, 6)] | 6 (popped 75, 60, 70, 60, 80, 100; span=1+4+2+1+1+1) |

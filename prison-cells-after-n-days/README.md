# Prison Cells After N Days

## Problem

There are 8 prison cells in a row, and each cell is either occupied (1) or vacant (0).

Each day, whether the cell will be occupied is determined by the state of its neighbors:
- If both neighbors are occupied (1) or both are vacant (0), the cell becomes occupied (1)
- Otherwise, it becomes vacant (0)

**Note:** The first and last cells (index 0 and 7) don't have two neighbors, so they will always become vacant (0) after day 1.

Given the initial state of the prison and a number of days `n`, return the state of the prison after `n` days.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/prison_cells.xs`):** Contains the solution logic with cycle detection for efficiency

## Function Signature

- **Input:**
  - `cells` (int[]): Initial state of 8 prison cells (0 or 1)
  - `n` (int): Number of days to simulate
- **Output:**
  - int[]: State of the 8 cells after n days

## Algorithm

The solution uses **cycle detection** to optimize for large values of `n`:

1. **State Representation:** Convert the cell array to a number for efficient storage
2. **Simulation:** For each day, compute the next state based on neighbor rules
3. **Cycle Detection:** Track seen states; if a state repeats, we've found a cycle
4. **Fast-forward:** Skip entire cycles using modulo arithmetic

Since only the 6 middle cells can change (positions 1-6), there are at most 2^6 = 64 possible states, guaranteeing a cycle will be found quickly.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `cells: [0,1,0,1,1,0,0,1]`, `n: 7` | `[0,0,1,1,0,0,0,0]` |
| `cells: [1,0,0,1,0,0,1,0]`, `n: 1000000000` | `[0,0,1,1,1,1,1,0]` |
| `cells: [0,0,0,0,0,0,0,0]`, `n: 10` | `[0,0,0,0,0,0,0,0]` |
| `cells: [1,1,1,1,1,1,1,1]`, `n: 1` | `[0,0,0,0,0,0,0,0]` |

### Test Case Explanations:

1. **Basic case:** 7 days of evolution from a mixed starting state
2. **Large n with cycle:** 1 billion days - requires cycle detection to solve efficiently
3. **All zeros:** Edge case - stays all zeros forever
4. **All ones:** After 1 day, all become 0 (first/last forced to 0, neighbors differ for middle cells)

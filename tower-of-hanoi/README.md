# Tower of Hanoi

## Problem

The Tower of Hanoi is a classic mathematical puzzle. Given three pegs (A, B, C) and `n` disks of different sizes stacked on peg A in decreasing order of size (smallest on top), move all disks to peg C following these rules:

1. Only one disk can be moved at a time
2. A larger disk cannot be placed on top of a smaller disk
3. All disks must be on peg C at the end

The minimum number of moves required to solve the puzzle with `n` disks is **2^n - 1**.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input (3 disks)
- **Function (`function/tower_of_hanoi.xs`):** Main entry point that validates input and initiates the solution
- **Function (`function/tower_of_hanoi_helper.xs`):** Recursive helper that implements the core algorithm

## Function Signature

### Main Function: `tower_of_hanoi`

**Input:**
- `num_disks` (int): Number of disks to move (must be >= 1)

**Output:**
- Array of move objects, where each move has:
  - `from` (text): Source peg ("A", "B", or "C")
  - `to` (text): Destination peg ("A", "B", or "C")
  - `disk` (int): Which disk is being moved (1 = smallest, n = largest)

### Helper Function: `tower_of_hanoi_helper`

**Input:**
- `n` (int): Number of disks to move
- `source` (text): Source peg name
- `auxiliary` (text): Auxiliary peg name  
- `destination` (text): Destination peg name

**Output:**
- Array of move objects

## Algorithm

The recursive solution follows these steps:

1. Move `n-1` disks from source to auxiliary peg (using destination as auxiliary)
2. Move the largest disk (disk `n`) from source to destination
3. Move `n-1` disks from auxiliary to destination (using source as auxiliary)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `num_disks: 1` | `[{from: "A", to: "C", disk: 1}]` (1 move) |
| `num_disks: 2` | `[{from: "A", to: "B", disk: 1}, {from: "A", to: "C", disk: 2}, {from: "B", to: "C", disk: 1}]` (3 moves) |
| `num_disks: 3` | 7 moves total (see below) |
| `num_disks: 4` | 15 moves total |

### Detailed Output for 3 Disks

```
1. Move disk 1 from A to C
2. Move disk 2 from A to B
3. Move disk 1 from C to B
4. Move disk 3 from A to C
5. Move disk 1 from B to A
6. Move disk 2 from B to C
7. Move disk 1 from A to C
```

## Complexity

- **Time Complexity:** O(2^n) - must visit each of the 2^n - 1 moves
- **Space Complexity:** O(n) - recursion stack depth

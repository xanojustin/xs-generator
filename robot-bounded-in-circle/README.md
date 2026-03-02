# Robot Bounded In Circle

## Problem

On an infinite plane, a robot initially stands at position (0, 0) and faces north. The robot can receive one of three instructions:

- `"G"`: Go straight 1 unit
- `"L"`: Turn 90 degrees to the left (counter-clockwise)
- `"R"`: Turn 90 degrees to the right (clockwise)

The robot performs the instructions given in order, and repeats them forever.

Return `true` if and only if there exists a circle in the plane such that the robot never leaves the circle (i.e., the robot's path is bounded).

### Key Insight

After executing the instructions once:
1. If the robot returns to the origin (0, 0), it's bounded
2. If the robot is NOT facing north, it will eventually return to the origin after more cycles (bounded)
3. If the robot is facing north but NOT at the origin, it will keep moving further away (unbounded)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/robot_bounded_in_circle.xs`):** Contains the simulation logic to track robot position and direction

## Function Signature

- **Input:** 
  - `instructions` (text): A string containing only the characters 'G', 'L', and 'R'
- **Output:** 
  - `bounded` (bool): `true` if the robot's path is bounded in a circle, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"GGLLGG"` | `true` | Robot moves in a square and returns to origin |
| `"GG"` | `false` | Robot keeps moving north forever |
| `"GL"` | `true` | After 4 cycles, robot returns to origin |
| `"GLGLGLGL"` | `true` | Multiple turns bring robot back to origin facing north |
| `""` | `true` | Empty instructions - robot stays at origin |
| `"GRGRGRGR"` | `true` | Four right turns return to origin |

## Algorithm

1. Initialize position at (0, 0) and direction facing North
2. For each instruction:
   - 'G': Move 1 unit in current direction
   - 'L': Turn left (direction = (direction + 3) % 4)
   - 'R': Turn right (direction = (direction + 1) % 4)
3. After all instructions, check if bounded:
   - Return `true` if at origin OR not facing North
   - Return `false` otherwise

## Direction Mapping

| Direction | Value | Vector (x, y) |
|-----------|-------|---------------|
| North     | 0     | (0, 1)        |
| East      | 1     | (1, 0)        |
| South     | 2     | (0, -1)       |
| West      | 3     | (-1, 0)       |

## Complexity

- **Time Complexity:** O(n) where n is the length of instructions
- **Space Complexity:** O(1) - only tracking position and direction

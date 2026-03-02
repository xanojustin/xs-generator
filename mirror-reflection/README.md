# Mirror Reflection

## Problem

There is a special square room with mirrors on each of the four walls. Except for the southwest corner, there are receptors on each of the remaining three corners, numbered 0, 1, and 2.

The room has walls of length `p`, and a laser ray from the southwest corner first meets the east wall at a distance `q` from the 0th receptor.

Return the number of the receptor that the ray meets first.

### Room Layout

```
    0 ____________ 1
     |            |
     |            |
     |            |
    2|____________| (laser starts here)
```

- **Receptor 0**: Northwest corner
- **Receptor 1**: Northeast corner  
- **Receptor 2**: Southwest corner (no receptor, laser starts here)
- **Laser**: Starts at southwest corner, shoots toward east wall

### How It Works

The laser beam reflects off mirrors according to the law of reflection (angle of incidence equals angle of reflection). Instead of tracing the bouncing path, we can "unfold" the room and trace a straight line. The solution uses the mathematical properties of this unfolding:

1. Calculate GCD of `p` and `q` using the Euclidean algorithm
2. Reduce to simplest form: `p/gcd` and `q/gcd`
3. Determine receptor based on parity:
   - If `p/gcd` is **even**: hits receptor **2** (south side)
   - If `p/gcd` is **odd** and `q/gcd` is **even**: hits receptor **0** (north side)
   - If both are **odd**: hits receptor **1** (east/northeast corner)

## Structure

- **Run Job (`run.xs`):** Calls the `mirror_reflection` function with test inputs
- **Function (`function/mirror_reflection.xs`):** Contains the solution logic using GCD and parity checks

## Function Signature

- **Input:**
  - `p` (int): Length of the square room walls (1 ≤ p ≤ 1000)
  - `q` (int): Distance from receptor 0 where laser first hits east wall (1 ≤ q ≤ p)
- **Output:** (int) The number of the receptor (0, 1, or 2) that the ray meets first

## Test Cases

| p | q | Expected Output | Explanation |
|---|---|-----------------|-------------|
| 2 | 1 | 2 | Ray bounces and hits receptor 2 |
| 3 | 1 | 1 | Ray travels through unfolded rooms to hit corner 1 |
| 3 | 2 | 0 | Ray hits receptor 0 after reflections |
| 4 | 3 | 2 | Ray hits receptor 2 |
| 1 | 1 | 1 | Minimal case - direct hit on receptor 1 |
| 1000 | 1 | 0 | Large room, small q - hits receptor 0 |

### Edge Cases

- **Minimum values (p=1, q=1)**: Laser goes directly to receptor 1
- **p = q**: Laser travels at 45° angle
- **Large values**: Algorithm efficiently handles up to constraints using GCD

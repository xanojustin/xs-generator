# Rotate Image

## Problem
You are given an n x n 2D matrix representing an image. Rotate the image by 90 degrees (clockwise).

Given an n x n matrix, you need to rotate it in-place such that:
- The first row becomes the last column
- The last row becomes the first column
- And so on for all elements

### Example

**Input:**
```
[
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
]
```

**Output:**
```
[
  [7, 4, 1],
  [8, 5, 2],
  [9, 6, 3]
]
```

**Visualization:**
```
1 2 3        7 4 1
4 5 6   →    8 5 2
7 8 9        9 6 3
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with a test 3x3 matrix
- **Function (`function/rotate-image.xs`):** Contains the matrix rotation logic using layer-by-layer approach

## Function Signature
- **Input:**
  - `matrix` (json): A 2D array representing an n x n matrix where n >= 1
- **Output:**
  - (json): The rotated matrix (n x n 2D array)

## Algorithm Explanation

The solution uses a **layer-by-layer rotation** approach:

1. **Divide the matrix into layers** - Think of the matrix as concentric squares (layers)
   - For a 3x3 matrix: 1 layer (the outer ring)
   - For a 4x4 matrix: 2 layers (outer ring + inner 2x2)

2. **Rotate each layer** - For each layer, rotate elements in groups of 4:
   - Save the top element
   - Move left → top
   - Move bottom → left
   - Move right → bottom
   - Move saved top → right

3. **Continue until all layers are processed**

### Time & Space Complexity
- **Time Complexity:** O(n²) - we touch each element exactly once
- **Space Complexity:** O(n²) for the result matrix (could be optimized to O(1) with true in-place rotation)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 2, 3], [4, 5, 6], [7, 8, 9]]` | `[[7, 4, 1], [8, 5, 2], [9, 6, 3]]` |
| `[[1]]` | `[[1]]` |
| `[[1, 2], [3, 4]]` | `[[3, 1], [4, 2]]` |
| `[[5, 1, 9, 11], [2, 4, 8, 10], [13, 3, 6, 7], [15, 14, 12, 16]]` | `[[15, 13, 2, 5], [14, 3, 4, 1], [12, 6, 8, 9], [16, 7, 10, 11]]` |
| `[]` | `[]` |

### Test Case Breakdown:
1. **Basic 3x3 case:** Standard rotation with odd dimension
2. **Single element:** Edge case - 1x1 matrix stays the same
3. **2x2 matrix:** Smallest non-trivial case
4. **4x4 matrix:** Even dimension with more elements
5. **Empty matrix:** Edge case - returns empty

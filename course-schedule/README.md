# Course Schedule

## Problem

There are a total of `num_courses` courses you have to take, labeled from `0` to `num_courses - 1`. You are given an array `prerequisites` where `prerequisites[i] = [a, b]` indicates that you must take course `b` before you can take course `a`.

Return `true` if you can finish all courses. Otherwise, return `false`.

This is essentially a cycle detection problem in a directed graph. If there's a cycle in the prerequisite graph (e.g., course A requires B, B requires C, and C requires A), it's impossible to complete all courses.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/can_finish.xs`):** Contains the solution logic using Kahn's algorithm (topological sort)

## Function Signature

- **Input:**
  - `num_courses` (int): Total number of courses (labeled 0 to num_courses-1)
  - `prerequisites` (object[]): Array of [course, prerequisite] pairs
- **Output:**
  - `bool`: `true` if all courses can be completed, `false` otherwise

## Algorithm

This solution uses **Kahn's Algorithm** for topological sorting:

1. Build an adjacency list representation of the graph
2. Calculate in-degree (number of prerequisites) for each course
3. Start with courses that have no prerequisites (in-degree = 0)
4. Process each course, reducing the in-degree of its dependents
5. If a course's in-degree becomes 0, add it to the queue
6. If we process all courses, no cycle exists → return `true`
7. If we can't process all courses, a cycle exists → return `false`

## Test Cases

| num_courses | prerequisites | Expected Output |
|-------------|---------------|-----------------|
| 2 | `[[1,0]]` | `true` |
| 2 | `[[1,0],[0,1]]` | `false` |
| 4 | `[[1,0],[2,1],[3,2]]` | `true` |
| 4 | `[[1,0],[2,1],[3,2],[0,3]]` | `false` |
| 1 | `[]` | `true` |
| 3 | `[[0,1],[1,2],[2,0]]` | `false` |

### Test Case Descriptions

1. **Basic case (2 courses, 1 prerequisite):** Simple linear dependency, should succeed
2. **Cycle case (2 courses, circular dependency):** Course 1 requires 0, 0 requires 1 - impossible
3. **Linear chain (4 courses):** Long chain of dependencies, should succeed
4. **Cycle in chain (4 courses):** Linear chain with cycle back to start - impossible
5. **Single course, no prerequisites:** Edge case with just one course
6. **Triangle cycle (3 courses):** A → B → C → A circular dependency

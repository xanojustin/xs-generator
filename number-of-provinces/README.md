# Number of Provinces

## Problem

There are `n` cities. Some of them are connected, while some are not. If city `a` is connected directly with city `b`, and city `b` is connected directly with city `c`, then city `a` is connected indirectly with city `c`.

A **province** is a group of directly or indirectly connected cities and no other cities outside of the group.

Given an `n x n` matrix `isConnected` where `isConnected[i][j] = 1` represents a direct connection between city `i` and city `j`, and `isConnected[i][j] = 0` otherwise, return the total number of provinces.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/countProvinces.xs`):** Contains the DFS-based solution logic to count connected components

## Function Signature

- **Input:**
  - `isConnected` (json): An n x n adjacency matrix where `isConnected[i][j] = 1` means city `i` is directly connected to city `j`
- **Output:**
  - `int`: The total number of provinces (connected components) in the graph

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[[1,1,0],[1,1,0],[0,0,1]]` | 2 | Two provinces: {0,1} and {2} |
| `[[1,0,0],[0,1,0],[0,0,1]]` | 3 | Three provinces (all isolated) |
| `[[1]]` | 1 | Single city = single province |
| `[[1,0,0,1],[0,1,1,0],[0,1,1,1],[1,0,1,1]]` | 1 | All cities connected into one province |
| `[]` | 0 | Empty matrix = no provinces |

## Algorithm

This solution uses **Depth-First Search (DFS)** to find connected components:

1. Initialize a `visited` array to track which cities have been explored
2. Iterate through each city:
   - If the city hasn't been visited, it's the start of a new province
   - Increment the province count
   - Use DFS to mark all connected cities as visited
3. Return the total province count

**Time Complexity:** O(n²) - we may need to check all connections for each city
**Space Complexity:** O(n) - for the visited array and recursion stack

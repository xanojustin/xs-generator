# Design Underground System

## Problem

An underground railway system is keeping track of customer travel times between different stations. The system needs to support three operations:

1. **checkIn** - Records when a customer enters a station at a specific time
2. **checkOut** - Records when a customer leaves a station at a specific time, calculates the travel time from their check-in station
3. **getAverageTime** - Returns the average travel time between a start station and an end station based on all completed trips

This is a classic design interview question that tests:
- Data structure design (how to store check-ins and travel times)
- State management (handling incomplete trips)
- Basic calculations (averages)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/underground-system.xs`):** Contains the solution logic with checkIn, checkOut, and getAverageTime operations

## Function Signature

- **Input:**
  - `operation` (text): The operation to perform - `"checkIn"`, `"checkOut"`, or `"getAverageTime"`
  - `customer_id` (int?): Customer ID for checkIn/checkOut operations
  - `station_name` (text?): Station name for checkIn/checkOut
  - `time` (int?): Time value for checkIn/checkOut (in minutes or any consistent unit)
  - `start_station` (text?): Start station name for getAverageTime
  - `end_station` (text?): End station name for getAverageTime

- **Output:** 
  - Object with `success` (bool), `operation` (text), and operation-specific fields:
    - checkIn: returns `customer_id`
    - checkOut: returns `customer_id`, `travel_time`, `route`
    - getAverageTime: returns `start_station`, `end_station`, `average_time`, `trip_count`

## Test Cases

### Basic/Happy Path Cases

| Input | Expected Output |
|-------|-----------------|
| `{"operation": "checkIn", "customer_id": 45, "station_name": "Leyton", "time": 3}` | `{success: true, operation: "checkIn", customer_id: 45}` |
| `{"operation": "checkOut", "customer_id": 45, "station_name": "Paradise", "time": 8}` | `{success: true, operation: "checkOut", customer_id: 45, travel_time: 5, route: "Leyton->Paradise"}` |
| `{"operation": "getAverageTime", "start_station": "Leyton", "end_station": "Paradise"}` | `{success: true, operation: "getAverageTime", average_time: 5, trip_count: 1}` |

### Edge Cases

| Input | Expected Output |
|-------|-----------------|
| `{"operation": "getAverageTime", "start_station": "NonExistent", "end_station": "Station"}` | `{success: true, average_time: 0, trip_count: 0}` (no trips recorded for this route) |
| `{"operation": "checkIn", "customer_id": 1, "station_name": "A", "time": 0}` | Valid check-in at time 0 |

### Multiple Trips Average

| Sequence | Expected Output |
|----------|-----------------|
| 1. CheckIn customer 1 at A, time 0 | - |
| 2. CheckOut customer 1 at B, time 5 | Travel time: 5 |
| 3. CheckIn customer 2 at A, time 10 | - |
| 4. CheckOut customer 2 at B, time 15 | Travel time: 5 |
| 5. GetAverageTime A→B | `average_time: 5` (5+5)/2 |

## Implementation Notes

The solution uses:
- **Array-based storage** for check-ins and travel times (using XanoScript's `filter` and `find` array filters)
- **Route keys** in format `"startStation->endStation"` to uniquely identify routes
- **Average calculation** as `total_time / trip_count`

Since XanoScript doesn't have a `delete` filter for objects, the implementation uses arrays with `filter` to remove entries (creating new arrays without the filtered elements).
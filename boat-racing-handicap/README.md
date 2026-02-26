# Boat Racing Handicap

## Problem
Calculate corrected racing time for sailboats using the PHRF (Performance Handicap Racing Fleet) Time-on-Time handicap system.

In sailboat racing, boats of different designs and speeds compete against each other using handicap ratings. The PHRF system assigns each boat a rating number — lower numbers indicate faster boats. To determine the winner, each boat's actual elapsed time is adjusted using a time-on-time multiplier to produce a "corrected time." The boat with the lowest corrected time wins.

The PHRF Time-on-Time formula is:
```
Time-on-Time Multiplier = 650 / (550 + PHRF Rating)
Corrected Time = Elapsed Time × Time-on-Time Multiplier
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs representing a typical club racer
- **Function (`function/calculate_handicap.xs`):** Contains the PHRF handicap calculation logic

## Function Signature
- **Input:**
  - `phrf_rating` (int): PHRF rating of the boat, range -500 to 300 (lower is faster)
  - `course_distance` (decimal): Course distance in nautical miles
  - `elapsed_time_seconds` (int): Actual elapsed race time in seconds
  
- **Output:** (object)
  - `phrf_rating`: The input PHRF rating
  - `course_distance`: The input course distance
  - `elapsed_time_seconds`: The input elapsed time
  - `corrected_time_seconds`: Calculated corrected time in seconds (rounded)
  - `time_allowance_seconds`: Difference between corrected and elapsed time
  - `time_on_time_multiplier`: The multiplier used in calculation

## Test Cases

| PHRF Rating | Course Distance (nm) | Elapsed Time (sec) | Expected Corrected Time (sec) | Time Allowance |
|-------------|---------------------|-------------------|------------------------------|----------------|
| 120 | 5.5 | 7200 (2 hours) | ~6696 | ~-504 seconds |
| 0 | 5.5 | 7200 | ~7645 | ~+445 seconds |
| 200 | 5.5 | 7200 | ~6136 | ~-1064 seconds |
| 120 | 5.5 | 0 (start/finish) | 0 | 0 |

### Test Case Details

**Basic case:** A boat with PHRF 120 (moderate club racer) on a 5.5nm course finishing in 2 hours gets a corrected time of ~6696 seconds (about 1 hour 51 minutes), giving it a time allowance of about -504 seconds (8.4 minutes).

**Fast boat (PHRF 0):** A very fast boat gets a time-on-time multiplier > 1.0, meaning its corrected time is longer than its elapsed time, effectively giving slower boats a head start.

**Slow boat (PHRF 200):** A slower cruising boat gets a multiplier < 1.0, meaning its corrected time is shorter than its elapsed time.

**Edge case:** Zero elapsed time should return zero corrected time (no race run).
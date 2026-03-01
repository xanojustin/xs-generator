// Design Underground System - Classic design interview problem
// An underground railway system is keeping track of customer travel times between stations.
// The system supports: check-in, check-out, and getting average travel time between stations.
function "underground-system" {
  description = "Manages subway check-ins/check-outs and calculates average travel times between stations"
  
  input {
    text operation { description = "Operation type: 'checkIn', 'checkOut', or 'getAverageTime'" }
    int? customer_id { description = "Customer ID for checkIn/checkOut operations" }
    text? station_name { description = "Station name for checkIn/checkOut" }
    int? time { description = "Time (in minutes/hours) for checkIn/checkOut" }
    text? start_station { description = "Start station for getAverageTime" }
    text? end_station { description = "End station for getAverageTime" }
  }
  
  stack {
    // Use arrays instead of objects to avoid delete filter issues
    // Pre-populated with test data for demonstration
    var $check_ins { 
      value = [
        { customer_id: 1, station: "A", time: 3 },
        { customer_id: 2, station: "B", time: 6 }
      ]
    }
    
    var $travel_times {
      value = [
        { route: "A->B", total: 7, count: 1 },
        { route: "B->C", total: 5, count: 1 }
      ]
    }
    
    // Handle check-in operation
    conditional {
      if ($input.operation == "checkIn") {
        // Add new check-in to the array
        var $new_checkin {
          value = {
            customer_id: $input.customer_id,
            station: $input.station_name,
            time: $input.time
          }
        }
        var $check_ins {
          value = $check_ins|merge:[$new_checkin]
        }
        var $result { value = { success: true, operation: "checkIn", customer_id: $input.customer_id } }
      }
      
      // Handle check-out operation
      elseif ($input.operation == "checkOut") {
        // Find the check-in record for this customer
        var $customer_checkin {
          value = $check_ins|find:$$.customer_id == $input.customer_id
        }
        
        // Calculate travel time
        var $travel_time { value = $input.time - $customer_checkin.time }
        
        // Build the route key
        var $route_key { value = $customer_checkin.station ~ "->" ~ $input.station_name }
        
        // Find existing route in travel_times
        var $existing_route {
          value = $travel_times|find:$$.route == $route_key
        }
        
        conditional {
          if ($existing_route == null) {
            // First trip on this route - add new entry
            var $new_route {
              value = {
                route: $route_key,
                total: $travel_time,
                count: 1
              }
            }
            var $travel_times {
              value = $travel_times|merge:[$new_route]
            }
          }
          else {
            // Update existing route - filter out old and add updated
            var $updated_route {
              value = {
                route: $route_key,
                total: $existing_route.total + $travel_time,
                count: $existing_route.count + 1
              }
            }
            // Remove old route entry and add updated one
            var $filtered_routes {
              value = $travel_times|filter:$$.route != $route_key
            }
            var $travel_times {
              value = $filtered_routes|merge:[$updated_route]
            }
          }
        }
        
        // Remove customer from check-ins (they've completed their trip)
        var $filtered_checkins {
          value = $check_ins|filter:$$.customer_id != $input.customer_id
        }
        var $check_ins {
          value = $filtered_checkins
        }
        
        var $result { 
          value = { 
            success: true, 
            operation: "checkOut", 
            customer_id: $input.customer_id,
            travel_time: $travel_time,
            route: $route_key
          } 
        }
      }
      
      // Handle getAverageTime operation
      elseif ($input.operation == "getAverageTime") {
        var $route_key { value = $input.start_station ~ "->" ~ $input.end_station }
        var $route_data { value = $travel_times|find:$$.route == $route_key }
        
        conditional {
          if ($route_data == null) {
            // No data for this route yet
            var $result {
              value = {
                success: true,
                operation: "getAverageTime",
                start_station: $input.start_station,
                end_station: $input.end_station,
                average_time: 0,
                trip_count: 0
              }
            }
          }
          else {
            var $avg { value = $route_data.total / $route_data.count }
            
            var $result {
              value = {
                success: true,
                operation: "getAverageTime",
                start_station: $input.start_station,
                end_station: $input.end_station,
                average_time: $avg,
                trip_count: $route_data.count
              }
            }
          }
        }
      }
      
      // Invalid operation
      else {
        var $result {
          value = {
            success: false,
            error: "Invalid operation. Use 'checkIn', 'checkOut', or 'getAverageTime'"
          }
        }
      }
    }
  }
  
  response = $result
}
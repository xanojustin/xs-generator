// Number of Provinces - Graph connected components problem
// Given an n x n matrix where isConnected[i][j] = 1 means city i is connected to city j,
// return the total number of provinces (connected components).
function "countProvinces" {
  description = "Counts the number of provinces (connected components) in a graph"

  input {
    json isConnected { description = "n x n adjacency matrix where 1 means cities are directly connected" }
  }

  stack {
    // Get the number of cities
    var $n { value = ($input.isConnected|count) }

    // Handle empty matrix
    conditional {
      if ($n == 0) {
        return { value = 0 }
      }
    }

    // Track visited cities
    var $visited { value = [] }

    // Initialize visited array with false values
    var $i { value = 0 }
    while ($i < $n) {
      each {
        array.push $visited {
          value = false
        }
        math.add $i { value = 1 }
      }
    }

    // Count of provinces
    var $provinceCount { value = 0 }

    // Visit each city and perform DFS to mark all connected cities
    var $city { value = 0 }
    while ($city < $n) {
      each {
        conditional {
          if (!$visited[$city]) {
            // Found a new province, increment count
            math.add $provinceCount { value = 1 }

            // Perform DFS to mark all cities in this province as visited
            var $stack { value = [$city] }

            while (($stack|count) > 0) {
              each {
                // Pop from stack (get last element)
                array.pop $stack as $currentCity

                conditional {
                  if (!$visited[$currentCity]) {
                    // Mark current city as visited
                    var.update $visited[$currentCity] { value = true }

                    // Find all connected cities and add to stack
                    var $neighbor { value = 0 }
                    while ($neighbor < $n) {
                      each {
                        conditional {
                          if ($input.isConnected[$currentCity][$neighbor] == 1 && !$visited[$neighbor]) {
                            array.push $stack {
                              value = $neighbor
                            }
                          }
                        }
                        math.add $neighbor { value = 1 }
                      }
                    }
                  }
                }
              }
            }
          }
        }
        math.add $city { value = 1 }
      }
    }
  }

  response = $provinceCount
}

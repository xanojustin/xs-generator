function "candy" {
  description = "Distribute candies to children based on ratings. There are n children standing in a line. Each child is assigned a rating value. Give candies to children such that: 1. Each child must have at least one candy, 2. Children with a higher rating get more candies than their neighbors. Return the minimum number of candies needed."
  
  input {
    int[] ratings { description = "Array of ratings for each child" }
  }
  
  stack {
    // Handle empty input
    conditional {
      if (($input.ratings|count) == 0) {
        return { value = 0 }
      }
    }
    
    // Initialize candies array with 1 candy for each child
    var $candies { value = [] }
    for ($input.ratings|count) {
      each as $i {
        var $candies { value = $candies|merge:[1] }
      }
    }
    
    // Left to right pass: if current child has higher rating than left neighbor, give more candies
    for ($input.ratings|count) {
      each as $i {
        conditional {
          if ($i > 0) {
            conditional {
              if ($input.ratings[$i] > $input.ratings[$i - 1]) {
                var.update $candies {
                  value = $candies|set:$i:($candies[$i - 1] + 1)
                }
              }
            }
          }
        }
      }
    }
    
    // Right to left pass: if current child has higher rating than right neighbor, give more candies
    for ($input.ratings|count) {
      each as $idx {
        var $i { value = (($input.ratings|count) - 1) - $idx }
        conditional {
          if ($i < (($input.ratings|count) - 1)) {
            conditional {
              if ($input.ratings[$i] > $input.ratings[$i + 1]) {
                conditional {
                  if ($candies[$i] <= $candies[$i + 1]) {
                    var.update $candies {
                      value = $candies|set:$i:($candies[$i + 1] + 1)
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    // Sum up all candies
    var $total { value = 0 }
    for ($candies|count) {
      each as $i {
        var.update $total { value = $total + $candies[$i] }
      }
    }
  }
  
  response = $total
}

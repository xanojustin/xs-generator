function "format_license_key" {
  description = "Format a license key by grouping characters and inserting dashes"
  input {
    text s { description = "The license key string containing alphanumeric characters and dashes" }
    int k { description = "The number of characters per group" }
  }
  stack {
    // Remove all existing dashes and convert to uppercase
    var $cleaned { value = $input.s|replace:"-":""|to_upper }
    
    // Get the length of the cleaned string
    var $length { value = ($cleaned|count) }
    
    // Calculate the size of the first group (could be smaller)
    var $first_group_size { value = $length % $input.k }
    conditional {
      if ($first_group_size == 0) {
        var.update $first_group_size { value = $input.k }
      }
    }
    
    // Build the result by extracting groups
    var $result { value = "" }
    var $position { value = 0 }
    
    // Add first group (might be smaller if length % k != 0)
    conditional {
      if ($length > 0) {
        var $first_group { value = $cleaned|slice:$position:$first_group_size }
        var.update $result { value = $result ~ $first_group }
        var.update $position { value = $position + $first_group_size }
      }
    }
    
    // Add remaining groups with dashes before each
    while ($position < $length) {
      each {
        var $group { value = $cleaned|slice:$position:$input.k }
        var.update $result { value = $result ~ "-" ~ $group }
        var.update $position { value = $position + $input.k }
      }
    }
  }
  response = $result
}

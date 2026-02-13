function "format_firestore_array" {
  description = "Converts array items to Firestore typed values format"
  input {
    object[] items {
      description = "Array items to convert"
    }
  }
  stack {
    var $values { value = [] }
    
    foreach ($input.items) {
      each as $item {
        conditional {
          // String values
          if ($item|is_text) {
            var $typed_value { value = { stringValue: $item } }
            var.update $values { value = $values|push:$typed_value }
          }
          // Integer values
          elseif ($item|is_int) {
            var $typed_value { value = { integerValue: $item|to_text } }
            var.update $values { value = $values|push:$typed_value }
          }
          // Boolean values
          elseif ($item|is_bool) {
            var $typed_value { value = { booleanValue: $item } }
            var.update $values { value = $values|push:$typed_value }
          }
          // Null values
          elseif ($item|is_null) {
            var $typed_value { value = { nullValue: null } }
            var.update $values { value = $values|push:$typed_value }
          }
          // Object values
          elseif ($item|is_object) {
            function.run "format_firestore_fields" {
              input = { data: $item }
            } as $nested_fields
            var $typed_value { value = { mapValue: { fields: $nested_fields } } }
            var.update $values { value = $values|push:$typed_value }
          }
          // Default to string
          else {
            var $typed_value { value = { stringValue: $item|to_text } }
            var.update $values { value = $values|push:$typed_value }
          }
        }
      }
    }
  }
  response = $values
}

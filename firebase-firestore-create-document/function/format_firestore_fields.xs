function "format_firestore_fields" {
  description = "Converts plain JSON data to Firestore typed fields format"
  input {
    object data {
      description = "Input data to convert"
    }
  }
  stack {
    var $fields { value = {} }
    var $keys { value = $input.data|keys }
    
    foreach ($keys) {
      each as $field_key {
        var $field_value { value = $input.data|get:$field_key }
        conditional {
          if ($field_value|is_text) {
            var $typed_value { value = { stringValue: $field_value } }
          }
          elseif ($field_value|is_int) {
            var $typed_value { value = { integerValue: $field_value|to_text } }
          }
          elseif ($field_value|is_bool) {
            var $typed_value { value = { booleanValue: $field_value } }
          }
          elseif ($field_value|is_null) {
            var $typed_value { value = { nullValue: null } }
          }
          elseif ($field_value|is_array) {
            function.run "format_firestore_array" {
              input = { items: $field_value }
            } as $array_value
            var $typed_value { value = { arrayValue: { values: $array_value } } }
          }
          elseif ($field_value|is_object) {
            function.run "format_firestore_fields" {
              input = { data: $field_value }
            } as $nested_fields
            var $typed_value { value = { mapValue: { fields: $nested_fields } } }
          }
          else {
            var $typed_value { value = { stringValue: $field_value|to_text } }
          }
        }
        var $field_obj { value = {} }
        var.update $field_obj { value = $field_obj|set:$field_key:$typed_value }
        var $new_fields { value = $fields|merge:$field_obj }
        var.update $fields { value = $new_fields }
      }
    }
  }
  response = $fields
}

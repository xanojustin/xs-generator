function "word_search_ii" {
  input {
    text[] board
    text[] words
  }
  stack {
    // Parse the board string array into a 2D array
    var $board_rows { value = $input.board }
    var $num_rows { value = ($board_rows|count) }
    
    // Handle empty board
    conditional {
      if ($num_rows == 0) {
        return { value = [] }
      }
    }
    
    var $num_cols { value = ($board_rows|first|strlen) }
    
    // Build Trie from words for efficient prefix matching
    var $trie { value = {} }
    
    // Iterate over words using foreach/each pattern
    foreach ($input.words) {
      each as $word {
        var $current_node { value = $trie }
        var $chars { value = $word|split:"" }
        
        // Iterate over characters
        foreach ($chars) {
          each as $char {
            // Check if char exists in current node
            conditional {
              if ($current_node|get:$char == null) {
                var $updated_node { value = $current_node|set:$char:{} }
                var.update $current_node { value = $updated_node }
              }
            }
            var.update $current_node { value = $current_node|get:$char }
          }
        }
        
        // Mark end of word
        var.update $current_node { value = $current_node|set:"word":$word }
        var $word_marker { value = $current_node }
      }
    }
    
    // Result set to store found words
    var $found_words { value = [] }
    
    // DFS from each cell
    var $row { value = 0 }
    while ($row < $num_rows) {
      each {
        var $col { value = 0 }
        while ($col < $num_cols) {
          each {
            // Get the character at current position
            var $current_row_str { value = $board_rows[$row] }
            var $current_char { value = $current_row_str|substr:$col:($col + 1) }
            
            // Check if any word starts with this character
            conditional {
              if ($trie|get:$current_char != null) {
                // Initialize DFS stack with starting position
                var $dfs_stack {
                  value = [
                    {
                      r: $row,
                      c: $col,
                      node: $trie|get:$current_char,
                      path: ($row|to_text) ~ "," ~ ($col|to_text),
                      word: $current_char
                    }
                  ]
                }
                
                // DFS using iterative approach with stack
                while (($dfs_stack|count) > 0) {
                  each {
                    var $stack_size { value = $dfs_stack|count }
                    var $current { value = $dfs_stack[($stack_size - 1)] }
                    var $new_stack { value = $dfs_stack|slice:0:(-1) }
                    var.update $dfs_stack { value = $new_stack }
                    
                    var $cr { value = $current|get:"r" }
                    var $cc { value = $current|get:"c" }
                    var $cnode { value = $current|get:"node" }
                    var $cpath { value = $current|get:"path" }
                    var $cword { value = $current|get:"word" }
                    
                    // Check if we found a complete word
                    conditional {
                      if ($cnode|get:"word" != null) {
                        var $found_word { value = $cnode|get:"word" }
                        // Add to found words if not already there
                        conditional {
                          if (!($found_words|contains:$found_word)) {
                            var $updated_found { value = $found_words|merge:[$found_word] }
                            var.update $found_words { value = $updated_found }
                          }
                        }
                      }
                    }
                    
                    // Explore neighbors: up, down, left, right
                    // Up
                    conditional {
                      if ($cr > 0) {
                        var $nr { value = $cr - 1 }
                        var $nc { value = $cc }
                        var $npath { value = ($nr|to_text) ~ "," ~ ($nc|to_text) }
                        var $nrow_str { value = $board_rows[$nr] }
                        var $nchar { value = $nrow_str|substr:$nc:($nc + 1) }
                        
                        conditional {
                          if ($cnode|get:$nchar != null && !($cpath|contains:$npath)) {
                            var $new_item {
                              value = {
                                r: $nr,
                                c: $nc,
                                node: $cnode|get:$nchar,
                                path: $cpath ~ ";" ~ $npath,
                                word: $cword ~ $nchar
                              }
                            }
                            var $updated_stack { value = $dfs_stack|merge:[$new_item] }
                            var.update $dfs_stack { value = $updated_stack }
                          }
                        }
                      }
                    }
                    
                    // Down
                    conditional {
                      if (($cr + 1) < $num_rows) {
                        var $nr { value = $cr + 1 }
                        var $nc { value = $cc }
                        var $npath { value = ($nr|to_text) ~ "," ~ ($nc|to_text) }
                        var $nrow_str { value = $board_rows[$nr] }
                        var $nchar { value = $nrow_str|substr:$nc:($nc + 1) }
                        
                        conditional {
                          if ($cnode|get:$nchar != null && !($cpath|contains:$npath)) {
                            var $new_item {
                              value = {
                                r: $nr,
                                c: $nc,
                                node: $cnode|get:$nchar,
                                path: $cpath ~ ";" ~ $npath,
                                word: $cword ~ $nchar
                              }
                            }
                            var $updated_stack { value = $dfs_stack|merge:[$new_item] }
                            var.update $dfs_stack { value = $updated_stack }
                          }
                        }
                      }
                    }
                    
                    // Left
                    conditional {
                      if ($cc > 0) {
                        var $nr { value = $cr }
                        var $nc { value = $cc - 1 }
                        var $npath { value = ($nr|to_text) ~ "," ~ ($nc|to_text) }
                        var $nrow_str { value = $board_rows[$nr] }
                        var $nchar { value = $nrow_str|substr:$nc:($nc + 1) }
                        
                        conditional {
                          if ($cnode|get:$nchar != null && !($cpath|contains:$npath)) {
                            var $new_item {
                              value = {
                                r: $nr,
                                c: $nc,
                                node: $cnode|get:$nchar,
                                path: $cpath ~ ";" ~ $npath,
                                word: $cword ~ $nchar
                              }
                            }
                            var $updated_stack { value = $dfs_stack|merge:[$new_item] }
                            var.update $dfs_stack { value = $updated_stack }
                          }
                        }
                      }
                    }
                    
                    // Right
                    conditional {
                      if (($cc + 1) < $num_cols) {
                        var $nr { value = $cr }
                        var $nc { value = $cc + 1 }
                        var $npath { value = ($nr|to_text) ~ "," ~ ($nc|to_text) }
                        var $nrow_str { value = $board_rows[$nr] }
                        var $nchar { value = $nrow_str|substr:$nc:($nc + 1) }
                        
                        conditional {
                          if ($cnode|get:$nchar != null && !($cpath|contains:$npath)) {
                            var $new_item {
                              value = {
                                r: $nr,
                                c: $nc,
                                node: $cnode|get:$nchar,
                                path: $cpath ~ ";" ~ $npath,
                                word: $cword ~ $nchar
                              }
                            }
                            var $updated_stack { value = $dfs_stack|merge:[$new_item] }
                            var.update $dfs_stack { value = $updated_stack }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
            
            var.update $col { value = $col + 1 }
          }
        }
        var.update $row { value = $row + 1 }
      }
    }
    
    var $result { value = $found_words }
  }
  response = $result
}

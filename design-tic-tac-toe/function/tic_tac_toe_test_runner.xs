function "tic_tac_toe_test_runner" {
  description = "Run test cases for Tic-Tac-Toe game"
  input {
  }
  stack {
    // Initialize 3x3 game
    function.run "tic_tac_toe" {
      input = {
        operation: "init",
        n: 3
      }
    } as $game
    
    debug.log { value = "=== Test 1: Initialize 3x3 Board ===" }
    debug.log { value = "Board: " ~ ($game.board|json_encode) }
    debug.log { value = "Current player: " ~ ($game.current_player|to_text) }
    debug.log { value = "Expected: Player 1 starts" }
    
    // Test 2: Player 1 moves to (0, 0)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $game.board,
        current_player: $game.current_player,
        n: $game.n,
        player: 1,
        row: 0,
        col: 0
      }
    } as $move1
    
    debug.log { value = "=== Test 2: Player 1 moves to (0,0) ===" }
    debug.log { value = "Board: " ~ ($move1.board|json_encode) }
    debug.log { value = "Winner: " ~ ($move1.winner|to_text) }
    debug.log { value = "Next player: " ~ ($move1.current_player|to_text) }
    debug.log { value = "Expected: No winner yet, Player 2's turn" }
    
    // Test 3: Player 2 moves to (1, 1)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $move1.board,
        current_player: $move1.current_player,
        n: $move1.n,
        player: 2,
        row: 1,
        col: 1
      }
    } as $move2
    
    debug.log { value = "=== Test 3: Player 2 moves to (1,1) ===" }
    debug.log { value = "Board: " ~ ($move2.board|json_encode) }
    
    // Test 4: Player 1 moves to (0, 1)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $move2.board,
        current_player: $move2.current_player,
        n: $move2.n,
        player: 1,
        row: 0,
        col: 1
      }
    } as $move3
    
    debug.log { value = "=== Test 4: Player 1 moves to (0,1) ===" }
    debug.log { value = "Board: " ~ ($move3.board|json_encode) }
    
    // Test 5: Player 2 moves to (2, 2)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $move3.board,
        current_player: $move3.current_player,
        n: $move3.n,
        player: 2,
        row: 2,
        col: 2
      }
    } as $move4
    
    debug.log { value = "=== Test 5: Player 2 moves to (2,2) ===" }
    debug.log { value = "Board: " ~ ($move4.board|json_encode) }
    
    // Test 6: Player 1 wins with horizontal row (0, 2)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $move4.board,
        current_player: $move4.current_player,
        n: $move4.n,
        player: 1,
        row: 0,
        col: 2
      }
    } as $winning_move
    
    debug.log { value = "=== Test 6: Player 1 wins (horizontal) ===" }
    debug.log { value = "Board: " ~ ($winning_move.board|json_encode) }
    debug.log { value = "Winner: " ~ ($winning_move.winner|to_text) }
    debug.log { value = "Game over: " ~ ($winning_move.game_over|to_text) }
    debug.log { value = "Expected: Player 1 wins!" }
    
    // Test 7: Initialize new game for vertical win test
    function.run "tic_tac_toe" {
      input = {
        operation: "init",
        n: 3
      }
    } as $game2
    
    // Moves for vertical win: Player 1 at (0,0), (1,0), (2,0)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $game2.board,
        current_player: $game2.current_player,
        n: $game2.n,
        player: 1,
        row: 0,
        col: 0
      }
    } as $v1
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $v1.board,
        current_player: $v1.current_player,
        n: $v1.n,
        player: 2,
        row: 0,
        col: 1
      }
    } as $v2
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $v2.board,
        current_player: $v2.current_player,
        n: $v2.n,
        player: 1,
        row: 1,
        col: 0
      }
    } as $v3
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $v3.board,
        current_player: $v3.current_player,
        n: $v3.n,
        player: 2,
        row: 1,
        col: 1
      }
    } as $v4
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $v4.board,
        current_player: $v4.current_player,
        n: $v4.n,
        player: 1,
        row: 2,
        col: 0
      }
    } as $v5
    
    debug.log { value = "=== Test 7: Player 1 wins (vertical) ===" }
    debug.log { value = "Board: " ~ ($v5.board|json_encode) }
    debug.log { value = "Winner: " ~ ($v5.winner|to_text) }
    debug.log { value = "Expected: Player 1 wins!" }
    
    // Test 8: Diagonal win test
    function.run "tic_tac_toe" {
      input = {
        operation: "init",
        n: 3
      }
    } as $game3
    
    // Moves for diagonal win: (0,0), (1,1), (2,2)
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $game3.board,
        current_player: $game3.current_player,
        n: $game3.n,
        player: 1,
        row: 0,
        col: 0
      }
    } as $d1
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $d1.board,
        current_player: $d1.current_player,
        n: $d1.n,
        player: 2,
        row: 0,
        col: 1
      }
    } as $d2
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $d2.board,
        current_player: $d2.current_player,
        n: $d2.n,
        player: 1,
        row: 1,
        col: 1
      }
    } as $d3
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $d3.board,
        current_player: $d3.current_player,
        n: $d3.n,
        player: 2,
        row: 0,
        col: 2
      }
    } as $d4
    
    function.run "tic_tac_toe" {
      input = {
        operation: "move",
        board: $d4.board,
        current_player: $d4.current_player,
        n: $d4.n,
        player: 1,
        row: 2,
        col: 2
      }
    } as $d5
    
    debug.log { value = "=== Test 8: Player 1 wins (diagonal) ===" }
    debug.log { value = "Board: " ~ ($d5.board|json_encode) }
    debug.log { value = "Winner: " ~ ($d5.winner|to_text) }
    debug.log { value = "Expected: Player 1 wins!" }
    
    debug.log { value = "=== All Tests Complete ===" }
    
    var $result {
      value = {
        success: true,
        final_horizontal_test: $winning_move,
        final_vertical_test: $v5,
        final_diagonal_test: $d5
      }
    }
  }
  response = $result
}
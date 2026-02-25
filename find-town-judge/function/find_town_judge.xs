function "find_town_judge" {
  description = "Find the town judge given trust relationships"
  input {
    int n
    json trust
  }
  stack {
    // Handle edge case: if only 1 person and no trust relationships, they are the judge
    var $judge { value = -1 }
    
    conditional {
      if ($input.n == 1 && ($input.trust|count) == 0) {
        var.update $judge { value = 1 }
      }
      else {
        // Initialize trust scores array (index 0 unused, people are 1-indexed)
        var $trust_scores { value = [] }
        for ($input.n) {
          each as $i {
            var.update $trust_scores { value = $trust_scores ~ [0] }
          }
        }

        // Process each trust relationship
        // trust[i] = [a, b] means person a trusts person b
        // So a loses trust score, b gains trust score
        foreach ($input.trust) {
          each as $relation {
            var $a { value = $relation|first }
            var $b { value = $relation|last }
            
            // Person a trusts someone, so decrease their score
            var $a_score { value = ($trust_scores|get:$a) - 1 }
            var.update $trust_scores { value = $trust_scores|set:$a:$a_score }
            
            // Person b is trusted, so increase their score
            var $b_score { value = ($trust_scores|get:$b) + 1 }
            var.update $trust_scores { value = $trust_scores|set:$b:$b_score }
          }
        }

        // Find the judge: person with trust score == n - 1
        // (trusted by everyone else, trusts nobody)
        for ($input.n) {
          each as $person {
            // person index is 0-based in loop, but people are 1-indexed
            var $person_idx { value = $person + 1 }
            var $score { value = $trust_scores|get:$person_idx }
            conditional {
              if ($score == ($input.n - 1)) {
                var.update $judge { value = $person_idx }
              }
            }
          }
        }
      }
    }
  }
  response = $judge
}

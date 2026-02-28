function "atbash_cipher" {
  description = "Encodes or decodes text using the Atbash cipher - a substitution cipher that replaces each letter with its mirror in the alphabet (a↔z, b↔y, etc.)"
  input {
    text text filters=trim
  }
  stack {
    // Handle empty input
    conditional {
      if (($input.text|strlen) == 0) {
        return { value = "" }
      }
    }

    // Create the Atbash mapping object
    var $mapping {
      value = {
        a: "z", b: "y", c: "x", d: "w", e: "v", f: "u",
        g: "t", h: "s", i: "r", j: "q", k: "p", l: "o",
        m: "n", n: "m", o: "l", p: "k", q: "j", r: "i",
        s: "h", t: "g", u: "f", v: "e", w: "d", x: "c",
        y: "b", z: "a"
      }
    }

    var $result { value = "" }
    var $chars { value = $input.text|to_lower|split:"" }

    foreach ($chars) {
      each as $char {
        var $mapped { value = $mapping|get:$char }

        conditional {
          if ($mapped != null) {
            // Letter found in mapping - use transformed value
            var.update $result { value = $result ~ $mapped }
          }
          else {
            // Not a letter (digit, space, punctuation) - keep as-is
            var.update $result { value = $result ~ $char }
          }
        }
      }
    }
  }
  response = $result
}

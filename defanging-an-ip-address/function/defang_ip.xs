function "defang_ip" {
  description = "Defangs an IP address by replacing all dots with [.], useful for safely displaying IP addresses"
  input {
    text address { description = "The IP address to defang (e.g., '1.1.1.1')" }
  }
  stack {
    var $defanged {
      value = $input.address|replace:".":"[.]"
    }
  }
  response = $defanged
}

run.job "License Key Formatting Test" {
  main = {
    name: "format_license_key"
    input: {
      s: "5F3Z-2e-9-w"
      k: 4
    }
  }
}

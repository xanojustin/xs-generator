run.job "Send Lob Postcard" {
  main = {
    name: "send_postcard"
    input: {
      to_name: "Jane Doe"
      to_address_line1: "123 Main Street"
      to_city: "San Francisco"
      to_state: "CA"
      to_zip: "94105"
      to_country: "US"
      from_name: "Acme Corporation"
      from_address_line1: "456 Market Street"
      from_city: "San Francisco"
      from_state: "CA"
      from_zip: "94103"
      from_country: "US"
      front_html: "<html><body style='margin:0;padding:0;'><div style='width:6.25in;height:4.25in;background:linear-gradient(135deg,#667eea 0%,#764ba2 100%);display:flex;align-items:center;justify-content:center;color:white;font-family:Arial,sans-serif;'><div style='text-align:center;'><h1 style='font-size:48px;margin:0;'>Hello!</h1><p style='font-size:24px;'>Thanks for being awesome</p></div></div></body></html>"
      back_html: "<html><body style='margin:0;padding:0.5in;font-family:Arial,sans-serif;'><h2>Greetings from Acme!</h2><p>This postcard was sent via the Lob API using XanoScript.</p><p>Hope you're having a great day!</p><hr><p style='font-size:12px;color:#666;'>Sent with ❤️ from Xano</p></body></html>"
      size: "4x6"
      use_test_mode: true
    }
  }
  env = ["LOB_TEST_API_KEY", "LOB_LIVE_API_KEY"]
}

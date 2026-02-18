run.job "Send Lob Postcard" {
  main = {
    name: "send_postcard"
    input: {
      to_name: "John Doe"
      to_address_line1: "123 Main Street"
      to_city: "San Francisco"
      to_state: "CA"
      to_zip: "94102"
      front_image_url: "https://example.com/postcard-front.jpg"
      back_message: "Hello from Xano! This postcard was sent via the Lob API using XanoScript."
    }
  }
  env = ["LOB_API_KEY"]
}

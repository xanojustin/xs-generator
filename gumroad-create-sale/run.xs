run.job "Gumroad Create Sale" {
  main = {
    name: "gumroad_create_sale"
    input: {
      product_id: ""
      email: ""
      price: 0
      offer_code: ""
    }
  }
  env = ["gumroad_access_token"]
}

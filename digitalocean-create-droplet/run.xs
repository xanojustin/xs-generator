run.job "Create DigitalOcean Droplet" {
  main = {
    name: "create_droplet"
    input: {
      name: "my-droplet"
      region: "nyc3"
      size: "s-1vcpu-1gb"
      image: "ubuntu-24-04-x64"
    }
  }
  env = ["digitalocean_api_token"]
}

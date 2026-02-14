# DigitalOcean Create Droplet

This Xano Run Job creates a new DigitalOcean Droplet (virtual machine) via the DigitalOcean API.

## What It Does

Creates a cloud server (droplet) on DigitalOcean with specified configuration including name, region, size, and operating system image.

## Required Environment Variables

| Variable | Description |
|----------|-------------|
| `digitalocean_api_token` | Your DigitalOcean Personal Access Token (get one at https://cloud.digitalocean.com/account/api/tokens) |

## Input Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `name` | text | `"my-droplet"` | Name for your new droplet |
| `region` | text | `"nyc3"` | Region slug (e.g., `nyc3`, `sfo3`, `ams3`, `sgp1`) |
| `size` | text | `"s-1vcpu-1gb"` | Size slug (e.g., `s-1vcpu-1gb`, `s-2vcpu-2gb`, `s-4vcpu-8gb`) |
| `image` | text | `"ubuntu-24-04-x64"` | Image/OS slug (e.g., `ubuntu-24-04-x64`, `debian-12-x64`, `docker-20-04`) |

## Usage

### Run with default settings
```bash
xano run run.xs
```

### Run with custom settings
Modify the `input` block in `run.xs` with your desired configuration:

```xs
run.job "Create DigitalOcean Droplet" {
  main = {
    name: "create_droplet"
    input: {
      name: "production-server"
      region: "sfo3"
      size: "s-4vcpu-8gb"
      image: "ubuntu-24-04-x64"
    }
  }
  env = ["digitalocean_api_token"]
}
```

## Response

On success, returns:
```json
{
  "success": true,
  "message": "Droplet created successfully",
  "droplet": {
    "id": 123456789,
    "name": "my-droplet",
    "memory": 1024,
    "vcpus": 1,
    "disk": 25,
    "region": {
      "slug": "nyc3",
      "name": "New York 3"
    },
    "status": "new",
    "created_at": "2026-02-14T13:15:00Z"
  }
}
```

## Common Region Slugs

- `nyc1`, `nyc3` - New York
- `sfo2`, `sfo3` - San Francisco
- `ams3` - Amsterdam
- `sgp1` - Singapore
- `lon1` - London
- `fra1` - Frankfurt
- `tor1` - Toronto
- `blr1` - Bangalore

## Common Size Slugs

- `s-1vcpu-1gb` - 1 vCPU, 1GB RAM, 25GB SSD ($6/month)
- `s-2vcpu-2gb` - 2 vCPUs, 2GB RAM, 60GB SSD ($18/month)
- `s-2vcpu-4gb` - 2 vCPUs, 4GB RAM, 80GB SSD ($24/month)
- `s-4vcpu-8gb` - 4 vCPUs, 8GB RAM, 160GB SSD ($48/month)

## Common Image Slugs

- `ubuntu-24-04-x64` - Ubuntu 24.04 LTS
- `ubuntu-22-04-x64` - Ubuntu 22.04 LTS
- `debian-12-x64` - Debian 12
- `fedora-40-x64` - Fedora 40
- `docker-20-04` - Docker on Ubuntu 20.04

## DigitalOcean API Reference

- https://docs.digitalocean.com/reference/api/api-reference/#operation/droplets_create

## Files

- `run.xs` - Run job configuration
- `function/create_droplet.xs` - Function that calls DigitalOcean API

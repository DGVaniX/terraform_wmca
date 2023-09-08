variable "ports_list" {
  description = "Map of ports to open"
  type        = map(object({
    name     = string
    port     = number
    protocol = string
  }))
  default = {
    http = {
      name     = "http",
      port     = 80,
      protocol = "tcp"
    },
    https = {
      name     = "https",
      port     = 443,
      protocol = "tcp"
    },
    ssh = {
      name     = "ssh",
      port     = 22,
      protocol = "tcp"
    }
  }
}
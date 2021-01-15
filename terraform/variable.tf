variable "region" {
  default = "us-west-2"
}

variable "sub_domain" {
  description = "set of domain names for route53"
  default     = ["blog.d3v0ps.com.au"]
}

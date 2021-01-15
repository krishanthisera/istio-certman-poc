resource "aws_route53_zone" "zone" {
  name = "d3v0ps.com.au"
  tags = {
    Environment = "dev"
  }
}


# Uncomment after deploy the ISTIO
# resource "aws_route53_record" "deployments_subdomains" {
#   for_each = toset(var.sub_domain)
#   zone_id  = aws_route53_zone.zone.zone_id
#   name     = each.key
#   type     = "CNAME"
#   ttl      = "500"
#   records  = ["${data.kubernetes_service.ingress_gateway.load_balancer_ingress.0.hostname}"]
# }
resource "aws_route53_zone" "zone" {
  name = "d3v0ps.com.au"
  tags = {
    Environment = "dev"
  }
}



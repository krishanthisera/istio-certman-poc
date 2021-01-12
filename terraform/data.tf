data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

data "aws_availability_zones" "available" {
  //all_availability_zones = true
}


# Uncomment after deploy the ISTIO
# data "kubernetes_service" "ingress_gateway" {
#   metadata {
#     name = "istio-ingressgateway"
#     namespace = "istio-system"
#   }

# }



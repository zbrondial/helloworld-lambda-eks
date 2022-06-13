
data "aws_eks_cluster_auth" "cluster_auth" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  alias                  = "eks"
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  #   token                  = module.eks.aws_eks_cluster_auth.aws_iam_authenticator.token
  token = data.aws_eks_cluster_auth.cluster_auth.token
  #   load_config_file       = false
}

module "alb_ingress_controller" {
  source  = "iplabs/alb-ingress-controller/kubernetes"
  version = "3.1.0"

  providers = {
    kubernetes = "kubernetes.eks"
  }

  k8s_cluster_type = "eks"
  k8s_namespace    = "kube-system"

  aws_region_name  = local.aws_region
  k8s_cluster_name = module.eks.cluster_id
}
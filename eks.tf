### Reference
### https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest
### https://registry.terraform.io/modules/iplabs/alb-ingress-controller/kubernetes/latest
### https://github.com/kubernetes-sigs/aws-load-balancer-controller
### https://kubernetes.io/docs/concepts/services-networking/ingress/

# solution https://github.com/terraform-aws-modules/terraform-aws-eks/issues/1234

# For 
# ╷
# │ Error: Kubernetes cluster unreachable: invalid configuration: no configuration has been provided, try setting KUBERNETES_MASTER environment variable
# │ 


module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"
  #   version         = "17.24.0"
  cluster_name    = local.cluster_name
  cluster_version = "1.21"
  subnet_ids      = module.vpc.public_subnets
  cluster_addons = {
    coredns = {
      resolve_conflicts = "OVERWRITE"
    }
    kube-proxy = {}
    vpc-cni = {
      resolve_conflicts = "OVERWRITE"
    }
  }
  vpc_id                          = module.vpc.vpc_id
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  # Self Managed Node Group(s)
  self_managed_node_group_defaults = {
    instance_type                          = "t3.small"
    update_launch_template_default_version = true
    iam_role_additional_policies = [
      "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    ]
  }

  self_managed_node_groups = {
    one = {
      name         = "mixed-1"
      max_size     = 1
      desired_size = 1

      use_mixed_instances_policy = true
      mixed_instances_policy = {
        instances_distribution = {
          on_demand_base_capacity                  = 0
          on_demand_percentage_above_base_capacity = 10
          spot_allocation_strategy                 = "capacity-optimized"
        }

        override = [
          {
            instance_type     = "t3.small"
            weighted_capacity = "1"
          },
          {
            instance_type     = "t3.medium"
            weighted_capacity = "1"
          },
        ]
      }
    }
  }

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    disk_size      = 50
    instance_types = ["t3.small"]
  }

  eks_managed_node_groups = {
    blue = {}
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 2

      instance_types = ["t3.small"]
      capacity_type  = "SPOT"
    }
  }

}



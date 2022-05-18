resource "aws_eks_fargate_profile" "observability" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-aws-observability"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "aws-observability"
  }
}

resource "aws_eks_fargate_profile" "bauducco-br" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-bauducco-br"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "bauducco-br"
  }
}

resource "aws_eks_fargate_profile" "bimbo" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-bimbo"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "bimbo-br"
  }
}

resource "aws_eks_fargate_profile" "bimbo-las" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-bimbo-las"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "bimbo-las"
  }
}

resource "aws_eks_fargate_profile" "bimbo-pe" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-bimbo-pe"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "bimbo-pe"
  }
}

resource "aws_eks_fargate_profile" "bocadeli-gua" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-bocadeli-gua"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "bocadeli-gua"
  }
}

resource "aws_eks_fargate_profile" "brf" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-brf"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "brf"
  }
}

resource "aws_eks_fargate_profile" "cnd-rep" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-cnd-rep"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "cnd-rep"
  }
}

resource "aws_eks_fargate_profile" "gerdau-br" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-gerdau-br"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "gerdau-br"
  }
}

resource "aws_eks_fargate_profile" "grupok" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-grupok"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "grupok"
  }
}

resource "aws_eks_fargate_profile" "heineken-br" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-heineken-br"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "heineken-br"
  }
}

resource "aws_eks_fargate_profile" "heineken-mx" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-heineken-mx"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "heineken-mx"
  }
}

resource "aws_eks_fargate_profile" "herdez" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-herdez"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "fp-herdez"
  }
}

resource "aws_eks_fargate_profile" "kraft-br" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-kraft-br"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "kraft-br"
  }
}

resource "aws_eks_fargate_profile" "mdcs" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mdcs"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mdcs"
  }
}

resource "aws_eks_fargate_profile" "mdcs-routing-portal" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mdcs-routing-portal"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mdcs-routing-portaldcs"
  }
}

resource "aws_eks_fargate_profile" "metabase" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-metabase"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "metabase"
  }
}

resource "aws_eks_fargate_profile" "minerva-br" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-minerva-br"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "minerva-br"
  }
}

resource "aws_eks_fargate_profile" "mobile-portal" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mobile-portal"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mobile-portal"
  }
}

resource "aws_eks_fargate_profile" "moderna" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-moderna"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "moderna"
  }
}

resource "aws_eks_fargate_profile" "moderna-rep" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-moderna-rep"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "moderna-rep"
  }
}

resource "aws_eks_fargate_profile" "mondelez-agencia-arg" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mondelez-agencia-arg"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mondelez-agencia-arg"
  }
}

resource "aws_eks_fargate_profile" "mondelez-agencia-chl" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mondelez-agencia-chl"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mondelez-agencia-chl"
  }
}

resource "aws_eks_fargate_profile" "mondelez-arg" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mondelez-arg"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mondelez-arg"
  }
}

resource "aws_eks_fargate_profile" "mondelez-ch" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mondelez-ch"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mondelez-ch"
  }
}

resource "aws_eks_fargate_profile" "mondelez-co" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mondelez-co"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mondelez-co"
  }
}

resource "aws_eks_fargate_profile" "mondelez-pe" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-mondelez-pe"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "mondelez-pe"
  }
}

resource "aws_eks_fargate_profile" "msd" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-msd"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "msd"
  }
}

resource "aws_eks_fargate_profile" "pepsico-mx" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-pepsico-mx"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "pepsico-mexico"
  }
}

resource "aws_eks_fargate_profile" "prevenda" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-prevenda"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "prevenda"
  }
}

resource "aws_eks_fargate_profile" "retail-credit" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-retail-credit"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "retail-credit"
  }
}

resource "aws_eks_fargate_profile" "sgc2" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-sgc2"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "sgc2"
  }
}

resource "aws_eks_fargate_profile" "standard-mobile" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-standard-mobile"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "standard-mobile"
  }
}

resource "aws_eks_fargate_profile" "standard-web" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-standard-web"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "standard-web"
  }
}

resource "aws_eks_fargate_profile" "wtm-migration-console" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-wtm-migration-console"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "wtm-migration-console"
  }
}

resource "aws_eks_fargate_profile" "wtm-report" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-wtm-report"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "wtm-report"
  }
}

resource "aws_eks_fargate_profile" "wtm-web" {
  cluster_name           = module.eks.cluster_name
  fargate_profile_name   = "fp-wtm-web"
  pod_execution_role_arn = data.aws_iam_role.profile.arn
  subnet_ids             = module.vpc.private_subnet_id

  selector {
    namespace = "wtm-web"
  }
}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  depends_on = [aws_eks_cluster.my-eks-cluster]
  name = aws_eks_cluster.my-eks-cluster.name
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.aws_eks_cluster.cluster.name
}

data "tls_certificate" "eks_cluster" {
  depends_on = [aws_eks_cluster.my-eks-cluster]
  url = data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer
}

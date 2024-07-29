# Création du Cluster EKS
resource "aws_eks_cluster" "my-eks-cluster" {
  name  = "my-eks-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.private[*].id
  }

  version = "1.30"
}

# Rôle IAM pour le cluster EKS
resource "aws_iam_role" "eks_cluster_role" {
  name   = "eks_cluster_role"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_cluster_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type  = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role  = aws_iam_role.eks_cluster_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role = aws_iam_role.eks_cluster_role.name
}

#création des nodes eks a rajouter ici cordialement ##

# Rôle IAM pour les nœuds EKS
resource "aws_iam_role" "eks_node_role" {
  name  = "eks_node_role"
  assume_role_policy = data.aws_iam_policy_document.eks_node_assume_role_policy.json
}

data "aws_iam_policy_document" "eks_node_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

# Attacher les politiques IAM nécessaires pour les nœuds EKS
resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_node_AmazonSSMManagedInstanceCore" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role = aws_iam_role.eks_node_role.name
}

# Modèle de lancement pour les instances EKS
resource "aws_launch_template" "eks_node" {
  name_prefix  = "eks-node-"
  image_id  = var.AmiId
  instance_type = var.InstanceType

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [aws_security_group.eks_node_group_sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}
#############################################################
resource "aws_autoscaling_group" "eks_asg" {
  launch_template {
    id  = aws_launch_template.eks_node.id
    version = "$Latest"
  }

  vpc_zone_identifier = aws_subnet.public[*].id

  tag {
    key  = "Name"
    value = "vm"
    propagate_at_launch = true
  }

  desired_capacity  = 3
  max_size  = 4
  min_size  = 1
  health_check_type = "EC2"
  health_check_grace_period = "300"
}


################################################################
resource "aws_eks_node_group" "managed_node_group" {
  cluster_name = aws_eks_cluster.my-eks-cluster.name
  node_group_name = "my-managed-node-group"
  node_role_arn  = aws_iam_role.eks_node_role.arn
  subnet_ids  = aws_subnet.private[*].id

  scaling_config {
    desired_size = 3
    max_size = 6
    min_size = 1
  }

  instance_types = ["t3.medium"]

  remote_access {
    ec2_ssh_key = var.ec2_ssh_key
  }

  tags = {
    Name = "my-node-group"
  }
}



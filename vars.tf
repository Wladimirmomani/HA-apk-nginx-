variable "VpcName" {
  default = "PA-tf-vpc-main"
  type  = string
  description = "Name of VPC created by Terraform"
}

variable "VpcCidr" {
  default = "10.0.0.0/16"
  type  = string
  description = "CIDR block for the VPC"
}

variable "PublicSubnetName" {
  default  = "PA-tf-subnet-public"
  type  = string
  description = "Name prefix for public subnets"
}

variable "PublicSubnetCidr" {
  default = "10.0.1.0/24"
  type   = string
  description = "CIDR block for public subnets"
}

variable "PrivateSubnetName" {
  default  = "PA-tf-subnet-private"
  type  = string
  description = "Name prefix for private subnets"
}

variable "PrivateSubnetCidr" {
  default  = "10.0.2.0/24"
  type   = string
  description = "CIDR block for private subnets"
}

variable "CidrInternet" {
  default  = "0.0.0.0/0"
  type  = string
  description = "CIDR block for internet access"
}

variable "PublicRTName" {
  default  = "PA-tf-route-table-public"
  type  = string
  description = "Name for public route table"
}

variable "PrivateRTName" {
  default = "PA-tf-route-table-private"
  type   = string
  description = "Name for private route table"
}

variable "IGWName" {
  default  = "PA-tf-igw"
  type  = string
  description = "Name for Internet Gateway"
}

variable "NGWName" {
  default = "PA-tf-ngw"
  type  = string
  description = "Name for NAT Gateway"
}

variable "InstanceType" {
  default = "t2.micro"
  type = string
  description = "EC2 instance type"
}

variable "InstanceName" {
  default  = "PA-node-linux"
  type   = string
  description = "Name for EC2 instance"
}

variable "AmiId" {
  default  = "ami-06935448000742e6b"
  type   = string
  description = "AMI ID for EC2 instance"
}

variable "NodeGroupSecurityGroupName" {
  default = "my-eks-node-group-sg"
  type  = string
  description = "Security group name for EKS node group"
}

variable "NodeGroupIngressPorts" {
  type  = list(number)
  default  = [22, 80, 443]
}

variable "NodeGroupEgressCIDR" {
  default  = "0.0.0.0/0"
  type   = string
  description = "CIDR block for egress traffic"
}

variable "InstancePrefix" {
  default = "vm"
  type  = string
  description = "Prefix for instance names"
}

variable "LbName" {
  description = "Nom du Load Balancer"
  type   = string
  default = "app-lb"
}

variable "TgName" {
  description = "Nom du groupe cible"
  type = string
  default  = "app-tg"
}

variable "ListenerPort" {
  description = "Port pour le listener du Load Balancer"
  type   = number
  default = 443
}

variable "ListenerProtocol" {
  description = "Protocole pour le listener du Load Balancer"
  type  = string
  default  = "HTTPS"
}

variable "CertificateArn" {
  description = "ARN du certificat SSL/TLS pour le Load Balancer"
  type = string
}

variable "DomainName" {
  description = "Nom de domaine pour le certificat SSL/TLS"
  type = string
}

variable "CertValidationMethod" {
  description = "Méthode de validation pour le certificat SSL/TLS"
  type  = string
  default = "DNS"
}

variable "HealthCheckPath" {
  description = "Chemin de vérification de l'état pour le groupe cible"
  type  = string
  default = "/"
}

variable "HealthCheckInterval" {
  description = "Intervalle de vérification de l'état en secondes"
  type  = number
  default  = 30
}

variable "HealthCheckTimeout" {
  description = "Délai d'attente pour la vérification de l'état en secondes"
  type = number
  default = 5
}

variable "HealthCheckHealthyThreshold" {
  description = "Seuil de santé pour une instance en bonne santé"
  type  = number
  default  = 5
}

variable "HealthCheckUnhealthyThreshold" {
  description = "Seuil de santé pour une instance en mauvaise santé"
  type  = number
  default  = 2
}

variable "RedirectHttpToHttps" {
  description = "Activer la redirection de HTTP vers HTTPS"
  type = bool
  default  = true
}

variable "lb_security_group_ids" {
  description = "List of security group IDs for the Load Balancer"
  type        = list(string)
  default     = []
}

variable "ec2_ssh_key" {
  description = "Name of the SSH key to use for EC2 instances"
  type        = string
}

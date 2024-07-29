VpcName = "PA-tf-vpc-main"
VpcCidr = "10.0.0.0/16"
PublicSubnetName = "PA-tf-subnet-public"
PublicSubnetCidr = "10.0.1.0/24"
PrivateSubnetCidr = "10.0.2.0/24"
PrivateSubnetName = "PA-tf-subnet-private"
CidrInternet = "0.0.0.0/0"
PublicRTName = "PA-tf-route-table-public"
PrivateRTName = "PA-tf-route-table-private"
IGWName = "PA-tf-igw"
NGWName = "PA-tf-ngw"
InstanceType = "t2.micro"
InstanceName = "PA-node-linux"
AmiId = "ami-06935448000742e6b"
NodeGroupSecurityGroupName = "my-eks-node-group-sg"
NodeGroupIngressPorts = [22, 80, 443]
NodeGroupEgressCIDR = "0.0.0.0/0"
LbName = "PA-alb"
TgName = "PA-alb-tg"
ListenerPort = 443
ListenerProtocol = "HTTPS"
CertificateArn = "arn:aws:acm:eu-west-1:363822040081:certificate/141fcff5-3bcc-4b46-8bc4-3c4698f712e2"
DomainName = "wadmin.pro"
CertValidationMethod = "DNS"
HealthCheckPath = "/"
HealthCheckInterval = 30
HealthCheckTimeout = 5
HealthCheckHealthyThreshold = 5
HealthCheckUnhealthyThreshold = 2
RedirectHttpToHttps = true
ec2_ssh_key = "pa-key"




# projet

# Déploiement Kubernetes EKS avec SSL et ALB

Ce projet démontre le déploiement d'une application web haute disponibilité sur AWS EKS (Elastic Kubernetes Service) 
en utilisant un Application Load Balancer (ALB)


## Prérequis

- AWS CLI configuré avec les permissions appropriées
- `kubectl` installé et configuré
- Terraform installé
- Domain name valide
- Avoir des connaissances en orchestration

## Vue d'ensemble de l'infrastructure

1. **Cluster EKS** : Un cluster Kubernetes déployé sur plusieurs zones de disponibilité pour assurer une haute disponibilité.
2. **Groupes de nœuds gérés** : Instances EC2 gérées par EKS pour exécuter les pods de l'application.
3. **Déploiement** : Un déploiement Kubernetes pour gérer les réplicas de l'application web.
4. **Service** : Un service Kubernetes de type LoadBalancer pour exposer l'application via un ALB.
5. **Ingress** : Un Ingress Kubernetes pour gérer la terminaison SSL et le routage.
6. **Certificats SSL** : Certificats SSL générés avec Certbot pour sécuriser les communications.

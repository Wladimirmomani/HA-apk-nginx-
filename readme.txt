readme

lancer l'infra complete
mettre en place les fichiers pour l'apk nginx dont deployment.yaml |  ingress.yaml | service.yaml

accéder à k9s sur votre région: aws eks --region eu-west-1 update-kubeconfig --name my-eks-cluster

apply nos services afin de lancer l'apk : 
                                          kubectl apply -f deployment.yaml
                                          kubectl apply -f service.yaml
                                          kubectl apply -f ingress.yaml
                                          


vérifier l'installation de nos services

                                          kubectl get -f service.yaml
                                          kubectl get -f ingress.yaml
                                          kubectl get -f deployment.yaml


 tchéquer les nodes 
                                          kubectl get pods
                                          kubectl get nodes
                                          kubectl get service

tchéquer les config général de kube
                                          kubectl describe service my-app-service
                                          kubectl get endpoints
                                         
acceder à l'APK avec le nom du ALB : 

http://a9a33b3763e0a43d794a06ff130de753-1510809823.eu-west-1.elb.amazonaws.com



 Simulation de la Panne d'un Nœud

 Pour simuler la panne d'un nœud et vérifier la résilience de votre application :

                                        kubectl get nodes

Drainer un Nœud :
                                        kubectl drain <node-name> --ignore-daemonsets --delete-local-data




Observer le Replanification des Pods : Après avoir drainé un nœud, Kubernetes reprogrammera les pods sur les nœuds disponibles.                                       

                                        kubectl get pods -o wide

# istio-certman-poc
Developing POC for ISTIO with Cert-Manager.  The configs and source codes are for "Amazon EKS with ISTIO" POC and not suitable for the production.

*Note that the Terraform implementation required to be optimised (this is quite a static implementation) since the implementation is focused on the maximum readability for learning*  

*In a scenario where you need to scale the EKS. Change the note count.*

# Dependencies
1. Terraform
2. AWS Account

# How to run -- Deployment
1. Clone the repo  
`git clone https://github.com/krishanthisera/istio-certman-poc.git`  
2. cd into the terraform directory and execute terraform plan  
*Please do mind to change the worker group config using [main.tf]*
```sh
terraform init
terraform plan -out=istio.tfplan
```  
Afterwards, grab the name server IP addresses by using the tf-output and configure your domain registrar to point your ROUT53 zone,  
`terraform output name_servers`  
3. Apply terraform plan  
`terraform apply "istio.tfplan`  
4. Configure EKS config  
`terraform output kubectl_config > ~/.kube/config`  

5. Create Istio name space:  
`kubectl create ns istio-system`  
6. Install CRD  
`kubectl apply -f istio-init/istio-crd.yaml --namespace=istio-system`  
7. Install Istio resources  
`kubectl apply -f istio-init/istio-res.yaml --namespace=istio-system`  
8. Verify the LB  
`kubectl get svc -n istio-system`  
9. Uncomment following lines to automate configure the DNS records 
  - route53.tf : line 10 to 17
  - data.tf : line 15 to 21
```sh
    terraform plan -out=istio.tfplan
    terraform apply istio.tfplan
```
10. Create the Cert-Manager Namespace and (enable sidecar injection - optional) 
```sh
kubectl create ns cert-manager  
kubectl label namespace cert-manager istio-injection=enabled
```
11. Install Cert-Manger  
`kubectl apply -f cert-manager/cert-man.yaml`  

# How to run - Ingress Testing
1. Enable ISTIO Proxy(envoy) side car injection and Deploy the demo app  
```sh
kubectl label namespace default istio-injection=enabled
kubectl apply -f demo-app/bookinfo.yaml
```
2. Configure the Gateway and VirtualService - optional  
```sh
    kubectl apply -f demo-app/bookinfo.yaml
    kubectl apply -f demo-app/ingress.yaml # Change the port to port 80 prior to run
```
3. Verify using the browser  
`http://book.d3v0ps.com.au/`  

4. Delete the Gateway resource - optional  
`kubectl delete -f demo-app/ingress.yaml`  

# How to run - Cert-Manager Configs  
1. Create the issuer  
`kubectl apply -f cert-manager-configs/lets-enc-staging-issuer.yaml`  
2. Verify the issuer  
`kubectl describe issuer -n istio-system`  
if issuer is ready  
3. Create `istio-autogenerated-k8s-ingress` to convert ingress objects to ISTIO resources  
`kubectl apply -f cert-manager-configs/istio-autogenerated-k8s-ingress.yaml`  
4. Create the certificate  
`kubectl apply -f cert-manager-configs/book-cert.yaml`  

# How to run - Complete the setup  
1. Rerun the gateway configs for book-info  
`kubectl apply -f demo-app/ingress.yaml`  
2. Test the Connectivity using browser  

# How to run - Production Setup  
1. Create the production issuer  
`kubectl apply -f cert-manager-configs/lets-enc-prod-issuer.yaml`  
2. Verify the issuer  
`kubectl describe  Issuer -n istio-system letsencrypt-prod`  
3. Create a new certificate referring the production issuer  
`kubectl apply -f cert-manager-configs/book-cert-prod.yaml `
4. Test the connectivity using browser

# Configure mTILS strict
1. kubectl apply -f istio-addons/mTLS.yaml

# Install Istio addons
1. install Kaili
`kubectl apply -f istio-addons/kiali.yaml`
2. Use Kiali
`kubectl port-forward svc/kiali 20001:20001 -n istio-system`


[main.tf][https://github.com/krishanthisera/istio-certman-poc/blob/main/terraform/main.tf]




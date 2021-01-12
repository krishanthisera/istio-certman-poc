# istio-certman-poc
Developing POC for ISTIO with Cert-Manager


*Note that the Terraform files required to be optimised since the implementation is focused on the maximum readability for learning*

# How to run -- Deployment
1. Clone the repo
`git clone https://github.com/krishanthisera/istio-certman-poc.git`
2. cd into the terraform directory and execute terraform plan
`terraform plan -out=istio.tfplan`
3. Apply terraform plan
`terraform apply "istio.tfplan`
4. Configure EKS config
`terraform output kubectl_config > ~/.kube/config`

5. Create Istio name space:
`kubectl create ns istio-system`
6. Install CRD
`kubectl apply -f istio-certman-poc/istio-init/istio-crd.yaml --namespace=istio-system`
7. Install Istio resources
`kubectl apply -f istio-certman-poc/istio-init/istio-res.yaml --namespace=istio-system`
8. Verify the LB
`kubectl get svc -n istio-system`
9. Uncomment Terraform ROUTE53 settings to automate the DNS config and run terraform again
```sh
    terraform plan -out=istio.tfplan
    terraform apply istio.tfplan
```
10. Create Cert-Manager Namespace
`kubectl create ns cert-manager`
11. Deploy CRDs for Cert-Manager
`kubectl apply -f cert-manager/cert-man-crds.yaml -n cert-manager`
12. Label Namespace to disable validations
`kubectl label namespace cert-manager certmanager.k8s.io/disable-validation=true`
13. Install Cert-Manger Resources
`kubectl apply -f cert-manager/cert-man-res.yaml -n cert-manager`

# How to run - Ingress Testing
1. Deploy the demo app
`kubectl apply -f demo-app/bookinfo.yaml`
2. Configure the Gateway and VirtualService
```sh
    kubectl apply -f demo-app/bookinfo.yaml
    kubectl apply -f demo-app/ingress.yaml
```
3. Verify in the browser
`http://book.d3v0ps.com.au/`
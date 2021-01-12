# istio-certman-poc
Developing POC for ISTIO with Cert-Manager


*Note that the trraform files required to be optimised since the implementation is focused on the readability*

#How to run
Create the name space:
`kubectl create ns istio-system`
Install CRD
`kubectl apply -f istio-certman-poc/istio-init/istio-crd.yaml --namespace=istio-system`
Install Istio resources
`kubectl apply -f istio-certman-poc/istio-init/istio-res.yaml --namespace=istio-system`
Verify the LB
`kubectl get svc -n istio-system`
Uncomment Terraform ROUTE53 settings to automate the DNS config and run terraform again
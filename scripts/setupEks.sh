#!/bin/bash

# Variables-
  vAWS_ACCOUNT_ID=$(aws sts get-caller-identity --output text | awk '{print $1}')
  vEKS_CONF_FILE=$(mktemp -q)
  vEKS_ELB_CTRL_ROLE="AWSLoadBalancerControllerRole.yaml"
  vEKS_ELB_FILE="v2_3_0_full.yaml"
  vEKS_NAME=$1
  vEKS_REGION=$2
  vEKS_SUBNET_PRVA=$3
  vEKS_SUBNET_PRVB=$4
  vEKS_VPC_ID=$5
  vEKS_USERS="alessandro.simoes alexandre.izzo guilherme.marim helder.ferreira jose.santos ladislau.junior leonardo.silveira lucas.bezerra lucas.pontes marcos.amorim mario.bonfim paulo.filho pedro.cavalcante"
  vEKSCTL_VERSION=$(eksctl version)
  vHELM_VERSION=$(helm version)
  vKUBECTL_VERSION=$(kubectl version --client)

# AWS CLI validation
  if [ -z "$vAWS_ACCOUNT_ID" ]
  then
     echo "Error: You need to configure AWS CLI first. Please run command 'aws configure' and configure your credentials"
     exit 2
  fi

# EKSCLI validation
  if [ -z "$vEKSCTL_VERSION" ]
  then
     echo "Error: You need to install EKSCTL first."
     exit 2
  fi

# HELM validation
  if [ -z "$vHELM_VERSION" ]
  then
     echo "Error: You need to install HELM first."
     exit 2
  fi

# KUBECTL validation
  if [ -z "$vKUBECTL_VERSION" ]
  then
     echo "Error: You need to install KUBECTL first."
     exit 2
  fi

# Script parameters validation (EKS Name, Region and VPC ID)
  if [ -z "$vEKS_NAME" ] || [ -z "$vEKS_REGION" ] || [ -z "$vEKS_SUBNET_PRVA" ] || [ -z "$vEKS_SUBNET_PRVB" ] || [ -z "$vEKS_VPC_ID" ]
  then
     echo "Error: You need to inform the EKS Cluster Name, Region, Private Subnets (A and B) and VPC ID. Please run command 'setupEks.sh EKS_NAME EKS_REGION EKS_SUBNET_PRVA EKS_SUBNET_PRVB EKS_VPC_ID"
     exit 2
  fi

# Update EKS kubeconfig file
  aws eks update-kubeconfig --name $vEKS_NAME
  kubectl config current-context
  if [ $? -ne 0 ]
  then
     echo "Error: Please, confirm if "$vEKS_NAME" exist and the name is correct."
     exit 2
  fi

# Get ConfgMap, backup, edit and apply new one
  kubectl get configmap -n kube-system aws-auth -o yaml | grep -v "creationTimestamp|resourceVersion|selfLink|uid" | sed '/^  annotations:/,+2 d' > $vEKS_CONF_FILE
  for vEKS_USER in $vEKS_USERS
  do
      vEKS_USER_FIND=`grep $vEKS_USER $vEKS_CONF_FILE`
      if [ -z "$vEKS_USER_FIND" ]
      then
         sed -i '/kind: ConfigMap/i\    - userarn: arn:aws:iam::'"$vAWS_ACCOUNT_ID"':user/'"$vEKS_USER" $vEKS_CONF_FILE
         sed -i '/kind: ConfigMap/i\      username: '"$vEKS_USER" $vEKS_CONF_FILE
         sed -i '/kind: ConfigMap/i\      groups:\n      - system:masters' $vEKS_CONF_FILE
      fi
  done
  kubectl apply -f $vEKS_CONF_FILE
  rm -f $vEKS_CONF_FILE
  
# Create Role Binding for Cluster Admin
  kubectl get clusterrolebinding cluster-admin
  if [ $? -ne 0 ]
  then
     kubectl create clusterrolebinding serviceaccounts-cluster-admin --clusterrole=cluster-admin --group=system:serviceaccounts
  fi

# Associate IAM provider to the cluster
  eksctl utils associate-iam-oidc-provider --cluster $vEKS_NAME --approve

# Create AWSLoadBalancerControllerIAMPolicy
  aws iam list-policies --query 'Policies[?PolicyName==`AWSLoadBalancerControllerIAMPolicy`].Arn' --output text
  if [ $? -ne 0 ]
  then
     curl -so iam_policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.0/docs/install/iam_policy.json
     aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
  fi

# Create ALB service account
  eksctl create iamserviceaccount --cluster $vEKS_NAME --namespace kube-system --name aws-load-balancer-controller --attach-policy-arn arn:aws:iam::743892530434:policy/AWSLoadBalancerControllerIAMPolicy --override-existing-serviceaccounts --approve

# Create CRDs for ALB
  kubectl apply -k github.com/aws/eks-charts/stable/aws-load-balancer-controller//crds?ref=master

# Cert Manager deploy
  curl -fsSL -O  https://github.com/jetstack/cert-manager/releases/download/v1.5.3/cert-manager.yaml
  sed -i 's/10250/10260/g' cert-manager.yaml
  kubectl apply --validate=false -f cert-manager.yaml
  rm cert-manager.yaml
  
# Create AWS Load Balancer Controller Role
  kubectl apply -f $vEKS_ELB_CTRL_ROLE

# Create AWS Load Balancer Service
  curl -fsSL -O https://github.com/kubernetes-sigs/aws-load-balancer-controller/releases/download/v2.3.0/v2_3_0_full.yaml
  sed -i 's/your-cluster-name/'"$vEKS_NAME"'/g' $vEKS_ELB_FILE
  sed -i '/disable-restricted-sg-rules=true/a\        - --aws-vpc-id='"$vEKS_VPC_ID" $vEKS_ELB_FILE
  sed -i '/        - --aws-vpc-id=/a\        - --aws-region='"$vEKS_REGION" $vEKS_ELB_FILE
  sed -i '/apiVersion: v1/{ s/apiVersion: v1/FIRSTLINETODELETE/;:a;n;ba }' $vEKS_ELB_FILE
  sed -i '/FIRSTLINETODELETE/,+8d' $vEKS_ELB_FILE
  kubectl apply -f $vEKS_ELB_FILE

# Create cattle-system namespace
  kubectl get namespace cattle-system
  if [ $? -ne 0 ]
  then
     kubectl create ns cattle-system
  fi

# Deploy Rancher-Ingress
  cp EKSRancherIngress.template EKSRancherIngress.yaml
  vAWS_CERTIFICATES=$(aws acm list-certificates --query CertificateSummaryList[].[CertificateArn,DomainName] --output text | grep mc1.com.br | awk '{print $1}')
  for vAWS_CERTIFICATE in $vAWS_CERTIFICATES
  do
     vAWS_CERTIFICATE_ISSUER=$(aws acm describe-certificate --certificate-arn $vAWS_CERTIFICATE --output json | grep Issuer | awk -F ":" '{print $2}' | tr -d '[:blank:]",\\')
     if [ "$vAWS_CERTIFICATE_ISSUER" = "Amazon" ]
     then
        vAWS_CERTIFICATE=$(echo $vAWS_CERTIFICATE | tr '\/' '_')
        sed -i 's/MyCertificateARN/'"$vAWS_CERTIFICATE"'/g' EKSRancherIngress.yaml
        sed -i 's/_/\//g' EKSRancherIngress.yaml
        sed -i 's/PrivateSubnetIDa/'"$vEKS_SUBNET_PRVA"'/g' EKSRancherIngress.yaml
        sed -i 's/PrivateSubnetIDb/'"$vEKS_SUBNET_PRVB"'/g' EKSRancherIngress.yaml
        break
     fi
  done
  kubectl apply -f EKSRancherIngress.yaml

# Deploy Rancher
  vINGRESS_ELB=$(kubectl get ingress rancher-ingress --namespace cattle-system | grep k8s | awk '{print $4}')
  helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
  helm install rancher rancher-latest/rancher --namespace cattle-system --set hostname=$vINGRESS_ELB --set replicas=2
  echo "https://"$vINGRESS_ELB"/dashboard/?setup="$(kubectl get secret --namespace cattle-system bootstrap-secret -o go-template='{{.data.bootstrapPassword|base64decode}}')

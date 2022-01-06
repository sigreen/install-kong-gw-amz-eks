Installing Kong Gateway on Amazon EKS with Terraform
===========================================================

This example stands up a simple Amazon EKS cluster (v1.19), then provides a procedure to install postgres and Kong Gateway Enterprise

## Prerequisites
1. AWS Credentials (Access Key ID and Secret Access Key)
2. AWS Key Pair for SSH
3. Terraform CLI

## Procedure

1. Via the CLI, login to AWS using `aws configure`.
2. Via the CLI, `cd tf-provision-eks` then run the following Terraform commands to standup Amazon EKS:

```bash
terraform init
terraform apply
```

5. Once terraform has stoodup EKS, setup `kubectl` to point to your new EKS instance:

```bash
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)
kubectl get all
```

6. Copy your enterprise license file to a new file called `license`.

7. Run the installs script via a BASH shell:

```bash
./install.sh
```
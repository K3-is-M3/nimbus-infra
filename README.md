# End-to-End GitOps Architecture on Azure

This repository contains the declarative Infrastructure as Code (IaC) using Terraform and the continuous delivery mechanics via GitHub Actions to deploy, orchestrate, and monitor a highly resilient, containerized web application on Azure Kubernetes Service (AKS).
The goal of this project is to model a production-grade cloud ecosystem incorporating automated delivery pipelines, native platform self-healing, and structural observability controls.

## Key Architectural Features

- Declarative IaC (Terraform): Complete lifecycle management of a segregated Azure Resource Group, Azure Container Registry (ACR), a System-Assigned identity-driven AKS cluster, and Azure Key Vault.
- Automated CI/CD Pipeline (GitHub Actions): Triggered automatically on every code push to the main branch. It authenticates with Azure via an optimized Service Principal context, builds a zero-cache Docker image, uploads it to ACR, and executes a rolling update deployment to AKS.
- Platform Self-Healing: Managed completely via the Kubernetes Control Plane to actively monitor and maintain desired replica counts through spontaneous container failures.
- Cloud Observability (Prometheus & Grafana): Fully configured via a native Helm shell script pipeline. Optimised specifically for trial/student subscription constraints by setting Prometheus to an internal cluster scope, freeing up allocation slots for a public Grafana LoadBalancer dashboard.

## Project Structure


```bash
nimbus-infra/
 ├── .github/                  # GitHub Actions continuous delivery pipelines
 │   └── workflows/
 │       └── deploy.yaml       # Automated build, push, context-switch, and rollout pipeline
 ├── k8s/                      # Kubernetes native orchestration templates
 │   ├── deployment.yaml       # Defines container replica counts, labels, and image specs
 │   └── service.yaml          # Public-facing LoadBalancer routing framework
 ├── monitoring/
 │   └── setup-monitoring      # Automated shell script deploying the Kube-Prometheus-Stack via Helm
 ├── nimbus-site/              # Application baseline context (HTML, CSS, JS frontend engine)
 │   ├── assets/
 │   ├── Dockerfile            # Multi-layer Docker assembly configuration
 │   ├── nginx.conf            # Custom proxy configurations for serving content natively
 │   ├── app.js
 │   ├── index.html
 │   └── styles.css
 └── terraform/                # Infrastructure as Code repository state
     ├── main.tf               # Base regional and Resource Group layouts
     ├── provider.tf           # HashiCorp AzureRM version parameters
     ├── backend.tf            # Remote state locks inside Azure Blob Storage
     ├── variables.tf          # Dynamic environment parameters
     ├── local.tf              # Unified resource tag structures
     ├── storage.tf            # State persistence engine initialization
     ├── acr.tf                # Container image ecosystem
     ├── aks.tf                # Orchestration core configurations (SystemAssigned Identity)
     ├── keyvault.tf           # Managed runtime secrets management
     ├── rbac.tf               # Unified declarative Kubelet-to-ACR Pull assignment controls
     └── output.tf             # Exposed dynamic infrastructure variables
```


## Prerequisites

- Terraform ≥ v1.5
- Azure CLI ≥ v2.45
- Helm CLI ≥ v3.0
- An active Azure subscription with sufficient access to assign local RBAC roles (Owner or User Access Administrator).


## Operational Execution Steps

### 1. Provision the Cloud Infrastructure

Initialize the providers, run sanity state checks, and apply your declarative configurations:

```bash
cd terraform/
terraform init
terraform plan
terraform apply -auto-approve
```

### 2. Configure GitHub Secrets for Automation

To authorize your GitHub Action runner to authenticating against your Azure subscription, gather your service principal properties and add them to your GitHub repository settings under Secrets and Variables -> Actions inside a single JSON payload named AZURE_CREDENTIALS:

```bash
{
  "clientId": "<your-app-registration-id>",
  "clientSecret": "<your-service-principal-password>",
  "subscriptionId": "<your-azure-subscription-id>",
  "tenantId": "<your-active-directory-tenant-id>"
}
```


### 3. Deploy the Application Stack

Make any single-line change to code inside your nimbus-site/ workspace, commit your progress, and push the code:

```bash
git add .
git commit -m "feat: triggering deployment rollout automation"
git push origin main
```

GitHub Actions will automatically pick up the file change, compile the Docker engine, stream the layers to ACR, capture your AKS context, and deploy.

### 4. Deploy the Observability Core

Once the pipeline finishes turning completely green, connect your local CLI tool to the active cluster context and execute the automated observability suite:

```bash
# Connect local kubectl context to the cloud control plane
az aks get-credentials -g <your-resource-group> -n kloud-aks-cluster --overwrite-existing

# Execute the Helm deployment script
cd ../monitoring/
bash setup-monitoring
```

The script will automatically configure namespace boundaries, deploy Prometheus inside a internal ClusterIP profile, expose the Grafana interface, and pull out your plain-text administrative access password.

# SCREENSHOTS OF SOME METRICS SCRAPED IN GRAFANA
<img width="1366" height="768" alt="Screenshot (887)" src="https://github.com/user-attachments/assets/4750a315-5512-43cf-abce-89a54bc5ebeb" />
<img width="1366" height="768" alt="Screenshot (888)" src="https://github.com/user-attachments/assets/42cccab5-b249-4e67-87f4-a65fd88712ab" />
<img width="1366" height="768" alt="Screenshot (889)" src="https://github.com/user-attachments/assets/74966624-91b8-4d6a-adf3-7b55e1e9f88a" />
<img width="1366" height="768" alt="Screenshot (890)" src="https://github.com/user-attachments/assets/a17c1ff5-3c5a-4bd6-9f5a-a9c92fea25f2" />
<img width="1366" height="768" alt="Screenshot (891)" src="https://github.com/user-attachments/assets/8cbf8eb5-61a4-4074-a84c-6b9ed0aae5e2" />


## Chaos Engineering & Resilience Verification


### Verifying Pipeline Updates

When modifications are sent to GitHub, the runner generates a dynamic compilation ID based on your commit string (${{ github.sha }}). The workflow automatically rewrites your active manifests on the fly, forcing AKS to execute a flawless Rolling Update sequence—replacing application pods under zero-downtime constraints.

### Verifying Kubernetes Self-Healing

To observe real-world pod recovery, execute a manual pod termination while watching the workspace:

```bash
# Monitor the operational room live
kubectl get pods -n default -w

# In a separate terminal tab, manually terminate an active worker instance
kubectl delete pod <name-of-active-pod>
```

The control plane will immediately intercept the failure event, calculate the missing structural deficit against your declarative deployment.yaml blueprint, and automatically provision an identical replacement container instance to restore system stability within seconds.

## LIVE DEMO OF CI/CD PIPELINE IN ACTION
- In this video, you will see the initial webapp I have been using for the deployment, called **Nimbus**, hence the repo name, but now I will be replacing it with another one I have made, called **Kloud-infra**. Nothing complicated, just a simple Web app using HTML, CSS and JS. I will be showing you my running pods on k8s, and also demonstrate the self healing mechanism.


https://github.com/user-attachments/assets/a33e7f25-cb74-4fb8-89d3-9cfdabaef115


# Author

## Kelvin Wachira
## DevOps • Cloud Engineering • Infrastructure Automation • Platform Security

🔐 This repository was engineered entirely for portfolio and educational development architecture presentation workloads.

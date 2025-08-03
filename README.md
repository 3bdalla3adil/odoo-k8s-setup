
# Odoo on Kubernetes with Minikube (Local Dev Setup)

This guide walks you through setting up **Odoo** with **PostgreSQL** using **Kubernetes** on your **local machine** via **Minikube**. Ideal for developers wanting a consistent and containerized development environment.

## 🧰 Requirements

- [Docker](https://www.docker.com/products/docker-desktop)
- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## 🛠️ Setup Steps

### 1. Start Minikube

```bash
minikube start
```

### 2. Prepare Local Folder for Add-ons

```bash
mkdir -p ~/odoo-addons
```

> This folder will be used to mount local add-ons into the Odoo container.

### 3. Deploy PostgreSQL

```bash
kubectl apply -f postgres_config.yml
kubectl apply -f postgres_deployment.yaml
```

Wait until the pod is ready:

```bash
kubectl get pods
```

### 4. Deploy Odoo

```bash
kubectl apply -f odoo_deployment.yaml
```

### 5. Access Odoo

```bash
minikube service odoo-service
```

This will open Odoo in your default web browser (usually at http://127.0.0.1:PORT).

## 📁 Project Files

- `postgres_config.yml` – PostgreSQL ConfigMap
- `postgres_deployment.yaml` – PostgreSQL Deployment & PVC
- `odoo_deployment.yaml` – Odoo Deployment & PVC

## 🧹 Cleanup

```bash
kubectl delete -f odoo_deployment.yaml
kubectl delete -f postgres_deployment.yaml
kubectl delete -f postgres_config.yml
minikube stop
```

## 👨‍💻 Author

**Abdulla Bashir**  
Odoo Developer | DevOps Learner | Cybersecurity Enthusiast  
📍 Qatar | 📧 3bdalla995@gmail.com

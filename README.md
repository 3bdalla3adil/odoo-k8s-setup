[![Build & Deploy Odoo](https://github.com/3bdalla3adil/odoo-k8s-setup/actions/workflows/deploy.yaml/badge.svg)](https://github.com/3bdalla3adil/odoo-k8s-setup/actions/workflows/deploy.yaml)

# Odoo on Kubernetes — Odoo.sh Feature Parity

Complete production-ready Kubernetes deployment of Odoo 17 replicating Odoo.sh features.

## Odoo.sh Features Replicated

| Feature | Implementation |
|---------|---------------|
| Tests on every restart | `entrypoint.sh` stage 3 + `run_tests.sh` |
| Auto-discover test modules | `find` scans `tests/test_*.py` |
| DB migration on deploy | `-u all --stop-after-init` |
| Staging / Production | Kubernetes Namespaces |
| CI/CD pipeline | GitHub Actions |
| GitOps auto-deploy | ArgoCD |
| HTTPS / SSL | cert-manager + Let's Encrypt |
| Shell access | `kubectl exec` |
| Log viewer | `kubectl logs` |
| Secrets management | Kubernetes Secrets |
| Persistent storage | PersistentVolumeClaims |
| Health checks | Liveness + Readiness probes |

## Quick Start

### 1. Replace placeholders
| Placeholder | File | Description |
|-------------|------|-------------|
| `your-registry.io` | `docker/Dockerfile`, `k8s/deployment.yaml` | Docker registry |
| `yourdomain.com` | `k8s/ingress*.yaml`, `k8s/cert-issuer.yaml` | Your domain |
| `CHANGE_ME_*` | `k8s/secrets*.yaml` | Passwords |
| `your-email@yourdomain.com` | `k8s/cert-issuer.yaml` | Let's Encrypt email |

### 2. Build & push image
```bash
docker build -t your-registry.io/odoo-custom:17.0 -f docker/Dockerfile .
docker push your-registry.io/odoo-custom:17.0


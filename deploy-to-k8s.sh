kubectl apply -f k8s/namespace.yaml
kubectl apply -f k8s/secrets.yaml      -n odoo-staging
kubectl apply -f k8s/configmap.yaml    -n odoo-staging
kubectl apply -f k8s/pvc.yaml          -n odoo-staging
kubectl apply -f k8s/postgres.yaml     -n odoo-staging
kubectl apply -f k8s/deployment.yaml   -n odoo-staging
kubectl apply -f k8s/service.yaml      -n odoo-staging
kubectl apply -f k8s/ingress.yaml      -n odoo-staging
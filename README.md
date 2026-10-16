# eks-core-apps

Source code for **ShopNow**, the reference e-commerce application that runs on the EKS Core platform.

| Service | Stack |
|---|---|
| `shopnow-frontend` | React, served by nginx |
| `shopnow-backend/api-gateway` | Spring Cloud Gateway |
| `shopnow-discovery-server` | Eureka |
| `shopnow-config-server` | Spring Cloud Config |
| `shopnow-product-service` | Spring Boot + PostgreSQL |
| `shopnow-shopping-cart-service` | Spring Boot |
| `shopnow-user-service` | Spring Boot + Keycloak |

`shopnow-backend/` also holds the local `docker-compose.yaml`, the Keycloak realm export, seed SQL and a Postman collection.

## Build and push images

```bash
export AWS_PROFILE=eks-core
./scripts/build-and-push-ecr.sh
```

Images are built for `linux/amd64` and pushed to ECR in the workload account. Deployment manifests live in [eks-core-gitops](https://github.com/tranvix0910/eks-core-gitops).

## Related repositories

| Repository | Contents |
|---|---|
| [eks-core-docs](https://github.com/tranvix0910/eks-core-docs) | Documentation — [published site](https://tranvix0910.github.io/eks-core-docs/) |
| [eks-core-terraform](https://github.com/tranvix0910/eks-core-terraform) | Network and EKS clusters |
| [eks-core-gitops](https://github.com/tranvix0910/eks-core-gitops) | ArgoCD, add-ons, ShopNow Helm charts |
| **eks-core-apps** | This repository |

See [ShopNow microservices architecture](https://tranvix0910.github.io/eks-core-docs/docs/apps-shopnow/shopnow-microservices-architecture).

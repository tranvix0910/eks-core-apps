#!/usr/bin/env bash
set -euo pipefail
: "${AWS_ACCOUNT_ID:?Set AWS_ACCOUNT_ID}"
: "${AWS_REGION:?Set AWS_REGION}"
: "${IMAGE_TAG:?Set a versioned IMAGE_TAG}"
: "${REACT_APP_BASE_API_URL:?Set the API URL reachable by the browser}"
WORKSHOP_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORKSHOP_REGISTRY="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
WORKSHOP_PLATFORMS="${WORKSHOP_PLATFORMS:-linux/amd64}"
aws ecr get-login-password --region "$AWS_REGION" |
  docker login --username AWS --password-stdin "$WORKSHOP_REGISTRY"
while read -r workshop_image workshop_context; do
  set -- --platform "$WORKSHOP_PLATFORMS" \
    -t "$WORKSHOP_REGISTRY/shopnow/$workshop_image:$IMAGE_TAG" \
    --push "$WORKSHOP_ROOT/$workshop_context"
  if [[ "$workshop_image" == shopnow-frontend ]]; then
    set -- --build-arg "REACT_APP_BASE_API_URL=$REACT_APP_BASE_API_URL" "$@"
  fi
  docker buildx build "$@"
done <<'IMAGES'
shopnow-frontend shopnow-frontend
shopnow-api-gateway shopnow-backend/api-gateway
shopnow-config-server shopnow-config-server
shopnow-discovery-server shopnow-discovery-server
shopnow-product-service shopnow-product-service
shopnow-shopping-cart-service shopnow-shopping-cart-service
shopnow-user-service shopnow-user-service
IMAGES

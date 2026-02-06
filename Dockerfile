# Build stage
FROM alpine AS builder
WORKDIR /app
COPY index.html .

# Production stage
FROM nginx:alpine
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html

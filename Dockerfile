# ------Build Stage ---------
FROM alpine as builder
WORKDIR /app
COPY index.html .

# -------production stage -------
FROM nginx:alpine
COPY --from=builder /app/index.html /usr/share/nginx/html/index.html
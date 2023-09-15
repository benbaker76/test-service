# Stage 1: Build the Go application
FROM golang as builder
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o test-service

# Stage 2: Create a minimal image
FROM scratch
COPY --from=builder /app/test-service /
EXPOSE 8080
ENTRYPOINT ["/test-service"]

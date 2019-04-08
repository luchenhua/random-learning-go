#build stage
FROM golang:alpine AS builder
WORKDIR /go/src/app
ENV GO111MODULE=on
ENV GOPROXY=https://goproxy.io
# RUN apk add --no-cache git
COPY . .
# RUN go mod tidy
# RUN go mod verify
# RUN go mod vendor
RUN go install -mod=vendor -v ./...

#final stage
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /go/bin/random-learning-go /random-learning-go
ENTRYPOINT ./random-learning-go
LABEL Name=random-learning-go Version=0.0.1
EXPOSE 3000
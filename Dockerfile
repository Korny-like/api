# syntax=docker/dockerfile:1

FROM golang:1.16-alpine
WORKDIR /app
# Download necessary Go modules

COPY go.mod ./
COPY go.sum ./
RUN go mod download
COPY *.go ./
RUN go build -o /docker-api
#ensure to be in the same dir as the main.go file
RUN go get -v -t -d ./...
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o api

EXPOSE 8080
CMD [ "/docker-api" ]

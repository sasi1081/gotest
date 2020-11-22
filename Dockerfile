FROM golang:alpine
RUN mkdir /app
COPY go.mod /app
COPY go.sum /app
COPY main.go /app
WORKDIR /app
RUN go build -o main .
CMD ["/app/main"]

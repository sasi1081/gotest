FROM golang:alpine
RUN mkdir /app
COPY go /app
WORKDIR /app
RUN go build -o main .
CMD ["/app/main"]

FROM golang:alpine AS builder
WORKDIR $GOPATH
ADD . .
RUN apk update
RUN apk add --no-cache git
RUN go get -d -v \
    github.com/lib/pq \
    github.com/julienschmidt/httprouter
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o a.out



FROM scratch

COPY --from=builder /go/a.out .

ENTRYPOINT ["./a.out"]
EXPOSE 8000


FROM golang:alpine AS builder
ADD . .
RUN apk update
RUN apk add --no-cache git
RUN go get -d -v \
    github.com/lib/pq \
    github.com/julienschmidt/httprouter
RUN GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o a.out



FROM scratch

COPY --from=builder go/a.out go/a.out
ENTRYPOINT ["go/a.out"]
EXPOSE 8000


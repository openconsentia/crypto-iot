ARG GO_VER

FROM ${GO_VER} as builder 

WORKDIR /opt

COPY ./cmd ./cmd
COPY ./internal ./internal
COPY ./go.sum ./go.sum
COPY ./go.mod ./go.mod

RUN go mod download && \
    env CGO_ENABLED=0 env GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o ./build/sensor ./cmd/sensor

FROM scratch

COPY --from=builder /opt/build/sensor /usr/bin/sensor

CMD /usr/bin/sensor
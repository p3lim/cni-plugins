ARG CNI_VERSION="v0.9.1"

FROM docker.io/library/golang:1-alpine AS build
ARG CNI_VERSION

ENV CGO_ENABLED=0

RUN apk add --no-cache git bash \
 && git clone https://github.com/containernetworking/plugins --branch ${CNI_VERSION} --single-branch /build \
 && cd /build \
 && bash build_linux.sh

FROM docker.io/library/alpine:3.12
COPY --from=build /build/bin/ /opt/cni/bin
ENTRYPOINT ["/bin/sleep"]
CMD ["infinity"]

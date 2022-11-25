# SPDX-FileCopyrightText: 2022 SAP SE or an SAP affiliate company and Gardener contributors
#
# SPDX-License-Identifier: Apache-2.0

############# portmap-builder
FROM alpine:3.16.3 AS portmap-builder
ARG TARGETARCH

RUN apk update \
  && apk add curl \
  && mkdir /cni \
  && mkdir /cni/bin \
  && mkdir /cni/lib \
  && cp /bin/cp /cni/bin/ \
  && cp /lib/ld-musl-* /cni/lib/ \
  && cp /lib/libc.musl-* /cni/lib \
  && curl -s -S -f -L --retry 10 https://github.com/containernetworking/plugins/releases/download/v1.1.1/cni-plugins-linux-${TARGETARCH}-v1.1.1.tgz | tar -xz -C /cni/bin ./portmap

############# portmap-copier
FROM gcr.io/distroless/static-debian11:nonroot AS portmap-copier
USER 0
WORKDIR /

COPY --from=portmap-builder /cni /
ENTRYPOINT ["/bin/cp", "/bin/portmap", "/host/portmap"]


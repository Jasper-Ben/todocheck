FROM golang:1.18.5-alpine3.16 AS build
ARG version
RUN apk add --no-cache \
    make
ADD . /usr/src/todocheck
WORKDIR /usr/src/todocheck 
RUN if test -n "$version"; then version=${version} make install; else make install; fi

FROM alpine:3.16
COPY --from=build /usr/local/bin/todocheck /usr/local/bin/todocheck
ENTRYPOINT ["/usr/local/bin/todocheck"]

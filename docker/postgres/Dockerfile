FROM postgres:14 AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      build-essential postgresql-server-dev-14 systemtap-sdt-dev

COPY docker/postgres/rum/ /usr/src/rum/

WORKDIR /usr/src/rum/

RUN mkdir /tmp/build && make USE_PGXS=1 DESTDIR=/tmp/build install

FROM postgres:14 AS runtime
COPY --from=build /tmp/build/ /

RUN chmod 644 /usr/lib/postgresql/14/lib/rum.so




FROM ubuntu:16.04
MAINTAINER  Niene Boeijen

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      wget \
      make \
      cmake \
      g++ \
      libboost-dev \
      libboost-system-dev \
      libboost-filesystem-dev \
      libexpat1-dev \
      zlib1g-dev \
      libbz2-dev \ 
      libpq-dev \
      libproj-dev \
      lua5.2 \
      liblua5.2-dev \
      unzip \
      && \
    rm -rf /var/lib/apt/lists/*

RUN wget --no-check-certificate https://github.com/openstreetmap/osm2pgsql/archive/master.zip \
      && unzip master.zip
WORKDIR /osm2pgsql-master
RUN  mkdir build && cd build \
      && cmake .. -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Debug -DBUILD_TESTS=OFF  \
      && make \
      && make install

ENTRYPOINT ["osm2pgsql"]
# Base image
FROM debian:bullseye

# Install dependencies
RUN apt update && apt install -y \
  build-essential \
  cmake \
  libboost-all-dev \
  git \
  && rm -rf /var/lib/apt/lists/*

# Clone vsomeip repository
RUN git clone https://github.com/GENIVI/vsomeip.git /vsomeip

# Build vsomeip
WORKDIR /vsomeip
RUN mkdir build && cd build && \
  cmake -DENABLE_SIGNAL_HANDLING=1 -DBUILD_SHARED_LIBS=ON .. && \
  make -j$(nproc) && \
  make install && \
  ldconfig

# Build examples
RUN cd examples/hello_world && \
  mkdir build && cd build && \
  cmake .. && \
  make -j$(nproc)

# Set work directory for running hello_world
WORKDIR /vsomeip/examples/hello_world/build

# Entry point
CMD ["/bin/bash"]

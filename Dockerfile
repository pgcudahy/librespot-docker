# Starting from Rust's versioned image since Librespot is a Rust application
FROM rust:1.70.0 as builder

WORKDIR /home/root

# Installing git to clone the repo and clone the Librespot repo
RUN apt-get update \
    && apt-get install -y git libasound2-dev --no-install-recommends \
    && git clone https://github.com/librespot-org/librespot.git -b v0.4.2

WORKDIR /home/root/librespot

# Build Librespot with Cargo (Rust's build system)
RUN cargo build --no-default-features --features rodio-backend

# --------------------
# Production Image
# --------------------
FROM debian:12.0-slim

# Installing required dependencies
RUN apt-get update \
    && apt-get install -y libasound2 --no-install-recommends

# Copy the build artifact from the builder stage
COPY --from=builder /home/root/librespot/target/debug/librespot /usr/bin/librespot

# Set environment variables for librespot
ENV SPOTIFY_USERNAME YOUR_SPOTIFY_USERNAME
ENV SPOTIFY_PASSWORD YOUR_SPOTIFY_PASSWORD
ENV LIBRESPOT_NAME My_Spotify
ENV LIBRESPOT_BITRATE 160
ENV LIBRESPOT_VERBOSE FALSE

# Default command to run on container start
CMD ["/usr/bin/librespot"]

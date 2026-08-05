# Build stage
FROM rust:1.89 as builder

# Set working directory
WORKDIR /app

# Copy Cargo files for dependency caching
COPY Cargo.toml Cargo.lock ./

# Create dummy main.rs for dependency cache
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build dependencies only
RUN cargo build --release && rm -rf src

# Copy source code
COPY src ./src
COPY migrations ./migrations
COPY Rocket.toml ./
COPY static ./static

# Build the application
RUN cargo build --release

# Runtime stage
FROM debian:bookworm-slim

# Install runtime dependencies
RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# Create app user
RUN useradd -r -s /bin/false appuser

# Set working directory
WORKDIR /app

# Copy the binary (���� �̸� �״��!)
COPY --from=builder /app/target/release/ClassicMap_back /app/ClassicMap_back
COPY --from=builder /app/target/release/load_clip_assets /app/load_clip_assets
COPY --from=builder /app/target/release/load_comparison_candidates /app/load_comparison_candidates
COPY --from=builder /app/target/release/load_global_seed /app/load_global_seed
COPY --from=builder /app/target/release/link_legacy_authorities /app/link_legacy_authorities
COPY --from=builder /app/target/release/prepare_legacy_authority_bootstrap /app/prepare_legacy_authority_bootstrap

# Copy configuration files
COPY --from=builder /app/Rocket.toml ./Rocket.toml

# Create cache directory
RUN mkdir -p /app/cache/images /var/cache/classicmap-video-clips

# Change ownership to app user
RUN chown -R appuser:appuser /app /var/cache/classicmap-video-clips

USER appuser

# Expose port
EXPOSE 1037

# Run the application (���� �̸� �״��!)
CMD ["./ClassicMap_back"]

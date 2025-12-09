# Build stage
FROM rust:1.89 as builder

# Set working directory
WORKDIR /app

# Copy Cargo files for dependency caching
COPY Cargo.toml Cargo.lock ./

# Copy .sqlx for offline mode (있다면)
COPY .sqlx ./.sqlx

# Create dummy main.rs for dependency cache
RUN mkdir src && echo "fn main() {}" > src/main.rs

# Build dependencies only
ENV SQLX_OFFLINE=true
RUN cargo build --release && rm -rf src

# Copy source code
COPY src ./src
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

# Copy the binary (원래 이름 그대로!)
COPY --from=builder /app/target/release/ClassicMap_back /app/ClassicMap_back

# Copy configuration files
COPY --from=builder /app/Rocket.toml ./Rocket.toml

# Change ownership to app user
RUN chown -R appuser:appuser /app

USER appuser

# Expose port
EXPOSE 1037

# Run the application (원래 이름 그대로!)
CMD ["./ClassicMap_back"]

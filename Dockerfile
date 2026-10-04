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
COPY build.rs ./
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
COPY --from=builder /app/target/release/approve_seed_run /app/approve_seed_run
COPY --from=builder /app/target/release/build_clip_bundle /app/build_clip_bundle
COPY --from=builder /app/target/release/load_loudness_profiles /app/load_loudness_profiles
COPY --from=builder /app/target/release/load_clip_alignments /app/load_clip_alignments
COPY --from=builder /app/target/release/load_listening_notes /app/load_listening_notes
COPY --from=builder /app/target/release/load_piece_reco_features /app/load_piece_reco_features

# 시드 배치를 클러스터 안에서 발행하는 데 필요한 것. 후보·음량 곡선·정렬 지도·듣기 노트·추천 속성 JSONL 만 넣는다 —
# 검수 보고서와 클립 번들은 기록이지 실행에 쓰지 않는다.
COPY scripts/seed_publish.sh /app/seed_publish.sh
COPY seed_pipeline/curation /tmp/curation
RUN mkdir -p /app/seed \
    && cd /tmp/curation \
    && for dir in */; do \
         for file in candidates.jsonl loudness-profiles.jsonl alignment-maps.jsonl notes.jsonl features.jsonl; do \
           if [ -f "$dir/$file" ]; then \
             mkdir -p "/app/seed/${dir%/}"; \
             cp "$dir/$file" "/app/seed/${dir%/}/$file"; \
           fi; \
         done; \
       done \
    && rm -rf /tmp/curation \
    && chmod +x /app/seed_publish.sh

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

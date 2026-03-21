FROM python:3.13-slim AS base

# Install uv from official image
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Install Python dependencies first (layer cache)
COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

# Copy project files
COPY Makefile .
COPY src/ ./src/

# Install dbt packages at build time
RUN uv run dbt deps \
    --project-dir src/transform/nba_analytics \
    --profiles-dir src/transform/nba_analytics

# DuckDB database is generated at runtime
# Mount a volume at /app if you want to persist nba.duckdb
VOLUME ["/app"]

# Full pipeline: ingest CSV → DuckDB, then run dbt models
CMD ["uv", "run", "src/ingest/load.py"]

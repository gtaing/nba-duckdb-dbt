

ingest:
	@echo "🚀 Ingesting files to duckdb"
	@uv run src/ingest/load.py

debug-dbt-config:
	@uv run dbt debug --project-dir src/transform/nba_analytics --profiles-dir src/transform

transform: ingest
	@echo "🚀 Transforming with dbt"
	@uv run dbt run --project-dir src/transform/nba_analytics --profiles-dir src/transform

test-ingest:
	@echo "🚀 Testing code: Running pytest"
	@uv run -m pytest tests

dbt-docs-serve:
	@echo "🚀 Generating dbt docs"
	@uv run dbt docs generate --project-dir src/transform/nba_analytics --profiles-dir src/transform
	@uv run dbt docs serve --project-dir src/transform/nba_analytics --profiles-dir src/transform

dbt-compile:
	@echo "🚀 Compiling dbt models"
	@uv run dbt compile --project-dir src/transform/nba_analytics --profiles-dir src/transform

duckdb-ui:
	@echo "🚀 Starting duckdb UI"
	@duckdb -ui nba.duckdb

clean:
	[ -f nba.duckdb ] && rm nba.duckdb
	[ -d src/transform/nba_analytics/target ] && rm -rf src/transform/nba_analytics/target

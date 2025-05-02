

ingest:
	@echo "🚀 Ingesting files to duckdb"
	@uv run src/ingest/load.py

debug-dbt-config:
	@uv run dbt debug --project-dir src/transform/nba_analytics --profiles-dir src/transform

transform:
	@echo "🚀 Transforming with dbt"
	@uv run dbt run --project-dir src/transform/nba_analytics --profiles-dir src/transform

test-ingest:
	@echo "🚀 Testing code: Running pytest"
	@uv run -m pytest tests

clean:
	[ -f nba.duckdb ] && rm nba.duckdb
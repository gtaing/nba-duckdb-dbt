# Variables for common paths
PROJECT_DIR = src/transform/nba_analytics
PROFILES_DIR = src/transform/nba_analytics

# Commands
DBT_CMD = uv run dbt
DBT_OPTIONS = --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR)

# Targets
ingest:
	@echo "🚀 Ingesting files to duckdb"
	@uv run src/ingest/load.py

debug-dbt-config:
	@echo "🚀 Debug dbt config"
	@$(DBT_CMD) debug $(DBT_OPTIONS)

transform: ingest
	@echo "🚀 Transforming with dbt"
	@$(DBT_CMD) run $(DBT_OPTIONS)

test-ingest:
	@echo "🚀 Testing code: Running pytest"
	@uv run -m pytest tests

dbt-docs-serve:
	@echo "🚀 Generating dbt docs"
	@$(DBT_CMD) docs generate $(DBT_OPTIONS)
	@$(DBT_CMD) docs serve $(DBT_OPTIONS)

dbt-compile:
	@echo "🚀 Compiling dbt models"
	@$(DBT_CMD) compile $(DBT_OPTIONS)

dbt-deps:
	@echo "🚀 Installing dbt dependencies"
	@$(DBT_CMD) deps $(DBT_OPTIONS)

dbt-clean:
	@echo "🚀 Cleaning dbt project"
	@$(DBT_CMD) clean $(DBT_OPTIONS)

dbt-test:
	@echo "🚀 Testing dbt models"
	@$(DBT_CMD) test $(DBT_OPTIONS)

duckdb-ui:
	@echo "🚀 Starting duckdb UI"
	@duckdb -ui nba.duckdb

clean:
	[ -f nba.duckdb ] && rm nba.duckdb
	[ -d $(PROJECT_DIR)/target ] && rm -rf $(PROJECT_DIR)/target
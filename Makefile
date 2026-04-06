# Variables for common paths
PROJECT_DIR = src/transform/nba_analytics
PROFILES_DIR = src/transform/nba_analytics

# Commands
DBT_CMD = uv run dbt
DBT_OPTIONS = --project-dir $(PROJECT_DIR) --profiles-dir $(PROFILES_DIR)

.PHONY: help

# Targets
help:
	@echo "Available commands:"
	@echo "  make ingest            - Ingest files to duckdb"
	@echo "  make debug-dbt-config  - Debug dbt config"
	@echo "  make transform         - Transform data with dbt"
	@echo "  dbt-sqlfluff-lint      - Lint with sqlfluff"
	@echo "  dbt-sqlfluff-fix       - Fix formatting with sqlfluff"
	@echo "  make test-ingest       - Test code with pytest"
	@echo "  make dbt-docs-serve    - Serve dbt documentation"
	@echo "  make dbt-compile       - Compile dbt models"
	@echo "  make dbt-deps          - Install dbt dependencies"
	@echo "  make dbt-seed          - Run dbt seed"
	@echo "  make dbt-clean         - Clean dbt project"
	@echo "  make dbt-test          - Test dbt models"
	@echo "  make duckdb-ui         - Start duckdb UI"
	@echo "  make clean             - Clean up duckdb and dbt files"

ingest:
	@echo "🚀 Ingesting files to duckdb"
	@uv run src/ingest/load.py

debug-dbt-config:
	@echo "🚀 Debug dbt config"
	@$(DBT_CMD) debug $(DBT_OPTIONS)

transform: ingest dbt-seed dbt-deps
	@echo "🚀 Transforming with dbt"
	@$(DBT_CMD) build -f $(DBT_OPTIONS)

test-ingest:
	@echo "🚀 Testing code: Running pytest"
	@uv run -m pytest tests

dbt-sqlfluff-lint:
	@echo "🚀 Applying sqlfluff linting on dbt models in: $(PROJECT_DIR)"
	@uv run -m sqlfluff lint $(PROJECT_DIR)

dbt-sqlfluff-fix:
	@echo "🚀 Applying sqlfluff fixing on dbt models in: $(PROJECT_DIR)"
	@uv run -m sqlfluff fix $(PROJECT_DIR)

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

dbt-seed:
	@echo "🚀 Running dbt seed"
	@$(DBT_CMD) seed $(DBT_OPTIONS)

dbt-clean:
	@echo "🚀 Cleaning dbt project"
	@$(DBT_CMD) clean $(DBT_OPTIONS)

dbt-test:
	@echo "🚀 Testing dbt models"
	@$(DBT_CMD) test $(DBT_OPTIONS)

dbt-generate-yaml-for-model:
	@echo "🚀 Generating yaml for $(DBT_MODEL)"
	@$(DBT_CMD) run-operation generate_model_yaml --args '{"model_names": ["$(DBT_MODEL)"]}' $(DBT_OPTIONS)

dbt-generate-unit-test-for-model:
	@echo "🚀 Generating unit test for $(DBT_MODEL)"
	@$(DBT_CMD) run-operation generate_unit_test_template --args '{"model_name": "$(DBT_MODEL)", "inline_columns": false}' $(DBT_OPTIONS)

duckdb-ui:
	@echo "🚀 Starting duckdb UI"
	@duckdb -ui nba.duckdb

clean:
	@echo "🚀 Cleaning up duckdb files"
	if [ -f nba.duckdb ]; then rm nba.duckdb; fi
	@echo "🚀 Cleaning up dbt target files"
	if [ -d $(PROJECT_DIR)/target ]; then rm -rf $(PROJECT_DIR)/target; fi
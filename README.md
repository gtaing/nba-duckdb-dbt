# NBA Analytics with DuckDB and dbt

This project is designed to analyze NBA data using **DuckDB** for efficient querying and **dbt** (Data Build Tool) for data transformation and modeling. The project includes data ingestion, transformation, and testing workflows to enable streamlined analytics.

## Project Structure

- **`src/ingest`**: Contains scripts for loading raw data into DuckDB.
- **`src/transform`**: Houses dbt models for transforming raw data into analytics-ready datasets.
- **`tests`**: Includes unit tests for validating data ingestion and transformation logic.

## Key Features

1. **Data Ingestion**:
   - Raw data is loaded into DuckDB using Python scripts.
   - Example: `src/ingest/load.py` handles loading CSV files into DuckDB.

2. **Data Transformation**:
   - dbt is used to transform raw data into clean, analytics-ready tables.
   - Models are located in `src/transform/nba_analytics/models`.

3. **Testing**:
   - Unit tests are written using `pytest` to ensure data integrity.
   - Example: `tests/ingest/test_load.py` validates data loading functionality.

4. **Database**:
   - DuckDB is used as the local database for fast and efficient querying.
   - Database files are ignored in version control (`*.duckdb`).

## Prerequisites

- Python 3.13+
- uv
- make

## Setup Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/nba-duckdb-dbt.git
   cd nba-duckdb-dbt
   ```

2. Create the virtual Python environment:
   ```bash
   make update
   ```

3. Run dbt setup:
   ```bash
   dbt debug --project-dir src/transform/nba_analytics --profiles-dir src/transform
    ```

## Usage

### Ingest Data
Run the following command to load raw data into DuckDB:
```bash
make ingest
```

### Transform Data
Execute dbt models to transform the data:
```bash
make transform
```

### Test
Run unit tests to validate the ingestion and transformation logic:
```bash
make test-ingest
```

### Clean
Remove the DuckDB database file:
```bash
make clean
```
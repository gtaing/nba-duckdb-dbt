import duckdb

import polars as pl

from loguru import logger
from pandas import DataFrame

def load_data(file_path: str) -> DataFrame:
    """
    Load data from a CSV file into a Polars DataFrame.

    Args:
        file_path (str): The path to the CSV file.

    Returns:
        pl.DataFrame: A Polars DataFrame containing the loaded data.
    """
    try:
        df = pl.read_csv(file_path)
        return df
    except Exception as e:
        logger.error(f"Error loading data: {e}")
        return None
    
def load_data_to_duckdb(df: DataFrame, table_name: str, duckdb_path: str = "nba.duckdb") -> None:
    """
    Load a Pandas DataFrame into DuckDB.

    Args:
        df (DataFrame): The DataFrame to load.
        table_name (str): The name of the table in DuckDB.
    """
    try:
        con = duckdb.connect(f"{duckdb_path}")
        con.execute("CREATE SCHEMA IF NOT EXISTS raw")
        con.execute(f"CREATE OR REPLACE TABLE raw.{table_name} AS SELECT * FROM df")
        logger.info(f"Data loaded into DuckDB table: {table_name}")
    except Exception as e:
        logger.error(f"Error loading data into DuckDB: {e}")

def load_csv_to_duckdb(file_path: str, table_name: str, duckdb_path: str = "nba.duckdb") -> None:
    """
    Load a CSV file into DuckDB.

    Args:
        file_path (str): The path to the CSV file.
        table_name (str): The name of the table in DuckDB.
    """
    try:
        con = duckdb.connect(f"{duckdb_path}")
        con.execute("CREATE SCHEMA IF NOT EXISTS raw")
        con.execute(f"CREATE OR REPLACE TABLE raw.{table_name} AS SELECT * FROM read_csv('{file_path}')")
        logger.info(f"CSV loaded into DuckDB table: {table_name}")
    except Exception as e:
        logger.error(f"Error loading CSV into DuckDB: {e}")
    
if __name__ == "__main__":
    load_csv_to_duckdb("src/data/game.csv", "game")




    
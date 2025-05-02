import pytest
import duckdb
import polars as pl
from src.ingest.load import load_data, load_data_to_duckdb


def test_load_data():
    test_game = load_data("tests/data/game.csv")

    assert test_game is not None, "Failed to load data"
    assert test_game.shape[0] > 0, "Loaded data is empty"

def test_load_data_to_duckdb():
    test_game = load_data("tests/data/game.csv")
    con = duckdb.connect("tests/test_nba.duckdb")

    # Load the DataFrame into DuckDB
    load_data_to_duckdb(test_game, "game_test", "tests/test_nba.duckdb")

    # Check if the table exists
    result = con.execute("SELECT COUNT(*) FROM raw.game_test").fetchone()

    assert result[0] > 0, "Failed to load data into DuckDB"
{{
  config(
    materialized = 'incremental',
    unique_key = 'game_id',
    incremental_strategy = 'delete+insert',
    on_schema_change = 'append_new_columns'
    )
}}

WITH source AS (
    SELECT * FROM {{ source('raw', 'games') }}
    {% if is_incremental() %}
    WHERE game_date >= (SELECT max(game_date) FROM {{ this }}) -- Retrieving only new games since last dbt run
    {% endif %}
)

, final AS (
    SELECT
        season_id
        , game_id
        , game_date
        , {{ game_extract_season("game_date", "season_id") }} AS season
        , 'home' AS game_location
        , wl_home AS win_loss
        , team_abbreviation_home AS team
        , team_name_home AS team_name
        , team_abbreviation_away AS opponent
        , team_name_away AS opponent_name
        , {{ game_rename_metrics('_home', 'team_') }}
        , {{ game_rename_metrics('_away', 'opponent_') }}
    FROM source
)

SELECT
    season_id
    , game_id
    , game_date
    , season
    , game_location
    , win_loss
    , team
    , team_name
    , opponent
    , opponent_name
    , team_pts
    , team_fgm
    , team_fga
    , team_fg_pct
    , team_fg3m
    , team_fg3a
    , team_fg3_pct
    , team_ftm
    , team_fta
    , team_ft_pct
    , team_oreb
    , team_dreb
    , team_reb
    , team_ast
    , opponent_pts
    , opponent_fgm
    , opponent_fga
    , opponent_fg_pct
    , opponent_fg3m
    , opponent_fg3a
    , opponent_fg3_pct
    , opponent_ftm
    , opponent_fta
    , opponent_ft_pct
    , opponent_oreb
    , opponent_dreb
    , opponent_reb
    , opponent_ast
FROM
    final

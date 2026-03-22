{{
    config(
        materialized = 'incremental',
        unique_key = ['season_id', 'game_id', 'team'],
        incremental_strategy = 'delete+insert',
        on_schema_change = 'append_new_columns'
    )
}}

{% set min_year_for_stats = 2012 %}

WITH team_stats_home AS (
    SELECT * FROM {{ ref("base_team_stats__home") }}
    WHERE year(cast(game_date AS date)) >= {{ min_year_for_stats }}
    {% if is_incremental() %}
      and game_date >= (select max(game_date) from {{ this }})
    {% endif %}
)

, team_stats_away AS (
    SELECT * FROM {{ ref("base_team_stats__away") }}
    WHERE year(cast(game_date AS date)) >= {{ min_year_for_stats }}
    {% if is_incremental() %}
      and game_date >= (select max(game_date) from {{ this }})
    {% endif %}
)

, full_games AS (
    SELECT * FROM team_stats_home
    UNION ALL
    SELECT * FROM team_stats_away

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
FROM full_games

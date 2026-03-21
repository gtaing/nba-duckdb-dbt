WITH team_stats_home AS (
    SELECT * FROM {{ ref("base_team_stats__home") }}
)

, team_stats_away AS (
    SELECT * FROM {{ ref("base_team_stats__away") }}
)

, full_games AS (
    SELECT * FROM team_stats_home
    UNION
    SELECT * FROM team_stats_away
    WHERE year(cast(game_date AS date)) >= 2012
)

SELECT
    *
    , concat_ws(
        '-'
        , year(min(game_date) OVER (PARTITION BY season_id))
        , right(
            cast(
                year(
                    max(game_date) OVER (PARTITION BY season_id)
                ) AS string
            )
            , 2
        )
    ) AS season
FROM full_games

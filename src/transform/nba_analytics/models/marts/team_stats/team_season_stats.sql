WITH int_team_game_stats AS (
    SELECT *
    FROM
        {{ ref('int_team_game_stats') }}
)

, mean_stats AS (
    SELECT
        season_id
        , team
        , team_name
        , season
        , count(win_loss) FILTER (WHERE win_loss = 'W') AS wins
        , count(win_loss) FILTER (WHERE win_loss = 'L') AS losses
        , count(game_id) AS total_games
        , {{ game_get_metric_mean('team_') }}
        , {{ game_get_metric_mean('opponent_') }}
    FROM
        int_team_game_stats
    GROUP BY
        season_id, team, team_name, season
    HAVING
        total_games = 82
    ORDER BY
        season DESC
)

SELECT
    m.*
    , {{ game_get_metric_net() }}
    , {{ game_get_metric_rank('team_') }}
    , {{ game_get_metric_rank('opponent_') }}
    , {{ game_get_metric_rank('net_') }}
FROM mean_stats AS m

{% set metrics = game_get_metrics() %}

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

        {% for m in metrics %}
        , round(avg(team_{{ m }}), 1) AS team_{{ m }}
        {% endfor %}

        {% for m in metrics %}
        , round(avg(opponent_{{ m }}), 1) AS opponent_{{ m }}
        {% endfor %}
    FROM
        int_team_game_stats
    GROUP BY
        season_id, team, team_name, season
    HAVING
        total_games = 82
    ORDER BY
        season DESC
)

, mean_and_rank_stats AS (
    SELECT
        m.*
        -- net metrics
        {% for m in metrics %}
        , round(team_{{ m }} - opponent_{{ m }}, 1) AS net_{{ m }}
        {% endfor %}

        -- team ranks
        {% for m in metrics %}
        , rank() OVER (PARTITION BY season_id ORDER BY team_{{ m }} DESC) AS team_{{ m }}_rank
        {% endfor %}

        -- opponent ranks
        {% for m in metrics %}
        , rank() OVER (PARTITION BY season_id ORDER BY opponent_{{ m }} DESC) AS opponent_{{ m }}_rank
        {% endfor %}

        -- net ranks
        {% for m in metrics %}
        , rank() OVER (PARTITION BY season_id ORDER BY net_{{ m }} DESC) AS net_{{ m }}_rank
        {% endfor %}
    FROM mean_stats AS m
)

SELECT
    -- identifiers
    season_id,
    team,
    team_name,
    season,

    -- record
    wins,
    losses,
    total_games,

    -- team metrics
    {% for m in metrics %}
    team_{{ m }}{{ "," if not loop.last }}
    {% endfor %},

    -- opponent metrics
    {% for m in metrics %}
    opponent_{{ m }}{{ "," if not loop.last }}
    {% endfor %},

    -- net metrics
    {% for m in metrics %}
    net_{{ m }}{{ "," if not loop.last }}
    {% endfor %},

    -- team ranks
    {% for m in metrics %}
    team_{{ m }}_rank{{ "," if not loop.last }}
    {% endfor %},

    -- opponent ranks
    {% for m in metrics %}
    opponent_{{ m }}_rank{{ "," if not loop.last }}
    {% endfor %},

    -- net ranks
    {% for m in metrics %}
    net_{{ m }}_rank{{ "," if not loop.last }}
    {% endfor %}
FROM 
    mean_and_rank_stats m


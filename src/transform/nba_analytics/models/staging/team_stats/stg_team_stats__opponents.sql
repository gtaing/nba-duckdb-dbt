with team_stats_home as (
    select * from {{ ref("base_team_stats__home") }}
),

team_stats_away as (
    select * from {{ ref("base_team_stats__away") }}
),

full_games as (
    select * from team_stats_home
    union
    select * from team_stats_away
    where year(cast(game_date as date)) >= 2012
)

select
    *,
    concat_ws(
        '-',
        year(min(game_date) over (partition by season_id)),
        right(
            cast(
                year(
                    max(game_date) over (partition by season_id)
                ) as string
            ),
            2
        )
    ) as season
from full_games

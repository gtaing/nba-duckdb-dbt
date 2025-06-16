with home_games as (
    select
        season_id,
        game_id,
        game_date,
        'home' as game_location,
        wl_home as win_loss,
        team_abbreviation_home as team,
        team_name_home as team_name,
        team_abbreviation_away as opponent,
        team_name_away as opponent_name,
        {{ game_rename_metrics('_home', 'team_') }},
        {{ game_rename_metrics('_away', 'opponent_') }}
    from {{ dbt_unit_testing.source("raw", "games") }}
),
away_games as (
    select
        season_id,
        game_id,
        game_date,
        'away' as game_location,
        wl_away as win_loss,
        team_abbreviation_away as team,
        team_name_away as team_name,
        team_abbreviation_home as opponent,
        team_name_home as opponent_name,
        {{ game_rename_metrics('_away', 'team_') }},
        {{ game_rename_metrics('_home', 'opponent_') }},
    from {{ dbt_unit_testing.source("raw", "games") }}
),
full_games as (
    select * from home_games 
    union 
    select * from away_games
    where year(cast(game_date as date)) >= 2012
),
season_pattern as (
  select 
    season_id,
    concat_ws('-', year(min(game_date)), right(cast(year(max(game_date)) as string), 2)) as season
  from full_games
  group by season_id
)
select 
    s.season,
    f.*
from full_games as f
left join season_pattern as s
on s.season_id = f.season_id

with mean_stats as (
  select 
  season_id,
  team,
  team_name,
  season,
  sum(case when win_loss = 'w' then 1 else 0 end) as wins,
  sum(case when win_loss = 'l' then 1 else 0 end) as losses,
  count(game_id) as total_games,
  {{ game_get_metric_mean('team_') }},
  {{ game_get_metric_mean('opponent_') }}
from {{ dbt_unit_testing.ref('stg_game_stats') }}
group by season_id, team, team_name, season
having total_games = 82
order by season desc
)
select 
  m.*,
  {{ game_get_metric_net() }},
  {{ game_get_metric_rank('team_') }},
  {{ game_get_metric_rank('opponent_') }},
  {{ game_get_metric_rank('net_') }}
from mean_stats m

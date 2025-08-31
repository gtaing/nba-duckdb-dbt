with mean_stats as (
  select 
  season_id,
  team,
  team_name,
  season,
  count(win_loss) filter (where win_loss = 'W') as wins,
  count(win_loss) filter (where win_loss = 'L') as losses,
  count(game_id) as total_games,
  {{ game_get_metric_mean('team_') }},
  {{ game_get_metric_mean('opponent_') }}
from {{ dbt_unit_testing.ref('stg_team_stats__opponents') }}
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

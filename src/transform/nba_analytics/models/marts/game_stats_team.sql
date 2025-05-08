WITH mean_stats as (
  SELECT 
  season_id,
  team,
  team_name,
  season,
  sum(case when win_loss = 'W' then 1 else 0 end) as wins,
  sum(case when win_loss = 'L' then 1 else 0 end) as losses,
  count(game_id) as total_games,
  {{ game_get_metric_mean('team_') }},
  {{ game_get_metric_mean('opponent_') }}
FROM {{ dbt_unit_testing.ref('stg_game_stats') }}
GROUP BY season_id, team, team_name, season
HAVING total_games = 82
ORDER BY season DESC
)
SELECT 
  m.*,
  {{ game_get_metric_net() }},
  {{ game_get_metric_rank('team_') }},
  {{ game_get_metric_rank('opponent_') }},
  {{ game_get_metric_rank('net_') }}
FROM mean_stats m

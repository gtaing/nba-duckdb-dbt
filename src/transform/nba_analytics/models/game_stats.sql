with seasons as (
  select 
    season_id,
    concat_ws('-', year(min(game_date)), year(max(game_date))) as season
  from {{ dbt_unit_testing.ref('stg_game_stats') }}
  GROUP BY season_id
),
game_stats as (
  select 
    stg.*,
    s.season
  from {{ dbt_unit_testing.ref('stg_game_stats') }} stg
  left join seasons as s
  on s.season_id = stg.season_id
)

SELECT 
  season_id,
  team,
  team_name,
  season,
  sum(case when win_loss = 'W' then 1 else 0 end) as wins,
  sum(case when win_loss = 'L' then 1 else 0 end) as losses,
  count(game_id) as total_games,
  {% for metric in games_get_metrics() %}
    round(mean({{ metric }}), 2) as {{ metric }}{% if not loop.last %},{% endif %}
  {% endfor %}
FROM game_stats
GROUP BY season_id, team, team_name, season
HAVING total_games = 82
ORDER BY season DESC



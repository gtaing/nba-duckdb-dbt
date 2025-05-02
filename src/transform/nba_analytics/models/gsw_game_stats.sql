SELECT 
  season_id,
  team_abbreviation_home,
  wl_home,
  ROUND(MEAN(fgm_home), 2) AS fgm_home,
  ROUND(MEAN(fga_home), 2) AS fga_home,
  ROUND(MEAN(fg_pct_home), 2) AS fg_pct_home,
  ROUND(MEAN(fg3m_home), 2) AS fg3m_home,
  ROUND(MEAN(fg3a_home), 2) AS fg3a_home,
  ROUND(MEAN(fg3_pct_home), 2) AS fg3_pct_home,
FROM {{ ref('stg_gsw_game_stats') }}
GROUP BY season_id, team_abbreviation_home, wl_home

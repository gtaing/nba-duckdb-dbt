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
        {{ games_rename_metrics('_home', '') }},
        {{ games_rename_metrics('_away', 'opponent_') }}
    from {{ source("raw", "game") }}
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
        {{ games_rename_metrics('_away', '') }},
        {{ games_rename_metrics('_home', 'opponent_') }}
    from {{ source("raw", "game") }}
)
SELECT * FROM home_games 
UNION 
SELECT * FROM away_games
WHERE YEAR(CAST(game_date AS DATE)) >= 2012
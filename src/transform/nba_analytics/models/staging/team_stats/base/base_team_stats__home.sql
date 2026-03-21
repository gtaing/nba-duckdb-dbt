WITH source AS (
    SELECT * FROM {{ source('raw', 'games') }}
)

, final AS (
    SELECT
        season_id
        , game_id
        , game_date
        , 'home' AS game_location
        , wl_home AS win_loss
        , team_abbreviation_home AS team
        , team_name_home AS team_name
        , team_abbreviation_away AS opponent
        , team_name_away AS opponent_name,
        {{ game_rename_metrics('_home', 'team_') }},
        {{ game_rename_metrics('_away', 'opponent_') }}
    FROM source
)

SELECT * FROM final

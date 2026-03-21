WITH source AS (
    SELECT * FROM {{ source('raw', 'games') }}
)

, final AS (
    SELECT
        season_id
        , game_id
        , game_date
        , 'away' AS game_location
        , wl_away AS win_loss
        , team_abbreviation_away AS team
        , team_name_away AS team_name
        , team_abbreviation_home AS opponent
        , team_name_home AS opponent_name,
        {{ game_rename_metrics('_away', 'team_') }},
        {{ game_rename_metrics('_home', 'opponent_') }}
    FROM source
)

SELECT * FROM final

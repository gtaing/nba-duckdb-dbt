with source as (
    select * from {{ dbt_unit_testing.source('raw', 'games') }}
),

final as (
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
        {{ game_rename_metrics('_home', 'opponent_') }}
    from source
)

select * from final
with source as (
    select * from {{ dbt_unit_testing.source('raw', 'games') }}
),

final as (
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
    from source
)

select * from final
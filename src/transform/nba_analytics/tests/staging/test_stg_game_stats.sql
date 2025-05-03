{{ config(tags=['unit-test']) }}

{% call dbt_unit_testing.test ('stg_game_stats', 'test_stg_game_stats') %}
    {% call dbt_unit_testing.mock_source('raw', 'game', {'input_format': 'csv'}) %}
    season_id,team_id_home,team_abbreviation_home,team_name_home,game_id,game_date,matchup_home,wl_home,min,fgm_home,fga_home,fg_pct_home,fg3m_home,fg3a_home,fg3_pct_home,ftm_home,fta_home,ft_pct_home,oreb_home,dreb_home,reb_home,ast_home,stl_home,blk_home,tov_home,pf_home,pts_home,plus_minus_home,video_available_home,team_id_away,team_abbreviation_away,team_name_away,matchup_away,wl_away,fgm_away,fga_away,fg_pct_away,fg3m_away,fg3a_away,fg3_pct_away,ftm_away,fta_away,ft_pct_away,oreb_away,dreb_away,reb_away,ast_away,stl_away,blk_away,tov_away,pf_away,pts_away,plus_minus_away,video_available_away,season_type
    22011,'1610612748','MIA','Miami Heat','0021100086','2012-01-04','MIA vs. IND','W',240,42.0,80.0,0.525,8.0,21.0,0.381,26.0,28.0,0.929,7.0,35.0,42.0,25.0,12.0,1.0,13.0,25.0,118.0,35,0,'1610612754','IND','Indiana Pacers','IND @ MIA','L',24.0,69.0,0.348,5.0,19.0,0.263,30.0,39.0,0.769,9.0,27.0,36.0,12.0,7.0,3.0,23.0,26.0,83.0,-35,0,'Regular Season'
    22011,'1610612759','SAS','San Antonio Spurs','0021100116','2012-01-07','SAS vs. DEN','W',240,49.0,89.0,0.551,9.0,20.0,0.45,14.0,18.0,0.778,15.0,23.0,38.0,27.0,6.0,5.0,16.0,19.0,121.0,4,0,'1610612743','DEN','Denver Nuggets','DEN @ SAS','L',46.0,81.0,0.568,8.0,16.0,0.5,17.0,26.0,0.654,10.0,23.0,33.0,25.0,9.0,4.0,15.0,17.0,117.0,-4,0,'Regular Season'
    {% endcall %}

    {% call dbt_unit_testing.expect({'input_format': 'csv'}) %}
    season_id,game_id,game_date,game_location,win_loss,team,team_name,opponent,opponent_name,pts,fgm,fga,fg_pct,fg3m,fg3a,fg3_pct,ftm,fta,ft_pct,oreb,dreb,reb,ast,opponent_pts,opponent_fgm,opponent_fga,opponent_fg_pct,opponent_fg3m,opponent_fg3a,opponent_fg3_pct,opponent_ftm,opponent_fta,opponent_ft_pct,opponent_oreb,opponent_dreb,opponent_reb,opponent_ast
    22011,'0021100086','2012-01-04','away','L','IND','Indiana Pacers','MIA','Miami Heat',83.0,24.0,69.0,0.35,5.0,19.0,0.26,30.0,39.0,0.77,9.0,27.0,36.0,12.0,118.0,42.0,80.0,0.53,8.0,21.0,0.38,26.0,28.0,0.93,7.0,35.0,42.0,25.0
    22011,'0021100116','2012-01-07','away','L','DEN','Denver Nuggets','SAS','San Antonio Spurs',117.0,46.0,81.0,0.57,8.0,16.0,0.5,17.0,26.0,0.65,10.0,23.0,33.0,25.0,121.0,49.0,89.0,0.55,9.0,20.0,0.45,14.0,18.0,0.78,15.0,23.0,38.0,27.0
    22011,'0021100086','2012-01-04','home','W','MIA','Miami Heat','IND','Indiana Pacers',118.0,42.0,80.0,0.53,8.0,21.0,0.38,26.0,28.0,0.93,7.0,35.0,42.0,25.0,83.0,24.0,69.0,0.35,5.0,19.0,0.26,30.0,39.0,0.77,9.0,27.0,36.0,12.0
    22011,'0021100116','2012-01-07','home','W','SAS','San Antonio Spurs','DEN','Denver Nuggets',121.0,49.0,89.0,0.55,9.0,20.0,0.45,14.0,18.0,0.78,15.0,23.0,38.0,27.0,117.0,46.0,81.0,0.57,8.0,16.0,0.5,17.0,26.0,0.65,10.0,23.0,33.0,25.0
    {% endcall %}

{% endcall %}
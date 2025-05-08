{% macro generate_test_cases(test_cases) %}
    {% for test_case in test_cases %}
        {{ test_case.season_id }},{{ test_case.game_id }},'{{ test_case.game_date }}','{{ test_case.game_location }}',
        '{{ test_case.win_loss }}','{{ test_case.team }}','{{ test_case.team_name }}','{{ test_case.opponent }}',
        '{{ test_case.opponent_name }}',{{ test_case.pts }},{{ test_case.fgm }},{{ test_case.fga }},
        {{ test_case.fg_pct }},{{ test_case.fg3m }},{{ test_case.fg3a }},{{ test_case.fg3_pct }},
        {{ test_case.ftm }},{{ test_case.fta }},{{ test_case.ft_pct }},{{ test_case.oreb }},
        {{ test_case.dreb }},{{ test_case.reb }},{{ test_case.ast }},{{ test_case.opponent_pts }},
        {{ test_case.opponent_fgm }},{{ test_case.opponent_fga }},{{ test_case.opponent_fg_pct }},
        {{ test_case.opponent_fg3m }},{{ test_case.opponent_fg3a }},{{ test_case.opponent_fg3_pct }},
        {{ test_case.opponent_ftm }},{{ test_case.opponent_fta }},{{ test_case.opponent_ft_pct }},
        {{ test_case.opponent_oreb }},{{ test_case.opponent_dreb }},{{ test_case.opponent_reb }},
        {{ test_case.opponent_ast }}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}
{% macro game_get_metrics() %}
    {% set metrics = ['pts', 'fgm', 'fga', 'fg_pct', 'fg3m', 'fg3a', 'fg3_pct', 'ftm', 'fta', 'ft_pct', 'oreb', 'dreb', 'reb', 'ast'] %}
    {{ return(metrics) }}
{% endmacro %}
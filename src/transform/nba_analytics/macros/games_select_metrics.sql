{% macro games_get_metrics() %}
    {% set metrics = [
        'pts', 'fgm', 'fga', 'fg_pct', 
        'fg3m', 'fg3a', 'fg3_pct', 
        'ftm', 'fta', 'ft_pct', 
        'oreb', 'dreb', 'reb', 'ast'
    ] %}
    {{ return(metrics) }}
{% endmacro %}

{% macro games_rename_metrics(prefix, alias_prefix='') %}
    {% set metrics = games_get_metrics() %}
    {% for metric in metrics %}
        {% if '_pct' in metric %}
        round({{ metric }}{{ prefix }}, 2) as {{ alias_prefix }}{{ metric }}
        {% else %}
        {{ metric }}{{ prefix }} as {{ alias_prefix }}{{ metric }}
        {% endif %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}

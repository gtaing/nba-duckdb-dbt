{% macro game_get_metric_net() %}
    {% set metrics = game_get_metrics() %}
    {% for metric in metrics%}
        round(team_{{ metric}} - opponent_{{ metric }}, 1) as net_{{ metric }}{% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}
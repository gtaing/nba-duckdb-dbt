{% macro  game_get_metric_rank(prefix) %}
    {% set metrics = game_get_metrics() %}
    {% for metric in metrics %}
        rank() over (partition by season_id order by {{prefix}}{{ metric }} desc) as {{prefix}}{{ metric }}_rank
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}
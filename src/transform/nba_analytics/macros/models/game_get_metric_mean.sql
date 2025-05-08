{% macro game_get_metric_mean(prefix) %}
  {% for metric in game_get_metrics() %}
    round(mean({{ prefix }}{{ metric }}), 1) as {{ prefix }}{{ metric }}{% if not loop.last %},{% endif %}
  {% endfor %}
{% endmacro %}
{% macro game_rename_metrics(prefix, alias_prefix='') %}
    {% set metrics = game_get_metrics() %}
    {% for metric in metrics %}
        {% if '_pct' in metric %}
        round({{ metric }}{{ prefix }}, 2) as {{ alias_prefix }}{{ metric }}
        {% else %}
        {{ metric }}{{ prefix }} as {{ alias_prefix }}{{ metric }}
        {% endif %}
        {% if not loop.last %},{% endif %}
    {% endfor %}
{% endmacro %}

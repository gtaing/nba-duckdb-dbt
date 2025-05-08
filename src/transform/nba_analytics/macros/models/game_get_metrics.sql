{% macro game_get_metrics() %}
    {% set metrics = dbt_utils.get_column_values(table=ref('metrics'), column='metric') %}
    {{ return(metrics) }}
{% endmacro %}
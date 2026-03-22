{% macro game_extract_season(game_date, season_id) %}

    {% set min_date_for_season = "min(" ~ game_date ~ ") OVER (PARTITION BY " ~ season_id ~ ")" %}
    {% set max_date_for_season = "max(" ~ game_date ~ ") OVER (PARTITION BY " ~ season_id ~ ")" %}

    concat_ws(
        '-',
        year({{ min_date_for_season }}),
        right(
            cast(
                year({{ max_date_for_season }}) AS VARCHAR
            ),
            2
        )
    )

{% endmacro %}
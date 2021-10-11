{% macro to_date(attribute) %}

{% if var("database") == 'snowflake' %}
    try_to_date({{ attribute }}, 'YYYYMMDD')
{% elif var("database") == 'sqlserver' %}
    try_convert(date, {{ attribute }}, 112)
{% endif %}

{% endmacro %}

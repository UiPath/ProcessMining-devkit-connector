{% macro to_time(attribute) %}

{% if var("database") == 'snowflake' %}
    try_to_time({{ attribute }}, 'HH24MISS')
{% elif var("database") == 'sqlserver' %}
    -- SQL server does not support converting 6 digits time format to time data type, use custom conversion.
    try_convert(time, concat(substring({{ attribute }}, 1, 2), ':', substring({{ attribute }}, 3, 2), ':', substring({{ attribute }}, 5, 2)), 8)
{% endif %}

{% endmacro %}

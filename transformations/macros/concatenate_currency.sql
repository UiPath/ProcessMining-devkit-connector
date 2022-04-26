{% macro concatenate_currency(field, parameter) %}

{# Use the target.type to make the macro database specific when needed. #}
{% if target.type == 'snowflake' %}
    concat({{ field }}, ' {{ parameter }}')
{% elif target.type == 'sqlserver' %}
    concat({{ field }}, ' {{ parameter }}')
{% endif %}

{% endmacro %}

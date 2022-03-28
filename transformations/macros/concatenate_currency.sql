{% macro concatenate_currency(attribute, parameter) %}

{# Use the target.type to make the macro database specific when needed. #}
{% if target.type == 'snowflake' %}
    concat({{ attribute }}, ' {{ parameter }}')
{% elif target.type == 'sqlserver' %}
    concat({{ attribute }}, ' {{ parameter }}')
{% endif %}

{% endmacro %}

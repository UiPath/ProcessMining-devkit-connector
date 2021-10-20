{% macro test_type_double(model, column_name, table, column) %}

select *
from Information_schema.Columns
where Information_schema.Columns."TABLE_SCHEMA" = '{{ var("schema") }}'
    and Information_schema.Columns."TABLE_NAME" = {{ table }}
    and Information_schema.Columns."COLUMN_NAME" = {{ column }}
{% if var("database") == 'snowflake' %}
    and Information_schema.Columns."DATA_TYPE" <> 'FLOAT'
{% elif var("database") == 'sqlserver' %}
    and Information_schema.Columns."DATA_TYPE" <> 'float'
{% endif %}

{% endmacro %}
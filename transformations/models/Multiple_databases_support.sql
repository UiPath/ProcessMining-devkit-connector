with Invoices_input as (
    select * from {{ ref('Invoices_input') }}
),

/* Illustration on how to implement multiple databases support in your dbt project. */
Multiple_databases_support as (
    select
        -- Convert one data type to another. For example, from double to string.
        -- Snowflake: to_varchar()
        -- SQL server: convert()
        {% if target.type == 'snowflake' %}
            to_varchar(Invoices_input."Price")
        {% elif target.type == 'sqlserver' %}
            convert(nvarchar(50), Invoices_input."Price")
        {% endif %}
        as "Price_converted",
        -- With a macro the code is more readable.
        {{ pm_utils.to_varchar('Invoices_input."Price"') }} as "Price_converted_with_macro",
        -- Implement your own macro when a macro is not available in pm-utils.
        {{ concatenate_currency('Invoices_input."Price"', 'dollar') }} as "Price_with_currency"
    from Invoices_input
)

select * from Multiple_databases_support

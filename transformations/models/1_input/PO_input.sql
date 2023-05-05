{% set source_table = source('sources', 'PO') %}

/* Input table for the purchase order entity containing purchase order properties. */
with PO_input as (
    select
        {{ pm_utils.mandatory(source_table, '"Created_at"', 'datetime') }} as "Created_at",
        {{ pm_utils.mandatory(source_table, '"Creator"') }} as "Creator",
        {{ pm_utils.mandatory(source_table, '"ID"') }} as "ID",
        {{ pm_utils.mandatory(source_table, '"Price"', 'double') }} as "Price"
    from {{ source_table }}
)

select * from PO_input

{% set source_table = source('sources', 'INV') %}

/* Input table for the invoices entity.
It contains invoice properties and to which purchase order it belongs to. */
with INV_input as (
    select
        {{ pm_utils.mandatory(source_table, '"Created_at"', 'datetime') }} as "Created_at",
        {{ pm_utils.mandatory(source_table, '"Creator"') }} as "Creator",
        {{ pm_utils.mandatory(source_table, '"ID"') }} as "ID",
        {{ pm_utils.mandatory(source_table, '"Paid_at"', 'datetime') }} as "Paid_at",
        {{ pm_utils.mandatory(source_table, '"Payment_due_date"', 'date') }} as "Payment_due_date",
        {{ pm_utils.mandatory(source_table, '"Price"', 'double') }} as "Price",
        {{ pm_utils.mandatory(source_table, '"Purchase_order_ID"') }} as "Purchase_order_ID"
    from {{ source_table }}
)

select * from INV_input

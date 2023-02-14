{{ config(
    pre_hook="{{ pm_utils.create_index(source('sources', 'INV')) }}"
) }}

with INV as (
    select * from {{ source('sources', 'INV') }}
),

/* Input table for the invoices entity.
It contains invoice properties and to which purchase order it belongs to. */
INV_input as (
    select
        {{ pm_utils.to_timestamp('INV."Created_at"') }} as "Created_at",
        {{ pm_utils.to_varchar('INV."Creator"') }} as "Creator",
        {{ pm_utils.to_varchar('INV."ID"') }} as "ID",
        {{ pm_utils.to_timestamp('INV."Paid_at"') }} as "Paid_at",
        {{ pm_utils.to_date('INV."Payment_due_date"') }} as "Payment_due_date",
        {{ pm_utils.to_double('INV."Price"') }} as "Price",
        {{ pm_utils.to_varchar('INV."Purchase_order_ID"') }} as "Purchase_order_ID"
    from INV
)

select * from INV_input

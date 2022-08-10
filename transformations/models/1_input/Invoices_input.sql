{{ config(
    pre_hook="{{ pm_utils.create_index('Invoices_raw') }}"
) }}

with Invoices_raw as (
    select * from {{ source(var("schema_sources"), 'Invoices_raw') }}
),

/* Input table for the invoices entity.
It contains invoice properties and to which purchase order it belongs to. */
Invoices_input as (
    select
        {{ pm_utils.to_timestamp('Invoices_raw."Created_at"') }} as "Created_at",
        {{ pm_utils.to_varchar('Invoices_raw."Creator"') }} as "Creator",
        {{ pm_utils.to_varchar('Invoices_raw."ID"') }} as "ID",
        {{ pm_utils.to_timestamp('Invoices_raw."Paid_at"') }} as "Paid_at",
        {{ pm_utils.to_date('Invoices_raw."Payment_due_date"') }} as "Payment_due_date",
        {{ pm_utils.to_double('Invoices_raw."Price"') }} as "Price",
        {{ pm_utils.to_varchar('Invoices_raw."Purchase_order_ID"') }} as "Purchase_order_ID"
    from Invoices_raw
)

select * from Invoices_input

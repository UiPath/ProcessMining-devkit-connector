with Invoices_raw as (
    select * from {{ source(var("schema_sources"), 'Invoices_raw') }}
),

/* Input table for the invoices entity.
It contains invoice properties and to which purchase order it belongs to. */
Invoices_input as (
    select
        -- Convert non-text fields to the correct data type.
        {{ pm_utils.to_timestamp('Invoices_raw."Created_at"') }} as "Created_at",
        Invoices_raw."Creator",
        Invoices_raw."ID",
        {{ pm_utils.to_timestamp('Invoices_raw."Paid_at"') }} as "Paid_at",
        {{ pm_utils.to_date('Invoices_raw."Payment_due_date"') }} as "Payment_due_date",
        {{ pm_utils.to_double('Invoices_raw."Price"') }} as "Price",
        Invoices_raw."Purchase_order_ID"
    from Invoices_raw
)

select * from Invoices_input

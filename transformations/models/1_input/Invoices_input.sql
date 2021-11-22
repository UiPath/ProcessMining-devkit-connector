with Raw_invoices as (
    select * from {{ source(var("schema_sources"), 'Raw_invoices') }}
),

/* Input table for the invoices entity.
It contains invoice properties and to which purchase order it belongs to. */
Invoices_input as (
    select
        -- Convert non-text fields to the correct data type.
        {{ pm_utils.to_timestamp('Raw_invoices."Created_at"') }} as "Created_at",
        Raw_invoices."Creator",
        Raw_invoices."ID",
        {{ pm_utils.to_timestamp('Raw_invoices."Paid_at"') }} as "Paid_at",
        {{ pm_utils.to_date('Raw_invoices."Payment_due_date"') }} as "Payment_due_date",
        {{ pm_utils.to_double('Raw_invoices."Price"') }} as "Price",
        Raw_invoices."Purchase_order_ID"
    from Raw_invoices
)

select * from Invoices_input

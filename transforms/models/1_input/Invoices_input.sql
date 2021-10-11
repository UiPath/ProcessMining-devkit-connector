with Raw_invoices as (
    select * from {{ source(var("schema"), 'Raw_invoices') }}
),

/* Input table for the invoices entity.
It contains invoice properties and to which purchase order it belongs to. */
Invoices_input as (
    select
        -- Convert non-text fields to the correct data type.
        try_convert(datetime, Raw_invoices."Created_at") as "Created_at",
        Raw_invoices."Creator",
        Raw_invoices."ID",
        try_convert(datetime, Raw_invoices."Paid_at") as "Paid_at",
        try_convert(date, Raw_invoices."Payment_due_date") as "Payment_due_date",
        try_convert(float, Raw_invoices."Price") as "Price",
        Raw_invoices."Purchase_order_ID"
    from Raw_invoices
)

select * from Invoices_input

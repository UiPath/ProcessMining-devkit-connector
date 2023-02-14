with INV_input as (
    select * from {{ ref('INV_input') }}
),

Users_base as (
    select * from {{ ref('Users_base') }}
),

/* Entity table of the invoice. */
Invoices as (
    select
        -- Key fields
        INV_input."ID" as "Invoice_ID",
        INV_input."Purchase_order_ID",
        -- Properties
        INV_input."Created_at",
        concat(INV_input."Creator", ' - ', Users_base."User_name") as "Creator",
        INV_input."Paid_at",
        INV_input."Payment_due_date",
        INV_input."Price",
        Users_base."Team"
    from INV_input
    -- Join the users table to enrich the user related properties with master data.
    left join Users_base
        on INV_input."Creator" = Users_base."ID"
)

select * from Invoices

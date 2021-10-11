with Invoices_input as (
    select * from {{ ref('Invoices_input') }}
),
Users as (
    select * from {{ ref('Users') }}
),

/* Entity table of the invoice. */
Invoices as (
    select
        -- Key fields
        Invoices_input."ID" as "Invoice_ID",
        Invoices_input."Purchase_order_ID",
        -- Properties
        Invoices_input."Created_at",
        concat(Invoices_input."Creator", ' - ', Users."User_name") as "Creator",
        Invoices_input."Paid_at",
        Invoices_input."Payment_due_date",
        Invoices_input."Price",
        Users."Team"
    from Invoices_input
    -- Join the users table to enrich the user related properties with master data.
    left join Users
        on Invoices_input."Creator" = Users."ID"
)

select * from Invoices

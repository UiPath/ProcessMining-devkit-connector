with PO_input as (
    select * from {{ ref('PO_input') }}
),

PO_status_input as (
    select * from {{ ref('PO_status_input') }}
),

Users_base as (
    select * from {{ ref('Users_base') }}
),

/* Entity table of the purchase order. */
Purchase_orders as (
    select
        -- Key fields
        PO_input."ID" as "Purchase_order_ID",
        -- Properties
        PO_input."Created_at",
        concat(PO_input."Creator", ' - ', Users_base."User_name") as "Creator",
        PO_input."Price",
        PO_status_input."Status",
        Users_base."Team"
    from PO_input
    -- Join the purchase order status table to have status information available.
    left join PO_status_input
        on PO_input."ID" = PO_status_input."ID"
    -- Join the users table to enrich the user related properties with master data.
    left join Users_base
        on PO_input."Creator" = Users_base."ID"
)

select * from Purchase_orders

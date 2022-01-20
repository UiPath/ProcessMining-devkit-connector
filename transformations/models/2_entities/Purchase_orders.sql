with Purchase_orders_input as (
    select * from {{ ref('Purchase_orders_input') }}
),
Purchase_orders_status as (
    select * from {{ ref('Purchase_orders_status') }}
),
Users as (
    select * from {{ ref('Users') }}
),

/* Entity table of the purchase order. */
Purchase_orders as (
    select
        -- Key fields
        Purchase_orders_input."ID" as "Purchase_order_ID",
        -- Properties
        Purchase_orders_input."Created_at",
        concat(Purchase_orders_input."Creator", ' - ', Users."User_name") as "Creator",
        Purchase_orders_input."Price",
        Purchase_orders_status."Status",
        Users."Team"
    from Purchase_orders_input
    -- Join the purchase order status table to have status information available.
    left join Purchase_orders_status
        on Purchase_orders_input."ID" = Purchase_orders_status."ID"
    -- Join the users table to enrich the user related properties with master data.
    left join Users
        on Purchase_orders_input."Creator" = Users."ID"
)

select * from Purchase_orders

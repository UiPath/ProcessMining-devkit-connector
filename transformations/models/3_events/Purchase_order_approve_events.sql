with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),
Purchase_order_approvals as (
    select * from {{ ref('Purchase_order_approvals') }}
),

/* Define the approval events for purchase orders that are available in the entity table. */
Purchase_order_approve_events as (
    select
        -- Mandatory event attributes
        Purchase_orders."Purchase_order_ID",
        concat('Approve order level ', Purchase_order_approvals."Level") as "Activity",
        Purchase_order_approvals."Approved_at" as "Event_end",
        -- Optional event attributes
        Purchase_order_approvals."Approved_by",
        Purchase_order_approvals."Team"
    from Purchase_orders
    -- Inner join to only define events for purchase orders in the entity table.
    inner join Purchase_order_approvals
        on Purchase_orders."Purchase_order_ID" = Purchase_order_approvals."Purchase_order_ID"
)

select * from Purchase_order_approve_events

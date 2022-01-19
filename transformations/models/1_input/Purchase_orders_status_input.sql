with Purchase_order_statuses_raw as (
    select * from {{ source(var("schema_sources"), 'Purchase_order_statuses_raw') }}
),

/* Status information related to the purchase order entity. */
Purchase_orders_status_input as (
    select
        Purchase_order_statuses_raw."ID",
        Purchase_order_statuses_raw."Status"
    from Purchase_order_statuses_raw
)

select * from Purchase_orders_status_input

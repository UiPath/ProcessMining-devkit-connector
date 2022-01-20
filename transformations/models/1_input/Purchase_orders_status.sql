with Purchase_orders_status_raw as (
    select * from {{ source(var("schema_sources"), 'Purchase_orders_status_raw') }}
),

/* Status information related to the purchase order entity. */
Purchase_orders_status as (
    select
        Purchase_orders_status_raw."ID",
        Purchase_orders_status_raw."Status"
    from Purchase_orders_status_raw
)

select * from Purchase_orders_status

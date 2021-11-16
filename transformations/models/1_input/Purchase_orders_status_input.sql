with Raw_purchase_orders_status as (
    select * from {{ source(var("schema"), 'Raw_purchase_orders_status_110k') }}
),

/* Status information related to the purchase order entity. */
Purchase_orders_status_input as (
    select
        Raw_purchase_orders_status."ID",
        Raw_purchase_orders_status."Status"
    from Raw_purchase_orders_status
)

select * from Purchase_orders_status_input

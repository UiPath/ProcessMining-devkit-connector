with Raw_purchase_orders as (
    select * from {{ source(var("schema_sources"), 'Raw_purchase_orders') }}
),

/* Input table for the purchase order entity containing purchase order properties. */
Purchase_orders_input as (
    select
        -- Convert non-text fields to the correct data type.
        {{ pm_utils.to_timestamp('Raw_purchase_orders."Created_at"') }} as "Created_at",
        Raw_purchase_orders."Creator",
        Raw_purchase_orders."ID",
        {{ pm_utils.to_double('Raw_purchase_orders."Price"') }} as "Price"
    from Raw_purchase_orders
)

select * from Purchase_orders_input

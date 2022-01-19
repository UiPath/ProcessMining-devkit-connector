with Purchase_orders_raw as (
    select * from {{ source(var("schema_sources"), 'Purchase_orders_raw') }}
),

/* Input table for the purchase order entity containing purchase order properties. */
Purchase_orders_input as (
    select
        -- Convert non-text fields to the correct data type.
        {{ pm_utils.to_timestamp('Purchase_orders_raw."Created_at"') }} as "Created_at",
        Purchase_orders_raw."Creator",
        Purchase_orders_raw."ID",
        {{ pm_utils.to_double('Purchase_orders_raw."Price"') }} as "Price"
    from Purchase_orders_raw
)

select * from Purchase_orders_input

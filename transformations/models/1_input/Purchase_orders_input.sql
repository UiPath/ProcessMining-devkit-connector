{{ config(
    pre_hook="{{ pm_utils.create_index(source('sources', 'Purchase_orders_raw')) }}"
) }}

with Purchase_orders_raw as (
    select * from {{ source('sources', 'Purchase_orders_raw') }}
),

/* Input table for the purchase order entity containing purchase order properties. */
Purchase_orders_input as (
    select
        {{ pm_utils.to_timestamp('Purchase_orders_raw."Created_at"') }} as "Created_at",
        {{ pm_utils.to_varchar('Purchase_orders_raw."Creator"') }} as "Creator",
        {{ pm_utils.to_varchar('Purchase_orders_raw."ID"') }} as "ID",
        {{ pm_utils.to_double('Purchase_orders_raw."Price"') }} as "Price"
    from Purchase_orders_raw
)

select * from Purchase_orders_input

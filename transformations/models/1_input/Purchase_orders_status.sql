{{ config(
    pre_hook="{{ pm_utils.create_index('Purchase_orders_status_raw') }}"
) }}

with Purchase_orders_status_raw as (
    select * from {{ source(var("schema_sources"), 'Purchase_orders_status_raw') }}
),

/* Status information related to the purchase order entity. */
Purchase_orders_status as (
    select
        {{ pm_utils.to_varchar('Purchase_orders_status_raw."ID"') }} as "ID",
        {{ pm_utils.to_varchar('Purchase_orders_status_raw."Status"') }} as "Status"
    from Purchase_orders_status_raw
)

select * from Purchase_orders_status

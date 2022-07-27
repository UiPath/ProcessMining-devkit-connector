with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),

-- The fields on this table should match the data model.
Cases_base as (
    select
        -- Mandatory
        Purchase_orders."Purchase_order_ID" as "Case_ID",
        -- Optional
        Purchase_orders."Status" as "Case_status",
        Purchase_orders."Price" as "Case_value"
    from Purchase_orders
)

select * from Cases_base

with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),

-- The fields on this table should match the data model.
Cases_base as (
    select
        -- Mandatory
        Purchase_rders."Purchase_order_ID" as "Case_ID",
        -- Optional
        Purchase_oders."Status" as "Case_status",
        Purchase_oders."Price" as "Case_value"
    from Purchase_orders
)

select * from Cases_base

with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),

-- The fields on this table should match the data model.
Cases as (
    select
        -- Mandatory
        Purchase_orders."Purchase_order_ID" as "Case ID",
        -- Optional
        Purchase_orders."Status" as "Case status",
        Purchase_orders."Price" as "Case value"
    from Purchase_orders
)

select * from Cases

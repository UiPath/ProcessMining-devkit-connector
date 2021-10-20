with Tags_preprocessing as (
    select * from {{ ref('Tags_preprocessing') }}
),

-- The fields on this table should match the data model.
Tags as (
    select
        Tags_preprocessing."Purchase_order_ID" as "Case ID",
        Tags_preprocessing."Tag"
    from Tags_preprocessing
)

select * from Tags

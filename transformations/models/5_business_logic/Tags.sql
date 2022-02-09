with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),
Invoices as (
    select * from {{ ref('Invoices') }}
),
Purchase_order_event_log as (
    select * from {{ ref('Purchase_order_event_log') }}
),

-- Preprocessing tables with supporting information to define tags.
Execute_order_events as (
    select
        Purchase_order_event_log."Purchase_order_ID"
    from Purchase_order_event_log
    where Purchase_order_event_log."Activity" = 'Execute order'
),
Approve_order_level_2_events as (
    select
        Purchase_order_event_log."Purchase_order_ID",
        Purchase_order_event_log."Event_end"
    from Purchase_order_event_log
    where Purchase_order_event_log."Activity" = 'Approve order level 2'
),
Min_and_max_event_ends as (
    select
        Purchase_order_event_log."Purchase_order_ID",
        min(Purchase_order_event_log."Event_end") as "Min_event_end",
        max(Purchase_order_event_log."Event_end") as "Max_event_end"
    from Purchase_order_event_log
    group by Purchase_order_event_log."Purchase_order_ID"
),

/* Table containing the tags for purchase orders.
A subset of the purchase order table has a specific tag.
Define the subsets with the where statement.
Union for all tags the subsets of the purchase order table together. */
Tags_preprocessing as (
    -- Invoice price differs from order price
    select
        Purchase_orders."Purchase_order_ID",
        'Invoice price differs from order price' as "Tag"
    from Purchase_orders
    left join Invoices
        on Purchase_orders."Purchase_order_ID" = Invoices."Purchase_order_ID"
    where Purchase_orders."Price" <> Invoices."Price"
    union all
    -- Order executed without approval
    select
        Execute_order_events."Purchase_order_ID",
        'Order executed without approval' as "Tag"
    from Execute_order_events
    left join Approve_order_level_2_events
        on Execute_order_events."Purchase_order_ID" = Approve_order_level_2_events."Purchase_order_ID"
    where Approve_order_level_2_events."Purchase_order_ID" is NULL
    -- Throughput time more than 10 days
    union all
    select Min_and_max_event_ends."Purchase_order_ID",
        'Throughput time more than 10 days' as "Tag"
    from Min_and_max_event_ends
    where datediff(day, Min_and_max_event_ends."Min_event_end", Min_and_max_event_ends."Max_event_end") > 10
),

-- The fields on this table should match the data model.
Tags as (
    select
        row_number() over (order by Tags_preprocessing."Purchase_order_ID") as "Tag_ID",
        Tags_preprocessing."Purchase_order_ID" as "Case_ID",
        Tags_preprocessing."Tag"
    from Tags_preprocessing
)

select * from Tags

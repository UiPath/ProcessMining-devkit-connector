with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),
Change_log as (
    select * from {{ ref('Change_log') }}
),

/* Define the change events for purchase orders that are available in the entity table.
The activity name is based on the field that is changed and on the old and new value. */
Purchase_order_change_events as (
    select
        -- Mandatory event attributes
        Purchase_orders."Purchase_order_ID",
        case
            when Change_log."Field" = 'Price'
            then 'Change order price'
            when Change_log."Field" = 'Status' and Change_log."New_value" = 'Ordered'
            then 'Execute order'
        end as "Activity",
        Change_log."Timestamp" as "Event_end",
        -- Optional event attributes
        concat('Change from ', Change_log."Old_value", ' to ', Change_log."New_value") as "Event_detail",
        Change_log."Team",
        Change_log."User"
    from Purchase_orders
    -- Inner join to only define events for purchase orders in the entity table.
    inner join Change_log
        on Purchase_orders."Purchase_order_ID" = Change_log."ID"
)

select * from Purchase_order_change_events
-- Filter the records for which an activity is defined.
where Purchase_order_change_events."Activity" is not NULL

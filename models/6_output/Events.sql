with Purchase_order_event_log as (
    select * from {{ ref('Purchase_order_event_log') }}
),

-- The fields on this table should match the data model.
Events as (
    select
        -- Mandatory
        Purchase_order_event_log."Purchase_order_ID" as "Case ID",
        Purchase_order_event_log."Activity",
        Purchase_order_event_log."Event_end" as "Event end",
        -- Optional
        Purchase_order_event_log."Event_detail" as "Event detail",
        Purchase_order_event_log."Event_ID" as "Event ID",
        Purchase_order_event_log."Team",
        Purchase_order_event_log."User"
    from Purchase_order_event_log
)

select * from Events

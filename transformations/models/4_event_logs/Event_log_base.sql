with Purchase_order_event_log as (
    select * from {{ ref('Purchase_order_event_log') }}
),

Automation_estimates_input as (
    select * from {{ ref('Automation_estimates_input') }}
),

-- The fields on this table should match the data model.
Event_log_base as (
    select
        -- Mandatory
        Purchase_order_event_log."Event_ID",
        Purchase_order_event_log."Purchase_order_ID" as "Case_ID",
        Purchase_order_event_log."Activity",
        Purchase_order_event_log."Event_end",
        -- Optional
        Automation_estimates_input."Event_cost",
        Purchase_order_event_log."Event_detail",
        Automation_estimates_input."Event_processing_time",
        Purchase_order_event_log."Team",
        Purchase_order_event_log."User"
    from Purchase_order_event_log
    left join Automation_estimates_input
        on Purchase_order_event_log."Activity" = Automation_estimates_input."Activity"
)

select * from Event_log_base

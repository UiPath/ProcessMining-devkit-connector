with Purchase_order_event_log as (
    select * from {{ ref('Purchase_order_event_log') }}
),

Activity_configuration as (
    select * from {{ ref('Activity_configuration') }}
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
        Activity_configuration."Activity_order",
        Purchase_order_event_log."Event_detail",
        Purchase_order_event_log."Team",
        Purchase_order_event_log."User"
    from Purchase_order_event_log
    left join Activity_configuration
        on Purchase_order_event_log."Activity" = Activity_configuration."Activity"
)

select * from Event_log_base

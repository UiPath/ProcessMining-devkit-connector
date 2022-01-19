with Purchase_order_event_log_preprocessing as (
    select * from {{ ref('Purchase_order_event_log_preprocessing') }}
),
Events_base as (
    select * from {{ ref('Events_base') }}
),

/* Table containing a record for each event in the purchase order end to end event log. 
Based on the event ID the event attributes are added to the event log. */
Purchase_order_event_log as (
    select
        -- Mandatory event attributes
        Purchase_order_event_log_preprocessing."Purchase_order_ID",
        Events_base."Activity",
        Events_base."Event_end",
        -- Optional event attributes
        Events_base."Event_detail",
        Events_base."Team",
        Events_base."User"
    from Purchase_order_event_log_preprocessing
    inner join Events_base
        on Purchase_order_event_log_preprocessing."Event_ID" = Events_base."Event_ID"
)

select *,
    -- An event ID is generated to define the due dates.
    row_number() over (order by Purchase_order_event_log."Event_end") as "Event_ID"
from Purchase_order_event_log

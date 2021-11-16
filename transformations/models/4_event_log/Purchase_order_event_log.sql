{{ config(materialized = 'incremental') }}

with Purchase_order_event_log_preprocessing as (
    select * from {{ ref('Purchase_order_event_log_preprocessing') }}
),
Events_all as (
    select *,
    -- An event ID is generated to join event properties to the event log.
    row_number() over (order by "Event_end") as "Event_ID"
    from {{ ref('Events_all') }}
    {% if is_incremental() %}
        where "Event_end" > (select max("Event_end") from {{ this }})
    {% endif %}
),

/* Table containing a record for each event in the purchase order end to end event log. 
Based on the event ID the event attributes are added to the event log. */
Purchase_order_event_log as (
    select
        -- Mandatory event attributes
        Purchase_order_event_log_preprocessing."Purchase_order_ID",
        Events_all."Activity",
        Events_all."Event_end",
        -- Optional event attributes
        Events_all."Event_detail",
        Events_all."Team",
        Events_all."User"
    from Purchase_order_event_log_preprocessing
    inner join Events_all
        on Purchase_order_event_log_preprocessing."Event_ID" = Events_all."Event_ID"
)

select * from Purchase_order_event_log

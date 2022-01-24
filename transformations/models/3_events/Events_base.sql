with Invoice_create_events as (
    select * from {{ ref('Invoice_create_events') }}
),
Invoice_payment_events as (
    select * from {{ ref('Invoice_payment_events') }}
),
Purchase_order_approve_events as (
    select * from {{ ref('Purchase_order_approve_events') }}
),
Purchase_order_change_events as (
    select * from {{ ref('Purchase_order_change_events') }}
),
Purchase_order_create_events as (
    select * from {{ ref('Purchase_order_create_events') }}
),

/* Union all separate events table into one set of distinct events.
This events table is used as a base for the event log.
The columns on each of the events tables should be exactly the same to union them. */
Events_base as (
    select
        -- Mandatory event attributes
        Invoice_create_events."Activity",
        Invoice_create_events."Event_end",
        Invoice_create_events."Invoice_ID",
        NULL as "Purchase_order_ID",
        -- Optional event attributes
        Invoice_create_events."Event_detail",
        Invoice_create_events."Team",
        Invoice_create_events."Creator" as "User"
    from Invoice_create_events
    union all
    select
        -- Mandatory event attributes
        Invoice_payment_events."Activity",
        Invoice_payment_events."Event_end",
        Invoice_payment_events."Invoice_ID",
        NULL as "Purchase_order_ID",
        -- Optional event attributes
        Invoice_payment_events."Event_detail",
        Invoice_payment_events."Team",
        Invoice_payment_events."Creator" as "User"
    from Invoice_payment_events
    union all
    select
        -- Mandatory event attributes
        Purchase_order_approve_events."Activity",
        Purchase_order_approve_events."Event_end",
        NULL as "Invoice_ID",
        Purchase_order_approve_events."Purchase_order_ID",
        -- Optional event attributes
        NULL as "Event_detail",
        Purchase_order_approve_events."Team",
        Purchase_order_approve_events."Approved_by" as "User"
    from Purchase_order_approve_events
    union all
    select
        -- Mandatory event attributes
        Purchase_order_change_events."Activity",
        Purchase_order_change_events."Event_end",
        NULL as "Invoice_ID",
        Purchase_order_change_events."Purchase_order_ID",
        -- Optional event attributes
        Purchase_order_change_events."Event_detail",
        Purchase_order_change_events."Team",
        Purchase_order_change_events."User"
    from Purchase_order_change_events
    union all
    select
        -- Mandatory event attributes
        Purchase_order_create_events."Activity",
        Purchase_order_create_events."Event_end",
        NULL as "Invoice_ID",
        Purchase_order_create_events."Purchase_order_ID",
        -- Optional event attributes
        NULL as "Event_detail",
        Purchase_order_create_events."Team",
        Purchase_order_create_events."Creator" as "User"
    from Purchase_order_create_events
)

select *,
    -- An event ID is generated to join event properties to the event log.
    row_number() over (order by Events_base."Event_end") as "Event_ID_internal"
from Events_base

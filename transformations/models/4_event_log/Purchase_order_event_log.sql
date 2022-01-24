with Entity_relations as (
    select * from {{ ref('Entity_relations') }}
),
Events_base as (
    select * from {{ ref('Events_base') }}
),

-- Supporting table to get the distinct purchase orders in the entity relation table.
Entity_relations_distinct_purchase_orders as (
    select
        Entity_relations."Purchase_order_ID"
    from Entity_relations
    group by Entity_relations."Purchase_order_ID"
),

-- Supporting table to get the distinct invoices per purchase order in the entity relation table.
Entity_relations_distinct_invoices as (
    select
        Entity_relations."Purchase_order_ID",
        Entity_relations."Invoice_ID"
    from Entity_relations
    group by Entity_relations."Purchase_order_ID", Entity_relations."Invoice_ID"
),

-- In the purchase order event log, each event is associated with one purchase order.
-- Get the events of purchase orders and invoices once per purchase order.
Purchase_order_event_log_preprocessing as (
    -- Purchase order events
    select
        Events_base."Event_ID_internal",
        Entity_relations_distinct_purchase_orders."Purchase_order_ID"
    from Events_base
    inner join Entity_relations_distinct_purchase_orders
        on Events_base."Purchase_order_ID" = Entity_relations_distinct_purchase_orders."Purchase_order_ID"
    union all
    -- Invoice events
    select
        Events_base."Event_ID_internal",
        Entity_relations_distinct_invoices."Purchase_order_ID"
    from Events_base
    inner join Entity_relations_distinct_invoices
        on Events_base."Invoice_ID" = Entity_relations_distinct_invoices."Invoice_ID"
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
        on Purchase_order_event_log_preprocessing."Event_ID_internal" = Events_base."Event_ID_internal"
)

select *,
    -- An event ID is generated to define the due dates.
    row_number() over (order by Purchase_order_event_log."Event_end") as "Event_ID"
from Purchase_order_event_log

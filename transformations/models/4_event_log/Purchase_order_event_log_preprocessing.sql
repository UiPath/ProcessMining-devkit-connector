with Entity_relations as (
    select * from {{ ref('Entity_relations') }}
),
Events_all as (
    select *,
    -- An event ID is generated to join event properties to the event log.
    row_number() over (order by "Event_end") as "Event_ID"
    from {{ ref('Events_all') }}
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
        Events_all."Event_ID",
        Entity_relations_distinct_purchase_orders."Purchase_order_ID"
    from Events_all
    inner join Entity_relations_distinct_purchase_orders
        on Events_all."Purchase_order_ID" = Entity_relations_distinct_purchase_orders."Purchase_order_ID"
    union all
    -- Invoice events
    select
        Events_all."Event_ID",
        Entity_relations_distinct_invoices."Purchase_order_ID"
    from Events_all
    inner join Entity_relations_distinct_invoices
        on Events_all."Invoice_ID" = Entity_relations_distinct_invoices."Invoice_ID"
)

select * from Purchase_order_event_log_preprocessing

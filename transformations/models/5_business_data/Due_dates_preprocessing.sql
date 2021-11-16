with Purchase_order_event_log as (
    select *,
    -- An event ID is generated to define the due dates.
    row_number() over (order by "Event_end") as "Event_ID"
    from {{ ref('Purchase_order_event_log') }}
),
Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),
Invoices as (
    select * from {{ ref('Invoices') }}
),

/* Table containing the due dates for the purchase order event log.
The implemented due date is the 'Payment due date' related to the 'Pay invoice' event. */
Due_dates as (
    select
        Purchase_order_event_log."Event_ID",
        'Payment due date' as "Due_date",
        Purchase_order_event_log."Event_end" as "Actual_date",
        Invoices."Payment_due_date" as "Expected_date"
    from Purchase_order_event_log
    -- Get the payment due date from the invoices table.
    -- Invoice information can be made available on this table via the purchase order ID of the event.
    left join Purchase_orders
        on Purchase_order_event_log."Purchase_order_ID" = Purchase_orders."Purchase_order_ID"
    left join Invoices
        on Purchase_orders."Purchase_order_ID" = Invoices."Purchase_order_ID"
    where Purchase_order_event_log."Activity" = 'Pay invoice'
)

select * from Due_dates

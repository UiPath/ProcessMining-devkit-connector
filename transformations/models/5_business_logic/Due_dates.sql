with Purchase_order_event_log as (
    select * from {{ ref('Purchase_order_event_log') }}
),
Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),
Invoices as (
    select * from {{ ref('Invoices') }}
),

/* Table containing the due dates for the purchase order event log.
The implemented due date is the 'Payment due date' related to the 'Pay invoice' event. */
Due_dates_preprocessing as (
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
),

-- The fields on this table should match the data model.
Due_dates as (
    select
        Due_dates_preprocessing."Event_ID",
        Due_dates_preprocessing."Due_date",
        Due_dates_preprocessing."Actual_date",
        Due_dates_preprocessing."Expected_date"
    from Due_dates_preprocessing
)

select * from Due_dates
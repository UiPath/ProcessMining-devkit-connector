with Invoices as (
    select * from {{ ref('Invoices') }}
),

/* Payment events are defined based on the payment timestamp on the invoice entity table.
Only define events for the invoices that are already paid. */
Invoice_payment_events as (
    select
        -- Mandatory event attributes
        Invoices."Invoice_ID",
        'Pay invoice' as "Activity",
        Invoices."Paid_at" as "Event_end",
        -- Optional event attributes
        case
            when {{ pm_utils.date_from_timestamp('Invoices."Paid_at"') }} <= Invoices."Payment_due_date"
            then 'Payment on time'
            else 'Payment overdue'
        end as "Event_detail",
        Invoices."Creator",
        Invoices."Team"
    from Invoices
    -- Filter the records that have a payment timestamp.
    where Invoices."Paid_at" is not NULL
)

select * from Invoice_payment_events

with Invoices as (
    select * from {{ ref('Invoices') }}
),

/* Create events are defined based on the creation timestamp on the entity table.
Every entity has exactly one create event. */
Invoice_create_events as (
    select
        -- Mandatory event attributes
        Invoices."Invoice_ID",
        'Enter invoice' as "Activity",
        Invoices."Created_at" as "Event_end",
        -- Optional event attributes
        Invoices."Creator",
        concat('Invoice price ', Invoices."Price") as "Event_detail",
        Invoices."Team"
    from Invoices
)

select * from Invoice_create_events

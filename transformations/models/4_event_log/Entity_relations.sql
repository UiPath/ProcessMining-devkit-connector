with Invoices as (
    select * from {{ ref('Invoices') }}
),
Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),

/* Table containing the relations between entities in the process.
Each record in this table describes two entities that are related to each other based on their IDs.
All purchase orders are included, because we create the purchase order end to end event log.
Invoices are joined with a left join to include the invoices related to purchase orders. */
Entity_relations as (
    select
        Purchase_orders."Purchase_order_ID",
        Invoices."Invoice_ID"
    from Purchase_orders
    left join Invoices
        on Purchase_orders."Purchase_order_ID" = Invoices."Purchase_order_ID"
)

select * from Entity_relations

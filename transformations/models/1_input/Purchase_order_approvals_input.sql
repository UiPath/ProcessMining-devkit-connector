with Purchase_order_approvals_raw as (
    select * from {{ source(var("schema_sources"), 'Purchase_order_approvals_raw') }}
),

/* Transaction log of purchase order approvals.
The approved purchase order is identified by the ID. */
Purchase_order_approvals_input as (
    select
        {{ pm_utils.to_timestamp('Purchase_order_approvals_raw."Approved_at"') }} as "Approved_at",
        Purchase_order_approvals_raw."Approved_by",
        Purchase_order_approvals_raw."ID",
        Purchase_order_approvals_raw."Level"
    from Purchase_order_approvals_raw
)

select * from Purchase_order_approvals_input

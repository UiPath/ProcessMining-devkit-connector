with PO_approvals_input as (
    select * from {{ ref('PO_approvals_input') }}
),

Users_base as (
    select * from {{ ref('Users_base') }}
),

/* Transaction log to be used as base for approval events. */
Purchase_order_approvals as (
    select
        -- Key fields
        PO_approvals_input."ID" as "Purchase_order_ID",
        -- Properties
        PO_approvals_input."Approved_at",
        concat(PO_approvals_input."Approved_by", ' - ', Users_base."User_name") as "Approved_by",
        PO_approvals_input."Level",
        Users_base."Team"
    from PO_approvals_input
    -- Join the users table to enrich the user related properties with master data.
    left join Users_base
        on PO_approvals_input."Approved_by" = Users_base."ID"
)

select * from Purchase_order_approvals

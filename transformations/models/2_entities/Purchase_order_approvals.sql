{{ config(materialized = 'incremental') }}

with Purchase_order_approvals_input as (
    select * from {{ ref('Purchase_order_approvals_input') }}
    {% if is_incremental() %}
        where "Approved_at" > (select max("Approved_at") from {{ this }})
    {% endif %}
),
Users as (
    select * from {{ ref('Users') }}
),

/* Transaction log to be used as base for approval events. */
Purchase_order_approvals as (
    select
        -- Key fields
        Purchase_order_approvals_input."ID" as "Purchase_order_ID",
        -- Properties
        Purchase_order_approvals_input."Approved_at",
        concat(Purchase_order_approvals_input."Approved_by", ' - ', Users."User_name") as "Approved_by",
        Purchase_order_approvals_input."Level",
        Users."Team"
    from Purchase_order_approvals_input
    -- Join the users table to enrich the user related properties with master data.
    left join Users
        on Purchase_order_approvals_input."Approved_by" = Users."ID"
)

select * from Purchase_order_approvals

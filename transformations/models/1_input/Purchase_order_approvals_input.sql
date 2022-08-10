{{ config(
    pre_hook="{{ pm_utils.create_index('Purchase_order_approvals_raw') }}"
) }}

with Purchase_order_approvals_raw as (
    select * from {{ source(var("schema_sources"), 'Purchase_order_approvals_raw') }}
),

/* Transaction log of purchase order approvals.
The approved purchase order is identified by the ID. */
Purchase_order_approvals_input as (
    select
        {{ pm_utils.to_timestamp('Purchase_order_approvals_raw."Approved_at"') }} as "Approved_at",
        {{ pm_utils.to_varchar('Purchase_order_approvals_raw."Approved_by"') }} as "Approved_by",
        {{ pm_utils.to_varchar('Purchase_order_approvals_raw."ID"') }} as "ID",
        {{ pm_utils.to_varchar('Purchase_order_approvals_raw."Level"') }} as "Level"
    from Purchase_order_approvals_raw
)

select * from Purchase_order_approvals_input

{{ config(
    pre_hook="{{ pm_utils.create_index(source('sources', 'PO_approvals')) }}"
) }}

with PO_approvals as (
    select * from {{ source('sources', 'PO_approvals') }}
),

/* Transaction log of purchase order approvals.
The approved purchase order is identified by the ID. */
PO_approvals_input as (
    select
        {{ pm_utils.to_timestamp('PO_approvals."Approved_at"') }} as "Approved_at",
        {{ pm_utils.to_varchar('PO_approvals."Approved_by"') }} as "Approved_by",
        {{ pm_utils.to_varchar('PO_approvals."ID"') }} as "ID",
        {{ pm_utils.to_varchar('PO_approvals."Level"') }} as "Level"
    from PO_approvals
)

select * from PO_approvals_input

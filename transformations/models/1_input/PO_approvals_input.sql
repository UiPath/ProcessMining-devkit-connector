{% set source_table = source('sources', 'PO_approvals') %}

/* Transaction log of purchase order approvals.
The approved purchase order is identified by the ID. */
with PO_approvals_input as (
    select
        {{ pm_utils.mandatory(source_table, '"Approved_at"', 'datetime') }} as "Approved_at",
        {{ pm_utils.mandatory(source_table, '"Approved_by"') }} as "Approved_by",
        {{ pm_utils.mandatory(source_table, '"ID"') }} as "ID",
        {{ pm_utils.mandatory(source_table, '"Level"') }} as "Level"
    from {{ source_table }}
)

select * from PO_approvals_input

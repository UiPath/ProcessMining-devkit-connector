{% set source_table = source('sources', 'PO_status') %}

/* Status information related to the purchase order entity. */
with PO_status_input as (
    select
        {{ pm_utils.mandatory(source_table, '"ID"') }} as "ID",
        {{ pm_utils.mandatory(source_table, '"Status"') }} as "Status"
    from {{ source_table }}
)

select * from PO_status_input

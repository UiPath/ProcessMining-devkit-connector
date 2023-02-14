{{ config(
    pre_hook="{{ pm_utils.create_index(source('sources', 'PO_status')) }}"
) }}

with PO_status as (
    select * from {{ source('sources', 'PO_status') }}
),

/* Status information related to the purchase order entity. */
PO_status_input as (
    select
        {{ pm_utils.to_varchar('PO_status."ID"') }} as "ID",
        {{ pm_utils.to_varchar('PO_status."Status"') }} as "Status"
    from PO_status
)

select * from PO_status_input

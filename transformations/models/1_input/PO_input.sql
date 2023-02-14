{{ config(
    pre_hook="{{ pm_utils.create_index(source('sources', 'PO')) }}"
) }}

with PO as (
    select * from {{ source('sources', 'PO') }}
),

/* Input table for the purchase order entity containing purchase order properties. */
PO_input as (
    select
        {{ pm_utils.to_timestamp('PO."Created_at"') }} as "Created_at",
        {{ pm_utils.to_varchar('PO."Creator"') }} as "Creator",
        {{ pm_utils.to_varchar('PO."ID"') }} as "ID",
        {{ pm_utils.to_double('PO."Price"') }} as "Price"
    from PO
)

select * from PO_input

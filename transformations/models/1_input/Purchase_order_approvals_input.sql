{{ config(materialized = 'incremental') }}

with Raw_purchase_order_approvals as (
    select * from {{ source(var("schema"), 'Raw_purchase_order_approvals_110k') }}
    {% if is_incremental() %}
        where {{ to_timestamp('"Approved_at"') }} > (select max("Approved_at") from {{ this }})
    {% endif %}
),

/* Transaction log of purchase order approvals.
The approved purchase order is identified by the ID. */
Purchase_order_approvals_input as (
    select
        {{ to_timestamp('Raw_purchase_order_approvals."Approved_at"') }} as "Approved_at",
        Raw_purchase_order_approvals."Approved_by",
        Raw_purchase_order_approvals."ID",
        Raw_purchase_order_approvals."Level"
    from Raw_purchase_order_approvals
)

select * from Purchase_order_approvals_input

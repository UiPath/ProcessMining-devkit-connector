{{ config(
    pre_hook="{{ pm_utils.create_index(source('sources', 'Transaction_history')) }}"
) }}

with Transaction_history as (
    select * from {{ source('sources', 'Transaction_history') }}
),

/* Transaction log describing changes on entities identified by the ID.
The change is defined by the Field in combination with the New_value and Old_value. */
Transaction_history_input as (
    select
        {{ pm_utils.to_varchar('Transaction_history."Field"') }} as "Field",
        {{ pm_utils.to_varchar('Transaction_history."ID"') }} as "ID",
        {{ pm_utils.to_varchar('Transaction_history."New_value"') }} as "New_value",
        {{ pm_utils.to_varchar('Transaction_history."Old_value"') }} as "Old_value",
        {{ pm_utils.to_timestamp('Transaction_history."Timestamp"') }} as "Timestamp",
        {{ pm_utils.to_varchar('Transaction_history."User"') }} as "User"
    from Transaction_history
)

select * from Transaction_history_input

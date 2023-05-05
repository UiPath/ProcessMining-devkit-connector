{% set source_table = source('sources', 'Transaction_history') %}

/* Transaction log describing changes on entities identified by the ID.
The change is defined by the Field in combination with the New_value and Old_value. */
with Transaction_history_input as (
    select
        {{ pm_utils.mandatory(source_table, '"Field"') }} as "Field",
        {{ pm_utils.mandatory(source_table, '"ID"') }} as "ID",
        {{ pm_utils.mandatory(source_table, '"New_value"') }} as "New_value",
        {{ pm_utils.mandatory(source_table, '"Old_value"') }} as "Old_value",
        {{ pm_utils.mandatory(source_table, '"Timestamp"', 'datetime') }} as "Timestamp",
        {{ pm_utils.mandatory(source_table, '"User"') }} as "User"
    from {{ source_table }}
)

select * from Transaction_history_input

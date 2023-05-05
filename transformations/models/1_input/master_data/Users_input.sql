{% set source_table = source('sources', 'Users') %}

/* Master data table containing information about users.
The user is identified by the ID. */
with Users_input as (
    select
        {{ pm_utils.mandatory(source_table, '"First_name"') }} as "First_name",
        {{ pm_utils.mandatory(source_table, '"ID"') }} as "ID",
        {{ pm_utils.mandatory(source_table, '"Last_name"') }} as "Last_name",
        {{ pm_utils.mandatory(source_table, '"Team"') }} as "Team"
    from {{ source_table }}
)

select * from Users_input

with Users_raw as (
    select * from {{ source(var("schema_sources"), 'Users_raw') }}
),

/* Master data table containing information about users.
The user is identified by the ID. */
Users_input as (
    select
        {{ pm_utils.to_varchar('Users_raw."First_name"') }} as "First_name",
        {{ pm_utils.to_varchar('Users_raw."ID"') }} as "ID",
        {{ pm_utils.to_varchar('Users_raw."Last_name"') }} as "Last_name",
        {{ pm_utils.to_varchar('Users_raw."Team"') }} as "Team"
    from Users_raw
)

select * from Users_input

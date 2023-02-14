with Users as (
    select * from {{ source('sources', 'Users') }}
),

/* Master data table containing information about users.
The user is identified by the ID. */
Users_input as (
    select
        {{ pm_utils.to_varchar('Users."First_name"') }} as "First_name",
        {{ pm_utils.to_varchar('Users."ID"') }} as "ID",
        {{ pm_utils.to_varchar('Users."Last_name"') }} as "Last_name",
        {{ pm_utils.to_varchar('Users."Team"') }} as "Team"
    from Users
)

select * from Users_input

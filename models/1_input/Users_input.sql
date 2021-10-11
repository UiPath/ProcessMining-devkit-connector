with Raw_users as (
    select * from {{ source(var("schema"), 'Raw_users') }}
),

/* Master data table containing information about users. 
The user is identified by the ID. */
Users_input as (
    select
        Raw_users."First_name",
        Raw_users."ID",
        Raw_users."Last_name",
        Raw_users."Team"
    from Raw_users
)

select * from Users_input

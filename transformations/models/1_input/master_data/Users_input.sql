with Users_raw as (
    select * from {{ source(var("schema_sources"), 'Users_raw') }}
),

/* Master data table containing information about users. 
The user is identified by the ID. */
Users_input as (
    select
        Users_raw."First_name",
        Users_raw."ID",
        Users_raw."Last_name",
        Users_raw."Team"
    from Users_raw
)

select * from Users_input

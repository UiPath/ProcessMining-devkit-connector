with Users_input as (
    select * from {{ ref('Users_input') }}
),

/* Master data table of the user.
The first and last name of the user are concatenated to get one user name attribute. */
Users as (
    select
        -- Key fields
        Users_input."ID",
        -- Properties
        Users_input."Team",
        concat(Users_input."First_name", ' ', Users_input."Last_name") as "User_name"
    from Users_input
)

select * from Users

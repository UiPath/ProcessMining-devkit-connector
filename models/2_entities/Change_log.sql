with Change_log_input as (
    select * from {{ ref('Change_log_input') }}
),
Users as (
    select * from {{ ref('Users') }}
),

/* Transaction log to be used as base for change events. */
Change_log as (
    select
        -- Key fields
        Change_log_input."ID",
        -- Properties
        Change_log_input."Field",
        Change_log_input."New_value",
        Change_log_input."Old_value",
        Users."Team",
        Change_log_input."Timestamp",
        concat(Change_log_input."User", ' - ', Users."User_name") as "User"
    from Change_log_input
    -- Join the users table to enrich the user related properties with master data.
    left join Users
        on Change_log_input."User" = Users."ID"
)

select * from Change_log

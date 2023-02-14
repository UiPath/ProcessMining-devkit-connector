with Transaction_history_input as (
    select * from {{ ref('Transaction_history_input') }}
),

Users_base as (
    select * from {{ ref('Users_base') }}
),

/* Transaction log to be used as base for change events. */
Change_log as (
    select
        -- Key fields
        Transaction_history_input."ID",
        -- Properties
        Transaction_history_input."Field",
        Transaction_history_input."New_value",
        Transaction_history_input."Old_value",
        Users_base."Team",
        Transaction_history_input."Timestamp",
        concat(Transaction_history_input."User", ' - ', Users_base."User_name") as "User"
    from Transaction_history_input
    -- Join the users table to enrich the user related properties with master data.
    left join Users_base
        on Transaction_history_input."User" = Users_base."ID"
)

select * from Change_log

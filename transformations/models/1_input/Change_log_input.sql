with Change_log_raw as (
    select * from {{ source(var("schema_sources"), 'Change_log_raw') }}
),

/* Transaction log describing changes on entities identified by the ID.
The change is defined by the Field in combination with the New_value and Old_value. */
Change_log_input as (
    select
        -- Convert non-text fields to the correct data type.
        Change_log_raw."Field",
        Change_log_raw."ID",
        Change_log_raw."New_value",
        Change_log_raw."Old_value",
        {{ pm_utils.to_timestamp('Change_log_raw."Timestamp"') }} as "Timestamp",
        Change_log_raw."User"
    from Change_log_raw
)

select * from Change_log_input

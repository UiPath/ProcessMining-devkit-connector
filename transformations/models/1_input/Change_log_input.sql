with Raw_change_log as (
    select * from {{ source(var("schema_sources"), 'Raw_change_log') }}
),

/* Transaction log describing changes on entities identified by the ID.
The change is defined by the Field in combination with the New_value and Old_value. */
Change_log_input as (
    select
        -- Convert non-text fields to the correct data type.
        Raw_change_log."Field",
        Raw_change_log."ID",
        Raw_change_log."New_value",
        Raw_change_log."Old_value",
        {{ pm_utils.to_timestamp('Raw_change_log."Timestamp"') }} as "Timestamp",
        Raw_change_log."User"
    from Raw_change_log
)

select * from Change_log_input

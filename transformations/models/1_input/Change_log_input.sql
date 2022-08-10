{{ config(
    pre_hook="{{ pm_utils.create_index('Change_log_raw') }}"
) }}

with Change_log_raw as (
    select * from {{ source(var("schema_sources"), 'Change_log_raw') }}
),

/* Transaction log describing changes on entities identified by the ID.
The change is defined by the Field in combination with the New_value and Old_value. */
Change_log_input as (
    select
        {{ pm_utils.to_varchar('Change_log_raw."Field"') }} as "Field",
        {{ pm_utils.to_varchar('Change_log_raw."ID"') }} as "ID",
        {{ pm_utils.to_varchar('Change_log_raw."New_value"') }} as "New_value",
        {{ pm_utils.to_varchar('Change_log_raw."Old_value"') }} as "Old_value",
        {{ pm_utils.to_timestamp('Change_log_raw."Timestamp"') }} as "Timestamp",
        {{ pm_utils.to_varchar('Change_log_raw."User"') }} as "User"
    from Change_log_raw
)

select * from Change_log_input

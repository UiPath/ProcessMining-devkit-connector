with Activity_configuration_raw as (
    select * from {{ ref('Activity_configuration_raw') }}
),

-- Cast fields from the seeds file to the correct data type.
Activity_configuration as (
    select
        {{ pm_utils.to_varchar('Activity_configuration_raw."Activity"') }} as "Activity",
        {{ pm_utils.to_integer('Activity_configuration_raw."Activity_order"') }} as "Activity_order"
    from Activity_configuration_raw
)

select * from Activity_configuration

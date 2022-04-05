with Automation_estimates as (
    select * from {{ ref('Automation_estimates') }}
),

/* Input table for the automation estimates seeds file. */
Automation_estimates_input as (
    select
        -- Convert all fields to the correct data type.
        {{ pm_utils.to_varchar('Automation_estimates."Activity"') }} as "Activity",
        {{ pm_utils.to_double('Automation_estimates."Event_cost"') }} as "Event_cost",
        {{ pm_utils.to_integer('Automation_estimates."Event_processing_time"') }} as "Event_processing_time"
    from Automation_estimates
)

select * from Automation_estimates_input

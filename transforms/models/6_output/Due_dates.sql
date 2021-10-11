with Due_dates_preprocessing as (
    select * from {{ ref('Due_dates_preprocessing') }}
),

-- The fields on this table should match the data model.
Due_dates as (
    select
        Due_dates_preprocessing."Event_ID" as "Event ID",
        Due_dates_preprocessing."Due_date" as "Due date",
        Due_dates_preprocessing."Actual_date" as "Actual date",
        Due_dates_preprocessing."Expected_date" as "Expected date"
    from Due_dates_preprocessing
)

select * from Due_dates

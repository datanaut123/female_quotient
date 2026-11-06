{% macro generate_dates(start_date='2020-01-01', end_date='2030-12-31') %}
    with date_spine as (
        {{ dbt_utils.date_spine(
            datepart="day",
            start_date="cast('" ~ start_date ~ "' as date)",
            end_date="cast('" ~ end_date ~ "' as date)"
        ) }}
    ),

    date_dim as (
        select
            cast(date_day as date) as date_day,
            format_date('%A', cast(date_day as date)) as day_name,
            extract(dayofweek from cast(date_day as date)) as day_of_week,
            extract(day from cast(date_day as date)) as day_of_month,
            extract(dayofyear from cast(date_day as date)) as day_of_year,
            extract(week from cast(date_day as date)) as week_of_year,
            format_date('%B', cast(date_day as date)) as month_name,
            extract(month from cast(date_day as date)) as month_number,
            extract(quarter from cast(date_day as date)) as quarter_number,
            extract(year from cast(date_day as date)) as year_number,
            date_trunc(cast(date_day as date), month) as month_of,
            extract(dayofweek from cast(date_day as date)) in (1, 7) as is_weekend,
            {{ dbt.current_timestamp() }} as dbt_updated_at
        from date_spine
    )

    select * from date_dim
{% endmacro %}
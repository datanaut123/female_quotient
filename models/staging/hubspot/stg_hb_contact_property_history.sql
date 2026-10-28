with
    data_union as (
        select contact_id, timestamp, value, name

        from {{ source('hubspot', 'contact_property_history') }}

        union all

        select contact_id, timestamp, value, name

        from {{ source('hubspot', 'contact_property_history_gcf') }}

    ),
    cte_1 as (
        select
            contact_id,
            timestamp,
            value as lounge_name,
            row_number() over (
                partition by contact_id, value order by timestamp desc
            ) as rn,
            lounge_attend_date as lounge_attended_date,

        from data_union as cn

        -- from {{ source('hubspot', 'contact_property_history') }} as cn
        left join {{ ref("stg_lounge_dates") }} as ld on cn.value = ld.lounge_name
        where cn.name = 'lounge_or_series_attended'
        qualify rn = 1
    ),

    cte_2 as (
        select
            contact_id,
            lounge_name,
            lounge_attended_date,
            date_diff(
                current_date(), date(lounge_attended_date), day
            ) as days_since_last_lounge_attended,

        from cte_1
    ),

    cte_3 as (
        select contact_id, days_since_last_lounge_attended

        from cte_2
        where days_since_last_lounge_attended <= 365

    ),

    last_cte as (

        select contact_id, count(contact_id) as num_lounge_attended_last_year

        from cte_3
        group by contact_id
    )

select *
from last_cte
where num_lounge_attended_last_year >= 2

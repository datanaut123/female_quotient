with
    cte_1 as (
        select
            contact_id,
            timestamp,
            value as lounge_name,
            row_number() over (
                partition by contact_id, value order by timestamp desc
            ) as rn,
            lounge_attend_date as lounge_attended_date,

        from {{ source('hubspot', 'contact_property_history') }} as cn
        left join {{ref("stg_lounge_dates")}} as ld on cn.value = ld.lounge_name
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



            -- case
            --     when value = 'FQ Lounge™ @ Las Vegas Grand Prix 2026'
            --     then date '2026-11-20'
            --     when value = 'AI Summit 2026'
            --     then date '2026-11-10'
            --     when value = 'FQ Lounge™ @ ANA Masters of Marketing 2026'
            --     then date '2026-10-21'
            --     when value = 'FQ Lounge™ @ Advertising Week 2026'
            --     then date '2026-10-05'
            --     when value = 'FQ Lounge™ during WNBA All-Star 2026'
            --     then date '2026-07-25'
            --     when value = 'FQ Lounge™ @ FIFA World Cup 2026'
            --     then date '2026-07-16'
            --     when value = 'Camp @ Cannes 2026'
            --     then date '2026-06-22'
            --     when
            --         value
            --         = 'FQ Beach @ Cannes Lions 2026 (FQ Lounge™ @ Cannes Lions 2026)'
            --     then date '2026-06-22'
            --     when value = 'FQ Rooftop @ Cannes Lions 2026'
            --     then date '2026-06-22'
            --     when value = 'Solstice Leadership Forum during Cannes Lions 2026'
            --     then date '2026-06-21'
            --     when value = 'FQ Lounge™ @ Consensus 2026'
            --     then date '2026-05-05'
            --     when value = 'FQ Lounge™ @ Miami Grand Prix 2026'
            --     then date '2026-05-01'
            --     when value = 'FQ Lounge™ @ POSSIBLE 2026'
            --     then date '2026-04-27'
            --     when
            --         value
            --         = 'FQ Lounge™ in Augusta 2026 (FQ Lounge™ during The Masters 2026)'
            --     then date '2026-04-09'
            --     when value = 'FQ Lounge™ @ SXSW 2026'
            --     then date '2026-03-14'
            --     when value = 'FQ Lounge™ @ Mobile World Congress 2026'
            --     then date '2026-03-03'
            --     when value = 'FQ Lounge™ in Milan 2026'
            --     then date '2026-02-17'
            --     when value = 'FQ Lounge™ during Super Bowl LX 2026'
            --     then date '2026-02-06'
            --     when value = 'FQ Lounge™ @ Davos 2026'
            --     then date '2026-01-19'
            --     when value = 'Annual Women Walk the Floor Tour @ CES 2026'
            --     then date '2026-01-06'
            --     when value = 'FQ Lounge™ @ CES 2026'
            --     then date '2026-01-06'
            --     when value = 'FQ Lounge™ @ Las Vegas Grand Prix 2025'
            --     then date '2025-11-21'
            --     when value = 'AI Summit 2025'
            --     then date '2025-11-12'
            --     when value = 'Equality Lounge® @ ANA Masters of Marketing 2025'
            --     then date '2025-10-22'
            --     when value = 'FQ Lounge™ @ ANA Masters of Marketing 2025'
            --     then date '2025-10-22'
            --     when value = 'Health Summit 2025'
            --     then date '2025-10-08'
            --     when value = 'Equality Lounge® @ Advertising Week 2025'
            --     then date '2025-10-06'
            --     when value = 'FQ Lounge™ @ Singapore Grand Prix 2025'
            --     then date '2025-10-03'
            --     when value = 'Equality Lounge® @ WNBA All-Star 2025'
            --     then date '2025-07-19'
            --     when value = 'FQ Lounge™ During WNBA All-Star 2025'
            --     then date '2025-07-19'
            --     when value = 'Equality Lounge® @ Cannes Lions 2025'
            --     then date '2025-06-15'
            --     when value = 'FQ Lounge™ @ SXSW London 2025'
            --     then date '2025-06-04'
            --     when value = 'Equality Lounge® @ Miami Grand Prix 2025'
            --     then date '2025-05-02'
            --     when value = 'Equality Lounge® @ POSSIBLE 2025'
            --     then date '2025-04-28'
            --     when value = 'Cyber Conversations & Connections during RSA 2025'
            --     then date '2025-03-30'
            --     when value = 'Equality Lounge® @ SXSW 2025'
            --     then date '2025-03-08'
            --     when value = 'Equality Lounge® @ Mobile World Congress 2025'
            --     then date '2025-03-04'
            --     when value = 'Equality Lounge® During NBA All-Star 2025'
            --     then date '2025-02-15'
            --     when value = 'Equality Lounge® At The Super Bowl 2025'
            --     then date '2025-02-07'
            --     when value = 'Equality Lounge® @ Davos 2025'
            --     then date '2025-01-20'
            --     when value = 'Equality Lounge® @ CES 2025'
            --     then date '2025-01-07'
            --     when value = 'Equality Lounge® @ AWS Re:Invent 2024'
            --     then date '2024-12-03'
            --     when value = 'Equality Lounge® @ Las Vegas Grand Prix 2024'
            --     then date '2024-11-22'
            --     when value = 'Women in AI Summit 2024'
            --     then date '2024-11-13'
            --     when value = 'Equality Lounge® @ COP29 2024'
            --     then date '2024-11-12'
            --     when value = 'Equality Lounge® @ ANA Masters of Marketing 2024'
            --     then date '2024-10-23'
            --     when value = 'Equality Lounge® @ Advertising Week 2024'
            --     then date '2024-10-07'
            --     when
            --         value
            --         = 'Equality Lounge® @ Climate Week NYC 2024 (Equality Lounge® @ Climate Week 2024)'
            --     then date '2024-09-24'
            --     when value = 'Equality Lounge® @ Workday Rising 2024'
            --     then date '2024-09-18'
            --     when value = 'Equality Lounge® @ CloudWorld 2024'
            --     then date '2024-09-10'
            --     when value = 'Equality Lounge® @ Athleta\'s Power of She 2024'
            --     then date '2024-07-31'
            --     when value = 'Equality Lounge® @ Cannes Lions 2024'
            --     then date '2024-06-16'
            --     when value = 'Equality Lounge® @ HIMSS 2024'
            --     then date '2024-03-14'
            --     when value = 'Equality Lounge® @ SXSW 2024'
            --     then date '2024-03-09'
            --     when value = 'Equality Lounge® @ Mobile World Congress 2024'
            --     then date '2024-02-27'
            --     when value = 'Power of the Pack 2024'
            --     then date '2024-01-24'
            --     when value = 'Equality Lounge® @ Davos 2024'
            --     then date '2024-01-15'
            --     when value = 'Equality Lounge® @ CES 2024'
            --     then date '2024-01-09'
            --     when value = 'Equality Lounge® @ JPM Healthcare Conference 2024'
            --     then date '2024-01-08'
            --     when value = 'Algorithm for Equality 2024'
            --     then date '2024-01-04'
            --     when value = 'The Money Quotient 2024'
            --     then date '2024-01-03'
            --     when value = 'Equality Lounge® @ ANA Masters of Marketing 2023'
            --     then date '2023-10-25'
            --     when value = 'Equality Lounge® @ Advertising Week 2023'
            --     then date '2023-10-16'
            --     when value = 'Equality Lounge® @ Cannes Lions 2023'
            --     then date '2023-06-18'
            --     when value = 'Equality Lounge® @ SXSW 2023'
            --     then date '2023-03-11'
            --     when value = 'Equality Lounge® @ Davos 2023'
            --     then date '2023-01-16'
            --     when value = 'Equality Lounge® @ CES 2023'
            --     then date '2023-01-05'
            --     when value = 'Equality Lounge® @ ANA Masters of Marketing 2022'
            --     then date '2022-10-26'
            --     when value = 'Equality Lounge® @ Advertising Week 2022'
            --     then date '2022-10-17'
            --     when value = 'Equality Lounge® @ Cannes Lions 2022'
            --     then date '2022-06-20'
            --     when value = 'Equality Lounge® @ SXSW 2022'
            --     then date '2022-03-12'
            --     when value = 'Equality Lounge® @ Davos 2022'
            --     then date '2022-01-17'
            --     when value = 'Equality Lounge® @ CES 2022'
            --     then null
            --     when value = 'Equality Lounge® @ F1 Academy Singapore 2024'
            --     then null
            --     when value = 'Equality Lounge® @ RSA Conference 2024'
            --     then null
            --     when
            --         value
            --         = 'Equality Lounge® During NVIDIA GTC 2025 (Equality Lounge® @ NVIDIA GTC 2025)'
            --     then null
            --     when value = 'FQ Lounge™ @ SXSW London 2026'
            --     then null
            --     when value = 'International Women\'s Day 2024'
            --     then null
            --     else null
            -- end as lounge_attended_date,

with
    deals as (
        select
            deal_id,
            deal_name,
            deal_url,
            deal_create_date,
            date,
            -- date_trunc(date, quarter) as quarter,
            date_trunc(deal_close_date, quarter) as quarter,
            pipeline_amount,
            deal_close_date,
            stage_name,
            case
                when
                    owner_name in (
                        "Heather Flemming",
                        "Nicole Vaz",
                        "Niki Fleshner",
                        "Talia Bender Small"
                    )
                then "Sarah Williams"
                else owner_name
            end as owner_name,
            owner_email,
            company_name,
            deal_link,
            case
                when stage_name = '1% - Prospecting'
                then 1
                when stage_name = '20% - Prelim Convo/Shared Overview'
                then 2
                when stage_name = '40% - Sent RFP Response'
                then 4
                when stage_name = '60% - Active Negotiation'
                then 6
                when stage_name = '80% - Recommended/Likely to Close'
                then 8
                when stage_name = '85% - Agreement: In Progress (Verbal)'
                then 9
                when stage_name = 'Invoice: Paid'
                then 10
                else 11
            end as stage_ranking

        from {{ ref("fct_hb_deals") }}
    ),

    goals as (
        select team_member, goal, quarter,
        -- 'Closed Won' as stage_name,
        from {{ ref("stg_sales_team_goals") }}
    ),

    data_join as (
        select
            deal_id,
            deal_name,
            deal_url,
            deal_create_date,
            date,
            coalesce(de.quarter, gl.quarter) as quarter,
            pipeline_amount,
            deal_close_date,
            -- coalesce(de.stage_name, gl.stage_name) as stage_name,
            stage_name,
            coalesce(de.owner_name, gl.team_member) as owner_name,
            owner_email,
            goal,
            company_name,
            deal_link,
            stage_ranking

        from deals as de
        full join
            goals as gl
            on (
                de.quarter = gl.quarter and de.owner_name = gl.team_member
            -- and de.stage_name = gl.stage_name
            )

    ),

    dedup as (
        select
            *,
            row_number() over (
                partition by owner_name, quarter
                order by stage_ranking desc, pipeline_amount desc, deal_create_date asc
            ) as rn
        {# row_number() over (
                partition by owner_name, quarter, stage_name
                order by pipeline_amount desc
            ) as rn #}
        from data_join
    )

select * except (goal), case when rn = 1 then goal else 0 end as goal,
{# case
        when stage_name = '1% - Prospecting'
        then 1
        when stage_name = '20% - Prelim Convo/Shared Overview'
        then 2
        when stage_name = '40% - Sent RFP Response'
        then 4
        when stage_name = '60% - Active Negotiation'
        then 6
        when stage_name = '80% - Recommended/Likely to Close'
        then 8
        when stage_name = '85% - Agreement: In Progress (Verbal)'
        then 9
        when stage_name = 'Invoice: Paid'
        then 10
        else 11
    end as stage_ranking #}
from dedup

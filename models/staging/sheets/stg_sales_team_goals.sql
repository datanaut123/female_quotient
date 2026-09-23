{# with
    team_goals as ( #}
        select
            team_member,
            safe_cast(regexp_replace(goal, r'[^0-9.-]', '') as int64) as goal,
            safe.parse_date('%m/%d/%Y', quarter) as quarter

        from {{ source('sheets', 'sales_team_goals_updated') }}
        where lower(team_member) not like '%hubspot%'
    {# ),

    team_goals_agg as (
        select sum(goal) as team_agg_goal, quarter

        from team_goals
        where team_member <> 'Sarah Williams'
        group by quarter
    ),

    data_join as (
        select
            tg.team_member,
            case
                when tg.team_member = 'Sarah Williams'
                then goal - team_agg_goal
                else goal
            end as goal,
            tg.quarter

        from team_goals as tg
        left join team_goals_agg as tga on tg.quarter = tga.quarter
    ),

    sarah_q1_goals as (
        select
            team_member,
            safe_cast(regexp_replace(goal, r'[^0-9.-]', '') as int64) as goal,
            safe.parse_date('%m/%d/%Y', quarter) as quarter

        from {{ source('sheets', 'sales_team_goals') }}
        where team_member = 'Sarah Williams' and quarter = '1/1/2026'
    )

select
    coalesce(dj.team_member,sq.team_member) as team_member,
    coalesce(dj.goal, sq.goal) as goal,
    coalesce(dj.quarter, sq.quarter) as quarter

from data_join as dj
left join sarah_q1_goals as sq on dj.quarter = sq.quarter #}

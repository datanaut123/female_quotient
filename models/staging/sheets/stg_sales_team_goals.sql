with
    team_goals as (
        select
            team_member,
            safe_cast(regexp_replace(goal, r'[^0-9.-]', '') as int64) as goal,
            safe.parse_date('%m/%d/%Y', quarter) as quarter

        from {{ source('sheets', 'sales_team_goals') }}
        where lower(team_member) not like '%hubspot%'
    ),

    team_goals_agg as (
        select sum(goal) as team_agg_goal, quarter

        from team_goals
        where team_member <> 'Sarah Williams'
        group by quarter
    )

select
    tg.team_member,
    case
        when tg.team_member = 'Sarah Williams' then goal - team_agg_goal else goal
    end as goal,
    tg.quarter

from team_goals as tg
left join team_goals_agg as tga on tg.quarter = tga.quarter

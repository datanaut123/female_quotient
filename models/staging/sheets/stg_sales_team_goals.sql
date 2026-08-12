select
    team_member,
    safe_cast(regexp_replace(goal, r'[^0-9.-]', '') as int64) as goal,
    safe.parse_date('%m/%d/%Y', quarter) as quarter

from {{ source('sheets', 'sales_team_goals') }}
where lower(team_member) not like '%hubspot%'

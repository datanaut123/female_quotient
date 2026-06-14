select
    deal_id,
    date(value) as stage_change_date,
    '85% - Agreement: In Progress (Verbal)' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_178125739' and value is not null

union all

select deal_id, date(value) as stage_change_date, 'Closed Won' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_100312217' and value is not null

union all

select deal_id, date(value) as stage_change_date, 'Invoice Paid' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_100312218' and value is not null

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

union all

select deal_id, date(value) as stage_change_date, '1%-Prospecting' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_176203067' and value is not null

union all

select
    deal_id,
    date(value) as stage_change_date,
    '20% - Prelim Convo/Shared Overview' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_176203068' and value is not null

union all

select
    deal_id, date(value) as stage_change_date, '40% - Sent RFP Response' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_176203069' and value is not null

union all

select
    deal_id, date(value) as stage_change_date, '60% - Active Negotiation' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_176203070' and value is not null

union all

select
    deal_id,
    date(value) as stage_change_date,
    '80% - Recommended/Likely to Close' as stage_name
from {{ source('hubspot', 'deal_property_history') }}
where name = 'hs_v2_date_entered_176203071' and value is not null

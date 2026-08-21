select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '1%-Prospecting'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '20% - Prelim Convo/Shared Overview'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '40% - Sent RFP Response'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '60% - Active Negotiation'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '80% - Recommended/Likely to Close'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '85% - Agreement: In Progress (Verbal)'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    deal_close_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = 'Closed Won'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = 'Invoice Paid'

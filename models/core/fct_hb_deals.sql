select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    one_prospecting_date as date,
    .01 * deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = '1% - Prospecting'

union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    twenty_prelim_date as date,
    .20 * deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = '20% - Prelim Convo/Shared Overview'

union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    forty_sent_response_date as date,
    .40 * deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = '40% - Sent RFP Response'

union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    sixty_active_negotiation_date as date,
    .60 * deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = '60% - Active Negotiation'

union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    eighty_recomment_likely_date as date,
    .80 * deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = '80% - Recommended/Likely to Close'

union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    eighty_five_aggrement_date as date,
    .85 * deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = '85% - Agreement: In Progress (Verbal)'

{# union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    invoice_paid_date as date,
    deal_amount as pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where stage_name = 'Invoice: Paid' #}

union all

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    deal_close_date as date,
    deal_amount as pipeline_amount,
    deal_close_date,
    'Closed Won' as stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link

from {{ ref("stg_hb_deals") }}
where
    stage_name in('Closed Won', 'Invoice: Paid')
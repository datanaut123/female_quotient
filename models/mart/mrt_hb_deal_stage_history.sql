select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    .01 * deal_amount as deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    case
        when stage_change_date <= '2025-12-31'
        then 1
        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '1%-Prospecting'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    .20 * deal_amount as deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    case
        when stage_change_date <= '2025-12-31'
        then 1
        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '20% - Prelim Convo/Shared Overview'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    .40 * deal_amount as deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    case
        when stage_change_date <= '2025-12-31'
        then 1

        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '40% - Sent RFP Response'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    .60 * deal_amount as deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    case
        when stage_change_date <= '2025-12-31'
        then 1

        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '60% - Active Negotiation'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    stage_change_date as date,
    .80 * deal_amount as deal_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    case
        when stage_change_date <= '2025-12-31'
        then 1
        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

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
    deal_link,
    case
        when stage_change_date <= '2025-12-31'
        then 1
        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = '85% - Agreement: In Progress (Verbal)'

union all

select distinct
    deal_id,
    deal_name,
    deal_url,
    max(deal_create_date) as deal_create_date,
    max(deal_close_date) as date,
    max(deal_amount) as deal_amount,
    max(deal_close_date) as deal_close_date,
    'Closed Won' as stage_name,
    owner_name,
    owner_email,
    company_name,
    deal_link,
    case
        when max(deal_close_date) <= '2025-12-31'
        then 1
        when
            max(deal_close_date) >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name in ('Closed Won', 'Invoice Paid')
group by 
    deal_id,
    deal_name,
    deal_url,
    owner_name,
    owner_email,
    company_name,
    deal_link
    
{# union all

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
    deal_link,
    case
        when deal_close_date <= '2025-12-31'
        then 1
        when
            deal_close_date >= '2026-01-01'
            and owner_name in (
                "Fleming Longino",
                "Sarah Williams",
                "Jon Ronga",
                "Ale Waase",
                "Emmy York"
            )
        then 1
        else 0
    end as sales_person_filter

from {{ ref("fct_hb_deals_stage_history") }}
where stage_name = 'Invoice Paid' #}

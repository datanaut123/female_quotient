with
    deals_data as (
        select
            deal_id,
            property_dealname as deal_name,
            deal_pipeline_stage_id as stage_id,
            label as stage_name,
            property_amount as deal_amount,
            date(property_closedate) as deal_close_date,
            date(property_createdate) as deal_create_date,
            property_hs_projected_amount_in_home_currency as projected_amount,
            property_hs_acv as acv,
            property_deal_url as deal_url,
            property_deal_status as deal_status,
            property_hs_is_closed_won as is_closed_won,
            coalesce(de.owner_id, ow.owner_id) as owner_id,
            ow.owner_name,
            ow.owner_email,
            ow.is_owner_active,
            date(property_hs_v_2_date_entered_178125739) as agreement_in_progress_date,
            date(property_hs_v_2_date_entered_100312217) as closed_won_date,
            date(property_hs_v_2_date_entered_100312218) as invoice_paid_date,
            date(property_hs_v_2_date_entered_176203067) as one_prospecting_date,
            date(property_hs_v_2_date_entered_176203068) as twenty_prelim_date,
            date(property_hs_v_2_date_entered_176203069) as forty_sent_response_date,
            date(
                property_hs_v_2_date_entered_176203070
            ) as sixty_active_negotiation_date,
            date(
                property_hs_v_2_date_entered_176203071
            ) as eighty_recomment_likely_date,
            date(property_hs_v_2_date_entered_178125739) as eighty_five_aggrement_date,
            concat('https://app.hubspot.com/deals/', deal_id) as deal_link

        from {{ source('hubspot', 'deal') }} as de
        left join
            {{ source('hubspot', 'deal_pipeline_stage') }} as dps
            on de.deal_pipeline_stage_id = dps.stage_id
        left join {{ ref("stg_hb_owner") }} as ow on de.owner_id = ow.owner_id
    ),

    deal_comp as (select deal_id, company_id from {{ ref("stg_hb_deal_company") }}),

    comp as (select company_id, company_name from {{ ref("stg_hb_companies") }})

select dd.*, coalesce(dc.company_id, co.company_id) as company_id, company_name

from deals_data as dd
left join deal_comp as dc on dd.deal_id = dc.deal_id
left join comp as co on dc.company_id = co.company_id

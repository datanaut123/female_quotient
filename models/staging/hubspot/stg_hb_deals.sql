select
    deal_id,
    property_dealname as deal_name,
    deal_pipeline_stage_id as stage_id,
    label as stage_name,
    property_hs_projected_amount_in_home_currency as projected_amount,
    property_hs_closed_won_date as closed_won_date,
    property_hs_acv as acv,
    property_deal_url as deal_url,
    property_deal_status as deal_status,
    property_hs_is_closed_won as is_closed_won,

from {{ source('hubspot', 'deal') }} as de 
left join {{ source('hubspot', 'deal_pipeline_stage') }} as dps on de.deal_pipeline_stage_id = dps.stage_id
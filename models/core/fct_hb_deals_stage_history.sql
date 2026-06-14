select
    de.deal_id,
    de.deal_name,
    de.deal_url,
    de.deal_status,
    dsh.stage_change_date,
    dsh.stage_name

from {{ ref("stg_hb_deals") }} as de
left join {{ ref("stg_hb_deals_stage_history") }} as dsh on de.deal_id = dsh.deal_id

select
    deal_id,
    deal_name,
    deal_url,
    deal_create_date,
    date,
    pipeline_amount,
    deal_close_date,
    stage_name,
    owner_name,
    owner_email

from {{ ref("fct_hb_deals") }}

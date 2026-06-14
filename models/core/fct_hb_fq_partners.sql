with
    cte_1 as (select deal_id, contact_id from {{ ref("stg_hb_deals_contacts") }}),

    cte_2 as (select distinct deal_id from {{ ref("fct_hb_deals_stage_history") }})

select a.deal_id, a.contact_id, 'Yes' as is_fq_partner
from cte_1 as a
inner join cte_2 as b on a.deal_id = b.deal_id

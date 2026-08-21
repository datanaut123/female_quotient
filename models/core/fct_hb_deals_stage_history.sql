with
    cte_1 as (
        select
            de.deal_id,
            de.deal_name,
            de.deal_url,
            de.deal_status,
            dsh.stage_change_date,
            de.deal_amount,
            de.deal_close_date,
            coalesce(dsh.stage_name, de.stage_name) as stage_name,
            owner_id,
            owner_name,
            owner_email,
            is_owner_active,
            deal_create_date,
            company_name,
            deal_link

        from {{ ref("stg_hb_deals") }} as de
        left join
            {{ ref("stg_hb_deals_stage_history") }} as dsh on de.deal_id = dsh.deal_id
    )

select
    *,
    row_number() over (
        partition by deal_id, stage_name order by stage_change_date desc
    ) as rn
from cte_1
qualify rn = 1

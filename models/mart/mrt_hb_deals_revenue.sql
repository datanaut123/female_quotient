select distinct deal_id, pipeline_amount, deal_close_date

from {{ ref("mrt_hb_deals") }}
where
    stage_name in ('Closed Won', 'Invoice: Paid')
    and owner_name
    in ("Fleming Longino", "Sarah Williams", "Jon Ronga", "Ale Waase", "Emmy York")
    and deal_close_date >= '2026-01-01'

union all

select distinct deal_id, pipeline_amount, deal_close_date

from {{ ref("mrt_hb_deals") }}
where stage_name in ('Closed Won', 'Invoice: Paid') and deal_close_date <= '2025-12-31'

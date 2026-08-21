select
    deal_id,
    company_id,
    row_number() over (partition by deal_id order by company_id desc) as rn

from {{ source('hubspot', 'deal_company') }}
qualify rn = 1

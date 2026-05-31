select
    id as company_id,
    property_name as company_name,
    property_createdate as create_date,
    property_website as website,
    property_domain as domain,
    row_number() over (partition by id order by property_createdate desc) as rn
from {{ source('hubspot', 'company') }}
qualify rn = 1

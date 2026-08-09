select
    owner_id,
    concat(first_name, ' ', last_name) as owner_name,
    email as owner_email,
    is_active as is_owner_active,
    row_number() over(partition by owner_id order by owner_id desc) as rn 
from {{ source('hubspot', 'owner') }}
qualify rn = 1

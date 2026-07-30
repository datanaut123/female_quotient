select
    contact_id,
    form_id,
    page_url,
    title,
    1 as is_submitted_form,
    date(timestamp) as form_submitted_at,
    row_number() over (partition by contact_id order by timestamp desc) as rn
from {{ source('hubspot', 'contact_form_submission') }}
qualify rn = 1

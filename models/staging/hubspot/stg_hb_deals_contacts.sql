select deal_id, category, contact_id from {{ source('hubspot', 'deal_contact') }}

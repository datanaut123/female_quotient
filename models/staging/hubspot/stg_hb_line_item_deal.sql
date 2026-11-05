select deal_id, line_item_id from {{ source('hubspot', 'line_item_deal_gcf') }}

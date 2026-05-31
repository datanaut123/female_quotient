select distinct stage_id, label, pipeline_id

from {{ source('hubspot', 'deal_pipeline_stage') }}

select * from {{ source('sheets', 'top_fq_companies') }}
where company_name not like '%Company name%'
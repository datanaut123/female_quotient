select
    -- Contact Identity
    a.contact_id,
    initcap(first_name) as first_name,
    initcap(last_name) as last_name,
    email,
    personal_email,
    phone_number,
    mobile_phone_number,
    contact_status,
    contact_type,
    create_date,
    linkedin_url,

    -- Job & Professional Info
    job_title,
    lower(job_title) as job_title_lower,
    job_level,
    department,
    job_function,
    historic_job_information,

    -- Company Info (cleaned)
    company_name,
    lower(company_name) as company_name_lower,
    company_name_quality_flag,  -- drop this column once QA is signed off
    company_create_date,
    website,
    domain,
    company_type,
    company_industry,
    company_subindustry,
    company_size,
    case
        when company_size = 'null' or company_size is null or company_size = ''
        then 0
        when company_size = '1 - 5'
        then 5
        when company_size = '5 - 10'
        then 10
        when company_size = '10 - 20'
        then 20
        when company_size = '20 - 50'
        then 50
        when company_size = '50 - 100'
        then 100
        when company_size = '100 - 250'
        then 250
        when company_size = '250 - 500'
        then 500
        when company_size = '500 - 1,000'
        then 1000
        when company_size = '1,000 - 5,000'
        then 5000
        when company_size = '5,000 - 10,000'
        then 10000
        when company_size = 'Over 10,000'
        then 99999999
        else -1
    end as company_size_max,
    company_revenue,
    case
        when company_revenue = 'Under $500,000'
        then 1
        when company_revenue = '$500,000 - $1 mil.'
        then 2
        when company_revenue like '%$5 mil%'
        then 3
        when company_revenue = '$5 mil. - $10 mil.'
        then 4
        when company_revenue = '$10 mil. - $25 mil.'
        then 5
        when company_revenue = '$25 mil. - $50 mil.'
        then 6
        when company_revenue = '$50 mil. - $100 mil.'
        then 7
        when company_revenue = '$100 mil. - $250 mil.'
        then 8
        when company_revenue = '$250 mil. - $500 mil.'
        then 9
        when company_revenue = '$500 mil. - $1 bil.'
        then 10
        when company_revenue = '$1 bil. - $5 bil.'
        then 11
        when company_revenue = 'Over $5 bil.'
        then 12
        else 0
    end as company_revenue_max,
    company_address,
    zoominfo_company_fortune_ranking,
    zoominfo_match_status,

    -- Location
    city,
    state,
    state_code,
    country,
    country_region_code,
    postal_code,
    metro_area,

    -- Education
    highest_level_of_education,
    education_institutions,

    -- CRM Associations
    associated_company_id,
    num_associated_deals,

    -- Events & Lounges
    lounge_or_series_name,
    lounge_or_series_invited,
    lounge_or_series_rsvpd,
    lounge_or_series_attended,
    lower(lounge_or_series_attended) as lounge_or_series_attended_lower,
    -- reception_or_party_invited  -- NOT FOUND in contacts table
    reception_or_party_rsvpd,
    reception_or_party_attended,
    lower(reception_or_party_attended) as reception_or_party_attended_lower,

    -- Newsletter & Enrichment
    is_subscribed_to_newsletter,
    zoominfo_contact_accuracy_score,
    case when b.is_fq_partner is null then 'No' else is_fq_partner end as is_fq_partner,
    row_number() over (partition by email order by create_date desc) as rn

from {{ ref("fct_hb_filtered_contacts") }} as a
left join {{ ref("fct_hb_fq_partners") }} as b on a.contact_id = b.contact_id
qualify rn = 1

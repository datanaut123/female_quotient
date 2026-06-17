select
    -- Contact Identity
    a.contact_id,
    first_name,
    last_name,
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
    company_revenue,
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

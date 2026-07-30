select
    -- Contact Identity
    contact_id,
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
    job_level,
    department,
    job_function,
    historic_job_information,

    -- Company Info (cleaned)
    company_name,
    company_name_quality_flag,
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
    -- reception_or_party_invited  -- NOT FOUND in contacts table
    reception_or_party_rsvpd,
    reception_or_party_attended,

    -- Newsletter & Enrichment
    is_subscribed_to_newsletter,
    zoominfo_contact_accuracy_score,
    num_contacted,
    email_bounce,
    last_contacted_date,
    days_since_last_contacted,
    zoominfo_contact_id,
    lounge_attended_date,
    party_attended_date,
    last_event_spoke_date,
    lounge_series_rsvpd_date,
    is_submitted_form,
    reception_party_rsvpd_date,
    form_submitted_at

from {{ ref("fct_hb_contacts") }}
where
    zoominfo_match_status = 'FULL_MATCH'
    or zoominfo_match_status = 'CONTACT_ONLY_MATCH'
    or zoominfo_match_status = ''

union all

select
    -- Contact Identity
    contact_id,
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
    job_level,
    department,
    job_function,
    historic_job_information,

    -- Company Info (cleaned)
    company_name,
    company_name_quality_flag,
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
    -- reception_or_party_invited  -- NOT FOUND in contacts table
    reception_or_party_rsvpd,
    reception_or_party_attended,

    -- Newsletter & Enrichment
    is_subscribed_to_newsletter,
    zoominfo_contact_accuracy_score,
    num_contacted,
    email_bounce,
    last_contacted_date,
    days_since_last_contacted,
    zoominfo_contact_id,
    lounge_attended_date,
    party_attended_date,
    last_event_spoke_date,
    lounge_series_rsvpd_date,
    is_submitted_form,
    reception_party_rsvpd_date,
    form_submitted_at

from {{ ref("fct_hb_contacts") }}
where
    (
        zoominfo_match_status = 'NON_MATCH_BY_REQUIRED_FIELDS'
        or zoominfo_match_status = 'NON_MATCH_BY_CONTACT_ACCURACY_MIN'
    )
    and num_contacted >= 1
    and email_bounce is null
    and days_since_last_contacted <= 365

union all

select
    -- Contact Identity
    contact_id,
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
    job_level,
    department,
    job_function,
    historic_job_information,

    -- Company Info (cleaned)
    company_name,
    company_name_quality_flag,
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
    -- reception_or_party_invited  -- NOT FOUND in contacts table
    reception_or_party_rsvpd,
    reception_or_party_attended,

    -- Newsletter & Enrichment
    is_subscribed_to_newsletter,
    zoominfo_contact_accuracy_score,
    num_contacted,
    email_bounce,
    last_contacted_date,
    days_since_last_contacted,
    zoominfo_contact_id,
    lounge_attended_date,
    party_attended_date,
    last_event_spoke_date,
    lounge_series_rsvpd_date,
    is_submitted_form,
    reception_party_rsvpd_date,
    form_submitted_at

from {{ ref("fct_hb_contacts") }}
where zoominfo_match_status = 'NON_MATCH' and zoominfo_contact_id is not null

select
    -- Contact Identity
    id as contact_id,
    property_firstname as first_name,
    property_lastname as last_name,
    property_email as email,
    property_personal_email as personal_email,
    property_phone as phone_number,
    property_mobilephone as mobile_phone_number,
    property_contact_status as contact_status,
    property_contact_type as contact_type,
    property_createdate as create_date,
    property_hs_linkedin_url as linkedin_url,

    -- Job & Professional Info
    property_jobtitle as job_title,
    property_joblevel as job_level,
    property_department as department,
    property_jobfunction as job_function,
    property_historic_job_information as historic_job_information,

    -- Company Info
    coalesce(cn.property_company, co.company_name) as company_name,
    co.create_date as company_create_date,
    co.website,
    co.domain,
    property_company_type as company_type,
    property_company_industry as company_industry,
    property_company_subindustry as company_subindustry,
    property_organization_size as company_size,
    property_company_revenue as company_revenue,
    property_company_address as company_address,
    property_zoominfo_company_fortune_ranking as zoominfo_company_fortune_ranking,
    property_zoominfo_match_status as zoominfo_match_status,

    -- Location
    property_city as city,
    property_state as state,
    property_hs_state_code as state_code,
    property_country as country,
    property_hs_country_region_code as country_region_code,
    property_zip as postal_code,
    property_metro_area as metro_area,

    -- Education
    property_highest_level_of_education as highest_level_of_education,
    property_education_institutions as education_institutions,

    -- CRM Associations
    safe_cast(property_associatedcompanyid as INT64) as associated_company_id,
    property_num_associated_deals as num_associated_deals,

    -- Events & Lounges
    property_lounge_or_series_name as lounge_or_series_name,
    property_lounge_or_series_invited as lounge_or_series_invited,
    property_lounge_or_series_rsvp_d as lounge_or_series_rsvpd,
    property_lounge_or_series_attended as lounge_or_series_attended,
    -- reception_or_party_invited             --  NOT FOUND in contacts table
    property_reception_or_party_rsvp_d as reception_or_party_rsvpd,
    property_reception_or_party_attended as reception_or_party_attended,

    -- Newsletter & Enrichment
    property_is_subscribed_to_newsletter as is_subscribed_to_newsletter,
    property_zoominfo_contact_accuracy_score as zoominfo_contact_accuracy_score

from {{ source('hubspot', 'contact') }} as cn 
left join {{ref("stg_hb_companies")}} as co on cn.property_associatedcompanyid = co.company_id

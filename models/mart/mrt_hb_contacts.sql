with
    cte_1 as (
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
            case when job_level is null then '' else job_level end as job_level,
            case
                when job_level = 'Board Member / Advisor'
                then 1
                when job_level = 'Owner / Founder'
                then 2
                when job_level = 'C-Level'
                then 3
                when job_level = 'VP-Level'
                then 4
                when job_level = 'Director'
                then 5
                when job_level = 'Manager'
                then 6
                when job_level = 'Non-Manager'
                then 7
                when job_level = 'Freelance / Self-Employed'
                then 8
                when job_level = 'Student'
                then 9
                when job_level = 'Retired'
                then 10
                when (job_level = '' or job_level is null)
                then 11
            end as job_level_filter,
            case when department is null then '' else department end as department,
            case
                when job_function is null then '' else job_function
            end as job_function,
            historic_job_information,

            -- Company Info (cleaned)
            company_name,
            lower(company_name) as company_name_lower,
            company_name_quality_flag,  -- drop this column once QA is signed off
            company_create_date,
            website,
            domain,
            company_type,
            case
                when company_industry is null then '' else company_industry
            end as company_industry,
            case
                when company_subindustry is null then '' else company_subindustry
            end as company_subindustry,
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
            case when city is null then '' else city end as city,
            case when state is null then '' else state end as state,
            state_code,
            case when country is null then '' else country end as country,
            country_region_code,
            postal_code,
            case when metro_area is null then '' else metro_area end as metro_area,

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
            case
                when b.is_fq_partner is null then 'No' else is_fq_partner
            end as is_fq_partner,
            row_number() over (partition by email order by create_date desc) as rn,
            lounge_attended_date,
            party_attended_date,
            last_event_spoke_date,
            lounge_series_rsvpd_date,
            is_submitted_form,
            reception_party_rsvpd_date,
            form_submitted_at,
            date_diff(
                current_date(), date(create_date), day
            ) as days_since_contact_creation,
            date_diff(
                current_date(), date(last_event_spoke_date), day
            ) as days_since_last_spoke,
            date_diff(
                current_date(), date(lounge_attended_date), day
            ) as days_since_last_lounge_attended,
            date_diff(
                current_date(), date(party_attended_date), day
            ) as days_since_last_party_attended,
            date_diff(
                current_date(), date(lounge_series_rsvpd_date), day
            ) as days_since_last_lounge_series_rsvpd,
            date_diff(
                current_date(), date(reception_party_rsvpd_date), day
            ) as days_since_last_reception_party_rsvpd,
            date_diff(
                current_date(), date(form_submitted_at), day
            ) as days_since_last_form_submitted,
            num_lounge_attended_last_year,
            number_of_inbound_email

        from {{ ref("fct_hb_filtered_contacts") }} as a
        left join {{ ref("fct_hb_fq_partners") }} as b on a.contact_id = b.contact_id
        left join {{ ref("stg_hb_contact_property_history") }} as c on a.contact_id = c.contact_id
        qualify rn = 1
    )

select
    *,
    case
        when days_since_contact_creation <= 90
        then 'New'
        when
            (lower(contact_type) like '%speaker%' and days_since_last_spoke <= 365)
            or days_since_last_party_attended <= 365
            or num_lounge_attended_last_year <= 365
        then 'High'
        when
            days_since_last_reception_party_rsvpd <= 365
            or days_since_last_lounge_attended <= 365
            or days_since_last_lounge_series_rsvpd <= 365
            or days_since_last_form_submitted <= 365
        then 'Moderate'
        else 'Disengaged'
    end as engagement_level

from cte_1

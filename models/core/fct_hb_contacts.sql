with
    base as (
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

            -- Company Info (raw - will be cleaned below)
            company_name,
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

        from {{ ref("stg_hb_contacts") }}
    ),

    domain_root as (
        select
            *,

            -- Strip subdomains → root domain (e.g. support.aws.com → aws.com)
            -- Preserves ccTLDs like co.uk, com.au
            case
                when domain is null
                then null
                when
                    array_length(split(domain, '.')) > 2
                    and not regexp_contains(
                        domain, r'\.(co|com|org|net|gov|edu)\.[a-z]{2}$'
                    )
                then
                    array_to_string(
                        array_reverse(
                            array_slice(array_reverse(split(domain, '.')), 0, 2)
                        ),
                        '.'
                    )
                else domain
            end as root_domain

        from base
    ),

    company_name_cleaned as (
        select
            *,

            -- Name derived from domain as fallback
            initcap(
                regexp_replace(
                    regexp_replace(
                        regexp_replace(root_domain, r'\.[a-z]{2,4}(\.[a-z]{2})?$', ''),
                        r'[-_]',
                        ' '
                    ),
                    r'\s+',
                    ' '
                )
            ) as company_name_from_domain,

            -- Final cleaned company name logic
            case
                -- Both null → nothing we can do
                when company_name is null and domain is null
                then null

                -- Name null or junk → fallback to domain
                when
                    company_name is null
                    or trim(company_name) = ''
                    or regexp_contains(
                        lower(company_name),
                        r'freelance|self.employed|independent|unemployed|furloughed|in transition|laidoff'
                    )
                    or regexp_contains(company_name, r'^\(')
                    or regexp_contains(company_name, r'^\s*-')
                then
                    initcap(
                        regexp_replace(
                            regexp_replace(
                                regexp_replace(
                                    root_domain, r'\.[a-z]{2,4}(\.[a-z]{2})?$', ''
                                ),
                                r'[-_]',
                                ' '
                            ),
                            r'\s+',
                            ' '
                        )
                    )

                -- Name is a URL → replace with domain-derived name
                when regexp_contains(lower(company_name), r'^www\.|^http')
                then
                    initcap(
                        regexp_replace(
                            regexp_replace(
                                regexp_replace(
                                    root_domain, r'\.[a-z]{2,4}(\.[a-z]{2})?$', ''
                                ),
                                r'[-_]',
                                ' '
                            ),
                            r'\s+',
                            ' '
                        )
                    )

                -- Triple-quoted artifact → strip quotes and clean
                when regexp_contains(company_name, r'^"{2,}')
                then initcap(trim(regexp_replace(company_name, r'^"{2,}|"{2,}$', '')))

                -- Name is fine → trim, strip trailing punctuation, title case
                else initcap(trim(regexp_replace(company_name, r'[,\.]+$', '')))
            end as cleaned_company_name,

            -- Audit flag for dbt tests / QA
            case
                when company_name is null and domain is null
                then 'both_null'
                when company_name is null and domain is not null
                then 'name_from_domain'
                when company_name is not null and domain is null
                then 'name_only_no_domain'
                when
                    regexp_contains(
                        lower(company_name),
                        r'freelance|self.employed|independent|unemployed|furloughed|in transition'
                    )
                then 'non_company_individual'
                when regexp_contains(company_name, r'^"{2,}')
                then 'triple_quote_cleaned'
                when regexp_contains(lower(company_name), r'^www\.|^http')
                then 'url_replaced_by_domain'
                else 'ok'
            end as company_name_quality_flag

        from domain_root
    )

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
    cleaned_company_name as company_name,
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

from company_name_cleaned
where
    (first_name is not null and first_name != '')
    and (last_name is not null and last_name != '')
    and (email is not null and email != '')

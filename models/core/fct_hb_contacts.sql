WITH base AS (
    SELECT
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
        zoominfo_contact_accuracy_score

    FROM {{ ref("stg_hb_contacts") }}
),

domain_root AS (
    SELECT
        *,

        -- Strip subdomains → root domain (e.g. support.aws.com → aws.com)
        -- Preserves ccTLDs like co.uk, com.au
        CASE
            WHEN domain IS NULL THEN NULL
            WHEN ARRAY_LENGTH(SPLIT(domain, '.')) > 2
                 AND NOT REGEXP_CONTAINS(domain, r'\.(co|com|org|net|gov|edu)\.[a-z]{2}$')
                THEN ARRAY_TO_STRING(
                        ARRAY_REVERSE(ARRAY_SLICE(ARRAY_REVERSE(SPLIT(domain, '.')), 0, 2)),
                        '.'
                     )
            ELSE domain
        END AS root_domain

    FROM base
),

company_name_cleaned AS (
    SELECT
        *,

        -- Name derived from domain as fallback
        INITCAP(
            REGEXP_REPLACE(
                REGEXP_REPLACE(
                    REGEXP_REPLACE(root_domain, r'\.[a-z]{2,4}(\.[a-z]{2})?$', ''),
                r'[-_]', ' '),
            r'\s+', ' ')
        ) AS company_name_from_domain,

        -- Final cleaned company name logic
        CASE
            -- Both null → nothing we can do
            WHEN company_name IS NULL AND domain IS NULL
                THEN NULL

            -- Name null or junk → fallback to domain
            WHEN company_name IS NULL
              OR TRIM(company_name) = ''
              OR REGEXP_CONTAINS(LOWER(company_name), r'freelance|self.employed|independent|unemployed|furloughed|in transition|laidoff')
              OR REGEXP_CONTAINS(company_name, r'^\(')
              OR REGEXP_CONTAINS(company_name, r'^\s*-')
                THEN INITCAP(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(root_domain, r'\.[a-z]{2,4}(\.[a-z]{2})?$', ''),
                            r'[-_]', ' '),
                        r'\s+', ' ')
                     )

            -- Name is a URL → replace with domain-derived name
            WHEN REGEXP_CONTAINS(LOWER(company_name), r'^www\.|^http')
                THEN INITCAP(
                        REGEXP_REPLACE(
                            REGEXP_REPLACE(
                                REGEXP_REPLACE(root_domain, r'\.[a-z]{2,4}(\.[a-z]{2})?$', ''),
                            r'[-_]', ' '),
                        r'\s+', ' ')
                     )

            -- Triple-quoted artifact → strip quotes and clean
            WHEN REGEXP_CONTAINS(company_name, r'^"{2,}')
                THEN INITCAP(TRIM(REGEXP_REPLACE(company_name, r'^"{2,}|"{2,}$', '')))

            -- Name is fine → trim, strip trailing punctuation, title case
            ELSE INITCAP(TRIM(REGEXP_REPLACE(company_name, r'[,\.]+$', '')))
        END AS cleaned_company_name,

        -- Audit flag for dbt tests / QA
        CASE
            WHEN company_name IS NULL AND domain IS NULL
                THEN 'both_null'
            WHEN company_name IS NULL AND domain IS NOT NULL
                THEN 'name_from_domain'
            WHEN company_name IS NOT NULL AND domain IS NULL
                THEN 'name_only_no_domain'
            WHEN REGEXP_CONTAINS(LOWER(company_name), r'freelance|self.employed|independent|unemployed|furloughed|in transition')
                THEN 'non_company_individual'
            WHEN REGEXP_CONTAINS(company_name, r'^"{2,}')
                THEN 'triple_quote_cleaned'
            WHEN REGEXP_CONTAINS(LOWER(company_name), r'^www\.|^http')
                THEN 'url_replaced_by_domain'
            ELSE 'ok'
        END AS company_name_quality_flag

    FROM domain_root
)

SELECT
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
    cleaned_company_name                AS company_name,
    company_name_quality_flag,          -- drop this column once QA is signed off
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
    zoominfo_contact_accuracy_score

FROM company_name_cleaned
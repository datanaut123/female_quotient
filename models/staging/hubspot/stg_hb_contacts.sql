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
    safe_cast(property_associatedcompanyid as int64) as associated_company_id,
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
    property_zoominfo_contact_accuracy_score as zoominfo_contact_accuracy_score,
    property_num_contacted_notes as num_contacted,
    property_hs_email_bounce as email_bounce,
    date(property_notes_last_contacted) as last_contacted_date,
    date_diff(
        current_date(), date(property_notes_last_contacted), day
    ) as days_since_last_contacted,
    property_zoominfo_contact_id as zoominfo_contact_id,
    property_number_of_inboun as number_of_inbound_email,
    case
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ @ Las Vegas Grand Prix 2026'
        then date '2026-11-20'
        when property_lounge_or_series_attended = 'AI Summit 2026'
        then date '2026-11-10'
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ @ ANA Masters of Marketing 2026'
        then date '2026-10-21'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ Advertising Week 2026'
        then date '2026-10-05'
        when property_lounge_or_series_attended = 'FQ Lounge™ during WNBA All-Star 2026'
        then date '2026-07-25'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ FIFA World Cup 2026'
        then date '2026-07-16'
        when property_lounge_or_series_attended = 'Camp @ Cannes 2026'
        then date '2026-06-22'
        when
            property_lounge_or_series_attended
            = 'FQ Beach @ Cannes Lions 2026 (FQ Lounge™ @ Cannes Lions 2026)'
        then date '2026-06-22'
        when property_lounge_or_series_attended = 'FQ Rooftop @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_lounge_or_series_attended
            = 'Solstice Leadership Forum during Cannes Lions 2026'
        then date '2026-06-21'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ Consensus 2026'
        then date '2026-05-05'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ Miami Grand Prix 2026'
        then date '2026-05-01'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ POSSIBLE 2026'
        then date '2026-04-27'
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ in Augusta 2026 (FQ Lounge™ during The Masters 2026)'
        then date '2026-04-09'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ SXSW 2026'
        then date '2026-03-14'
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ @ Mobile World Congress 2026'
        then date '2026-03-03'
        when property_lounge_or_series_attended = 'FQ Lounge™ in Milan 2026'
        then date '2026-02-17'
        when property_lounge_or_series_attended = 'FQ Lounge™ during Super Bowl LX 2026'
        then date '2026-02-06'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ Davos 2026'
        then date '2026-01-19'
        when
            property_lounge_or_series_attended
            = 'Annual Women Walk the Floor Tour @ CES 2026'
        then date '2026-01-06'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ CES 2026'
        then date '2026-01-06'
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ @ Las Vegas Grand Prix 2025'
        then date '2025-11-21'
        when property_lounge_or_series_attended = 'AI Summit 2025'
        then date '2025-11-12'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ ANA Masters of Marketing 2025'
        then date '2025-10-22'
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ @ ANA Masters of Marketing 2025'
        then date '2025-10-22'
        when property_lounge_or_series_attended = 'Health Summit 2025'
        then date '2025-10-08'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Advertising Week 2025'
        then date '2025-10-06'
        when
            property_lounge_or_series_attended
            = 'FQ Lounge™ @ Singapore Grand Prix 2025'
        then date '2025-10-03'
        when
            property_lounge_or_series_attended = 'Equality Lounge® @ WNBA All-Star 2025'
        then date '2025-07-19'
        when property_lounge_or_series_attended = 'FQ Lounge™ During WNBA All-Star 2025'
        then date '2025-07-19'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Cannes Lions 2025'
        then date '2025-06-15'
        when property_lounge_or_series_attended = 'FQ Lounge™ @ SXSW London 2025'
        then date '2025-06-04'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Miami Grand Prix 2025'
        then date '2025-05-02'
        when property_lounge_or_series_attended = 'Equality Lounge® @ POSSIBLE 2025'
        then date '2025-04-28'
        when
            property_lounge_or_series_attended
            = 'Cyber Conversations & Connections during RSA 2025'
        then date '2025-03-30'
        when property_lounge_or_series_attended = 'Equality Lounge® @ SXSW 2025'
        then date '2025-03-08'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Mobile World Congress 2025'
        then date '2025-03-04'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® During NBA All-Star 2025'
        then date '2025-02-15'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® At The Super Bowl 2025'
        then date '2025-02-07'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Davos 2025'
        then date '2025-01-20'
        when property_lounge_or_series_attended = 'Equality Lounge® @ CES 2025'
        then date '2025-01-07'
        when
            property_lounge_or_series_attended = 'Equality Lounge® @ AWS Re:Invent 2024'
        then date '2024-12-03'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Las Vegas Grand Prix 2024'
        then date '2024-11-22'
        when property_lounge_or_series_attended = 'Women in AI Summit 2024'
        then date '2024-11-13'
        when property_lounge_or_series_attended = 'Equality Lounge® @ COP29 2024'
        then date '2024-11-12'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ ANA Masters of Marketing 2024'
        then date '2024-10-23'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Advertising Week 2024'
        then date '2024-10-07'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Climate Week NYC 2024 (Equality Lounge® @ Climate Week 2024)'
        then date '2024-09-24'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Workday Rising 2024'
        then date '2024-09-18'
        when property_lounge_or_series_attended = 'Equality Lounge® @ CloudWorld 2024'
        then date '2024-09-10'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Athleta\'s Power of She 2024'
        then date '2024-07-31'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Cannes Lions 2024'
        then date '2024-06-16'
        when property_lounge_or_series_attended = 'Equality Lounge® @ HIMSS 2024'
        then date '2024-03-14'
        when property_lounge_or_series_attended = 'Equality Lounge® @ SXSW 2024'
        then date '2024-03-09'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Mobile World Congress 2024'
        then date '2024-02-27'
        when property_lounge_or_series_attended = 'Power of the Pack 2024'
        then date '2024-01-24'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Davos 2024'
        then date '2024-01-15'
        when property_lounge_or_series_attended = 'Equality Lounge® @ CES 2024'
        then date '2024-01-09'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ JPM Healthcare Conference 2024'
        then date '2024-01-08'
        when property_lounge_or_series_attended = 'Algorithm for Equality 2024'
        then date '2024-01-04'
        when property_lounge_or_series_attended = 'The Money Quotient 2024'
        then date '2024-01-03'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ ANA Masters of Marketing 2023'
        then date '2023-10-25'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Advertising Week 2023'
        then date '2023-10-16'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Cannes Lions 2023'
        then date '2023-06-18'
        when property_lounge_or_series_attended = 'Equality Lounge® @ SXSW 2023'
        then date '2023-03-11'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Davos 2023'
        then date '2023-01-16'
        when property_lounge_or_series_attended = 'Equality Lounge® @ CES 2023'
        then date '2023-01-05'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ ANA Masters of Marketing 2022'
        then date '2022-10-26'
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ Advertising Week 2022'
        then date '2022-10-17'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Cannes Lions 2022'
        then date '2022-06-20'
        when property_lounge_or_series_attended = 'Equality Lounge® @ SXSW 2022'
        then date '2022-03-12'
        when property_lounge_or_series_attended = 'Equality Lounge® @ Davos 2022'
        then date '2022-01-17'
        when property_lounge_or_series_attended = 'Equality Lounge® @ CES 2022'
        then null
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ F1 Academy Singapore 2024'
        then null
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® @ RSA Conference 2024'
        then null
        when
            property_lounge_or_series_attended
            = 'Equality Lounge® During NVIDIA GTC 2025 (Equality Lounge® @ NVIDIA GTC 2025)'
        then null
        when property_lounge_or_series_attended = 'FQ Lounge™ @ SXSW London 2026'
        then null
        when property_lounge_or_series_attended = 'International Women\'s Day 2024'
        then null
        else null
    end as lounge_attended_date,
    case
        when
            property_reception_or_party_attended
            = 'Health at the Speed of Insight Real Chemistry Cocktail Hour during Cannes 2026'
        then date '2026-06-25'
        when
            property_reception_or_party_attended
            = 'Creative Chemistry Adobe Creators Conversation & Cocktails during Cannes 2026'
        then date '2026-06-25'
        when
            property_reception_or_party_attended
            = 'Future-Forward CMOs Adobe Roundtable during Cannes 2026'
        then date '2026-06-25'
        when
            property_reception_or_party_attended
            = 'Ladies Night Out @ Cannes Lions 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_attended
            = 'WNBA Unstoppable Conversation & Cocktails during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_attended
            = 'Better Together AWS/BCG Cocktail Hour during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_attended
            = 'Rewriting the Rules of B2B Marketing Adobe Roundtable during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_attended
            = 'Meeting in the Middle ADWEEK/EY Roundtable during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_attended
            = 'Ten to One Afterhours Party @ Cannes Lions 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_attended
            = 'Above the Croisette Databricks Cocktail Hour during Cannes 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_attended
            = 'Unwell Beach Party @ Cannes Lions 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_attended
            = 'Scaling the AI Opportunity Monks AWS Roundtable @ Cannes Lions 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_attended
            = 'Connected by Care: A Healthcare Marketing Brunch @ Cannes 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_attended
            = 'The Power of Experiential Connection Sparks Cocktail Hour @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_reception_or_party_attended
            = 'AI In Action Networking Reception @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_reception_or_party_attended
            = 'Meta Creators & Friends Meetup during Cannes 2026'
        then date '2026-06-22'
        when
            property_reception_or_party_attended
            = 'Leading Through the Unknown AWS Roundtable Lunch during Cannes 2026'
        then date '2026-06-22'
        when property_reception_or_party_attended = 'Cannes Lions Kick-Off Dinner 2026'
        then date '2026-06-21'
        when
            property_reception_or_party_attended
            = 'Conversation & Cocktails Following AWS Partner Summit NYC 2026'
        then date '2026-06-16'
        when property_reception_or_party_attended = 'Shamrock Dinner in NYC 2026'
        then date '2026-06-04'
        when
            property_reception_or_party_attended
            = 'B2B Marketing Leaders Dinner in NYC 2026'
        then date '2026-05-12'
        when
            property_reception_or_party_attended
            = 'Celebrating The Future Of Women\'s Sports During Milken Global Conference 2026'
        then date '2026-05-05'
        when property_reception_or_party_attended = 'AWS Brunch during F1 Miami 2026'
        then date '2026-05-02'
        when
            property_reception_or_party_attended
            = 'B2B Marketing Leaders Dinner @ POSSIBLE 2026'
        then date '2026-04-28'
        when
            property_reception_or_party_attended = '#Paid Cocktail Hour @ POSSIBLE 2026'
        then date '2026-04-27'
        when
            property_reception_or_party_attended
            = 'Dinner & Dialogue Cognitiv Dinner in Los Angeles 2026'
        then date '2026-04-22'
        when
            property_reception_or_party_attended
            = 'Where Commerce Meets Influence Trade Desk Dinner @ Shoptalk 2026'
        then date '2026-03-25'
        when
            property_reception_or_party_attended
            = 'An Intimate Leadership Salesforce Dinner @ SXSW 2026'
        then date '2026-03-14'
        when
            property_reception_or_party_attended
            = 'Dinner & Dialogue Cognitiv Dinner in Chicago 2026'
        then date '2026-03-11'
        when
            property_reception_or_party_attended
            = 'Power Play: From Milan to LA28 Games @ Milan Olympics 2026'
        then date '2026-02-18'
        when
            property_reception_or_party_attended
            = 'Sensor Tower Cocktail Hour @ CES 2026'
        then date '2026-01-07'
        when
            property_reception_or_party_attended
            = 'Leading AI-Fueled Marketing Transformation AWS Dinner @ CES 2026'
        then date '2026-01-06'
        when
            property_reception_or_party_attended = 'Salesforce Cocktail Hour @ CES 2026'
        then date '2026-01-06'
        when
            property_reception_or_party_attended
            = 'Bridging the Gap MiQ / IPG Healthcare Dinner 2025'
        then date '2025-12-08'
        when
            property_reception_or_party_attended
            = 'Cheers to What\'s Next Executive Nightcap @ AWS re:Invent 2025'
        then date '2025-12-03'
        when
            property_reception_or_party_attended
            = 'Cocktails Connections & Conversations Partner Reception @ AWS re:Invent 2025'
        then date '2025-12-03'
        when
            property_reception_or_party_attended
            = 'Leaders Who Lunch @ AWS re:Invent 2025'
        then date '2025-12-02'
        when
            property_reception_or_party_attended
            = 'The Ascend Series Nashville Amex & Delta Reception 2025'
        then date '2025-11-19'
        when
            property_reception_or_party_attended
            = 'The Ascend Series Seattle Amex & Delta Reception 2025'
        then date '2025-11-13'
        when
            property_reception_or_party_attended
            = 'The Ascend Series New York Amex & Delta Reception 2025'
        then date '2025-11-06'
        when
            property_reception_or_party_attended
            = 'Celebrating Leaders in Cyber Reception 2025'
        then date '2025-11-03'
        when
            property_reception_or_party_attended
            = 'The Power Table Breakfast @ Dreamforce 2025'
        then date '2025-10-15'
        when
            property_reception_or_party_attended
            = 'AI Roundtable Breakfast AWS @ Advertising Week 2025'
        then date '2025-10-08'
        when
            property_reception_or_party_attended
            = 'The Marketing Edit Rokt Dinner @ Advertising Week 2025'
        then date '2025-10-07'
        when property_reception_or_party_attended = 'Lead Forward Reception 2025'
        then date '2025-09-30'
        when
            property_reception_or_party_attended
            = 'Where Innovation Meets Influence Dinner 2025'
        then date '2025-09-29'
        when
            property_reception_or_party_attended
            = 'Brunch Celebrating Women Shaping Emmys 2025'
        then date '2025-09-12'
        when property_reception_or_party_attended = 'Women on the Rise Boston 2025'
        then date '2025-09-09'
        when
            property_reception_or_party_attended
            = 'Celebrating the Power of Multigenerational Workplaces AARP Dinner 2025'
        then date '2025-07-16'
        when
            property_reception_or_party_attended
            = 'Flow Leadership: The Time is Now Reception 2025'
        then date '2025-07-15'
        when
            property_reception_or_party_attended
            = 'Women Who Lead the Way Lunch @ Cannes Lions 2025'
        then date '2025-06-17'
        when
            property_reception_or_party_attended
            = 'Women on the Rise: Power Forward Reception 2025'
        then date '2025-05-19'
        when
            property_reception_or_party_attended
            = 'Broken Rung San Francisco Reception 2025'
        then date '2025-05-13'
        when property_reception_or_party_attended = 'Salon Dinner @ POSSIBLE 2025'
        then date '2025-04-28'
        when
            property_reception_or_party_attended
            = 'Trailblazers in Tech: A Dinner Celebrating Women Leaders 2025'
        then date '2025-03-19'
        when
            property_reception_or_party_attended
            = 'Hitachi Vantara An Evening of Connection Reception 2025'
        then date '2025-03-18'
        when
            property_reception_or_party_attended
            = 'The Broken Rung: Book Launch and Reception 2025'
        then date '2025-03-11'
        when
            property_reception_or_party_attended
            = 'Mobile World Congress Kick-Off Dinner 2025'
        then date '2025-03-03'
        when
            property_reception_or_party_attended
            = 'Power Play Conversation & Cocktails @ Davos 2025'
        then date '2025-01-22'
        when
            property_reception_or_party_attended
            = 'A Toast to Women\'s Health Reception @ Davos 2025'
        then date '2025-01-21'
        when
            property_reception_or_party_attended
            = 'The Visionary Table Dinner @ CES 2025'
        then date '2025-01-07'
        when
            property_reception_or_party_attended
            = 'Annual Women Walk the Floor Tour @ CES 2025'
        then date '2025-01-07'
        when
            property_reception_or_party_attended
            = 'Raise a Glass: CES Leaders Kick Off Reception 2025'
        then date '2025-01-06'
        when
            property_reception_or_party_attended
            = 'Soar Higher: Celebrating Women Entrepreneurs 2024'
        then date '2024-11-19'
        when
            property_reception_or_party_attended
            = 'Women in AI Summit Kick-off Dinner 2024'
        then date '2024-11-12'
        when
            property_reception_or_party_attended
            = 'Female Founders\' Table Dinner & Reception 2024'
        then date '2024-10-24'
        when
            property_reception_or_party_attended
            = 'Money Date: Wine & Goal Setting Amex Reception 2024'
        then date '2024-10-17'
        when
            property_reception_or_party_attended
            = 'Beyond the Feed: Creators as Entrepreneurs Event 2024'
        then date '2024-10-09'
        when
            property_reception_or_party_attended
            = 'Elevate Your Network: An Evening of Connection Delta Dinner 2024 ()'
        then date '2024-10-08'
        when property_reception_or_party_attended = 'Women on The Rise NYC 2024'
        then date '2024-09-30'
        when
            property_reception_or_party_attended
            = 'Driving Equality: Women Leading the Charge Singapore Brunch 2024'
        then date '2024-09-20'
        when
            property_reception_or_party_attended
            = 'Breakfast Celebrating Women in Cyber 2024'
        then date '2024-09-17'
        when
            property_reception_or_party_attended
            = 'Women Leaders Brunch during Veecon 2024 (Women Leaders Brunch during Veecon)'
        then date '2024-08-11'
        when property_reception_or_party_attended = 'Athleta Power of She Brunch 2024'
        then date '2024-07-28'
        when
            property_reception_or_party_attended
            = 'Maximizing Your Money AMEX Reception 2024'
        then date '2024-07-17'
        when property_reception_or_party_attended = 'DVF Documentary Event 2024'
        then date '2024-07-03'
        when property_reception_or_party_attended = 'Delta 2024 Reception'
        then date '2024-05-21'
        when property_reception_or_party_attended = 'Women in Cyber 2024 Nightcap'
        then date '2024-05-08'
        when property_reception_or_party_attended = 'Invisalign 2024 Brunch'
        then date '2024-05-08'
        when property_reception_or_party_attended = 'Women in Cyber 2024 Dinner'
        then date '2024-05-07'
        when
            property_reception_or_party_attended = '#Paid Cocktail Hour @ POSSIBLE 2025'
        then null
        when
            property_reception_or_party_attended
            = 'A Toast to Ten Cocktail Party @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_attended
            = 'Celebrating Women\'s Health Reception @ SXSW 2025'
        then null
        when
            property_reception_or_party_attended
            = 'Dentsu Cocktail Hour @ POSSIBLE 2025'
        then null
        when
            property_reception_or_party_attended
            = 'F1 The Academy Conversation and Celebration Reception @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_attended
            = 'Nightcap on the Rooftop Party @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_attended
            = 'RX Celebration XR Cocktail Party @ CES 2025'
        then null
        when
            property_reception_or_party_attended
            = 'The Future of Creator-Led Brands Reception @ SXSW 2025'
        then null
        when
            property_reception_or_party_attended
            = 'The Real World Advantage Conversation & Cocktails Reception @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_attended
            = 'Women Walk the Floor Tour @ MWC 2025'
        then null
        else null
    end as party_attended_date,
    case
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ @ Las Vegas Grand Prix 2026'
        then date '2026-11-20'
        when property_lounge_or_series_name = 'AI Summit 2026'
        then date '2026-11-10'
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ @ ANA Masters of Marketing 2026'
        then date '2026-10-21'
        when property_lounge_or_series_name = 'FQ Lounge™ @ Advertising Week 2026'
        then date '2026-10-05'
        when property_lounge_or_series_name = 'FQ Lounge™ during WNBA All-Star 2026'
        then date '2026-07-25'
        when property_lounge_or_series_name = 'FQ Lounge™ @ FIFA World Cup 2026'
        then date '2026-07-16'
        when property_lounge_or_series_name = 'Camp @ Cannes 2026'
        then date '2026-06-22'
        when
            property_lounge_or_series_name
            = 'FQ Beach @ Cannes Lions 2026 (FQ Lounge™ @ Cannes Lions 2026)'
        then date '2026-06-22'
        when property_lounge_or_series_name = 'FQ Rooftop @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_lounge_or_series_name
            = 'Solstice Leadership Forum during Cannes Lions 2026'
        then date '2026-06-21'
        when property_lounge_or_series_name = 'FQ Lounge™ @ Consensus 2026'
        then date '2026-05-05'
        when property_lounge_or_series_name = 'FQ Lounge™ @ Miami Grand Prix 2026'
        then date '2026-05-01'
        when property_lounge_or_series_name = 'FQ Lounge™ @ POSSIBLE 2026'
        then date '2026-04-27'
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ in Augusta 2026 (FQ Lounge™ during The Masters 2026)'
        then date '2026-04-09'
        when property_lounge_or_series_name = 'FQ Lounge™ @ SXSW 2026'
        then date '2026-03-14'
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ @ Mobile World Congress 2026'
        then date '2026-03-03'
        when property_lounge_or_series_name = 'FQ Lounge™ in Milan 2026'
        then date '2026-02-17'
        when property_lounge_or_series_name = 'FQ Lounge™ during Super Bowl LX 2026'
        then date '2026-02-06'
        when property_lounge_or_series_name = 'FQ Lounge™ @ Davos 2026'
        then date '2026-01-19'
        when
            property_lounge_or_series_name
            = 'Annual Women Walk the Floor Tour @ CES 2026'
        then date '2026-01-06'
        when property_lounge_or_series_name = 'FQ Lounge™ @ CES 2026'
        then date '2026-01-06'
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ @ Las Vegas Grand Prix 2025'
        then date '2025-11-21'
        when property_lounge_or_series_name = 'AI Summit 2025'
        then date '2025-11-12'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ ANA Masters of Marketing 2025'
        then date '2025-10-22'
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ @ ANA Masters of Marketing 2025'
        then date '2025-10-22'
        when property_lounge_or_series_name = 'Health Summit 2025'
        then date '2025-10-08'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Advertising Week 2025'
        then date '2025-10-06'
        when
            property_lounge_or_series_name
            = 'FQ Lounge™ @ Singapore Grand Prix 2025'
        then date '2025-10-03'
        when
            property_lounge_or_series_name = 'Equality Lounge® @ WNBA All-Star 2025'
        then date '2025-07-19'
        when property_lounge_or_series_name = 'FQ Lounge™ During WNBA All-Star 2025'
        then date '2025-07-19'
        when property_lounge_or_series_name = 'Equality Lounge® @ Cannes Lions 2025'
        then date '2025-06-15'
        when property_lounge_or_series_name = 'FQ Lounge™ @ SXSW London 2025'
        then date '2025-06-04'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Miami Grand Prix 2025'
        then date '2025-05-02'
        when property_lounge_or_series_name = 'Equality Lounge® @ POSSIBLE 2025'
        then date '2025-04-28'
        when
            property_lounge_or_series_name
            = 'Cyber Conversations & Connections during RSA 2025'
        then date '2025-03-30'
        when property_lounge_or_series_name = 'Equality Lounge® @ SXSW 2025'
        then date '2025-03-08'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Mobile World Congress 2025'
        then date '2025-03-04'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® During NBA All-Star 2025'
        then date '2025-02-15'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® At The Super Bowl 2025'
        then date '2025-02-07'
        when property_lounge_or_series_name = 'Equality Lounge® @ Davos 2025'
        then date '2025-01-20'
        when property_lounge_or_series_name = 'Equality Lounge® @ CES 2025'
        then date '2025-01-07'
        when
            property_lounge_or_series_name = 'Equality Lounge® @ AWS Re:Invent 2024'
        then date '2024-12-03'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Las Vegas Grand Prix 2024'
        then date '2024-11-22'
        when property_lounge_or_series_name = 'Women in AI Summit 2024'
        then date '2024-11-13'
        when property_lounge_or_series_name = 'Equality Lounge® @ COP29 2024'
        then date '2024-11-12'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ ANA Masters of Marketing 2024'
        then date '2024-10-23'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Advertising Week 2024'
        then date '2024-10-07'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Climate Week NYC 2024 (Equality Lounge® @ Climate Week 2024)'
        then date '2024-09-24'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Workday Rising 2024'
        then date '2024-09-18'
        when property_lounge_or_series_name = 'Equality Lounge® @ CloudWorld 2024'
        then date '2024-09-10'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Athleta\'s Power of She 2024'
        then date '2024-07-31'
        when property_lounge_or_series_name = 'Equality Lounge® @ Cannes Lions 2024'
        then date '2024-06-16'
        when property_lounge_or_series_name = 'Equality Lounge® @ HIMSS 2024'
        then date '2024-03-14'
        when property_lounge_or_series_name = 'Equality Lounge® @ SXSW 2024'
        then date '2024-03-09'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Mobile World Congress 2024'
        then date '2024-02-27'
        when property_lounge_or_series_name = 'Power of the Pack 2024'
        then date '2024-01-24'
        when property_lounge_or_series_name = 'Equality Lounge® @ Davos 2024'
        then date '2024-01-15'
        when property_lounge_or_series_name = 'Equality Lounge® @ CES 2024'
        then date '2024-01-09'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ JPM Healthcare Conference 2024'
        then date '2024-01-08'
        when property_lounge_or_series_name = 'Algorithm for Equality 2024'
        then date '2024-01-04'
        when property_lounge_or_series_name = 'The Money Quotient 2024'
        then date '2024-01-03'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ ANA Masters of Marketing 2023'
        then date '2023-10-25'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Advertising Week 2023'
        then date '2023-10-16'
        when property_lounge_or_series_name = 'Equality Lounge® @ Cannes Lions 2023'
        then date '2023-06-18'
        when property_lounge_or_series_name = 'Equality Lounge® @ SXSW 2023'
        then date '2023-03-11'
        when property_lounge_or_series_name = 'Equality Lounge® @ Davos 2023'
        then date '2023-01-16'
        when property_lounge_or_series_name = 'Equality Lounge® @ CES 2023'
        then date '2023-01-05'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ ANA Masters of Marketing 2022'
        then date '2022-10-26'
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ Advertising Week 2022'
        then date '2022-10-17'
        when property_lounge_or_series_name = 'Equality Lounge® @ Cannes Lions 2022'
        then date '2022-06-20'
        when property_lounge_or_series_name = 'Equality Lounge® @ SXSW 2022'
        then date '2022-03-12'
        when property_lounge_or_series_name = 'Equality Lounge® @ Davos 2022'
        then date '2022-01-17'
        when property_lounge_or_series_name = 'Equality Lounge® @ CES 2022'
        then null
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ F1 Academy Singapore 2024'
        then null
        when
            property_lounge_or_series_name
            = 'Equality Lounge® @ RSA Conference 2024'
        then null
        when
            property_lounge_or_series_name
            = 'Equality Lounge® During NVIDIA GTC 2025 (Equality Lounge® @ NVIDIA GTC 2025)'
        then null
        when property_lounge_or_series_name = 'FQ Lounge™ @ SXSW London 2026'
        then null
        when property_lounge_or_series_name = 'International Women\'s Day 2024'
        then null
        else null
    end as last_event_spoke_date,
    case
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ @ Las Vegas Grand Prix 2026'
        then date '2026-11-20'
        when property_lounge_or_series_rsvp_d = 'AI Summit 2026'
        then date '2026-11-10'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ @ ANA Masters of Marketing 2026'
        then date '2026-10-21'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ Advertising Week 2026'
        then date '2026-10-05'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ during WNBA All-Star 2026'
        then date '2026-07-25'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ FIFA World Cup 2026'
        then date '2026-07-16'
        when property_lounge_or_series_rsvp_d = 'Camp @ Cannes 2026'
        then date '2026-06-22'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Beach @ Cannes Lions 2026 (FQ Lounge™ @ Cannes Lions 2026)'
        then date '2026-06-22'
        when property_lounge_or_series_rsvp_d = 'FQ Rooftop @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_lounge_or_series_rsvp_d
            = 'Solstice Leadership Forum during Cannes Lions 2026'
        then date '2026-06-21'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ Consensus 2026'
        then date '2026-05-05'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ Miami Grand Prix 2026'
        then date '2026-05-01'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ POSSIBLE 2026'
        then date '2026-04-27'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ in Augusta 2026 (FQ Lounge™ during The Masters 2026)'
        then date '2026-04-09'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ SXSW 2026'
        then date '2026-03-14'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ @ Mobile World Congress 2026'
        then date '2026-03-03'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ in Milan 2026'
        then date '2026-02-17'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ during Super Bowl LX 2026'
        then date '2026-02-06'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ Davos 2026'
        then date '2026-01-19'
        when
            property_lounge_or_series_rsvp_d
            = 'Annual Women Walk the Floor Tour @ CES 2026'
        then date '2026-01-06'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ CES 2026'
        then date '2026-01-06'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ @ Las Vegas Grand Prix 2025'
        then date '2025-11-21'
        when property_lounge_or_series_rsvp_d = 'AI Summit 2025'
        then date '2025-11-12'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ ANA Masters of Marketing 2025'
        then date '2025-10-22'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ @ ANA Masters of Marketing 2025'
        then date '2025-10-22'
        when property_lounge_or_series_rsvp_d = 'Health Summit 2025'
        then date '2025-10-08'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Advertising Week 2025'
        then date '2025-10-06'
        when
            property_lounge_or_series_rsvp_d
            = 'FQ Lounge™ @ Singapore Grand Prix 2025'
        then date '2025-10-03'
        when
            property_lounge_or_series_rsvp_d = 'Equality Lounge® @ WNBA All-Star 2025'
        then date '2025-07-19'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ During WNBA All-Star 2025'
        then date '2025-07-19'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Cannes Lions 2025'
        then date '2025-06-15'
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ SXSW London 2025'
        then date '2025-06-04'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Miami Grand Prix 2025'
        then date '2025-05-02'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ POSSIBLE 2025'
        then date '2025-04-28'
        when
            property_lounge_or_series_rsvp_d
            = 'Cyber Conversations & Connections during RSA 2025'
        then date '2025-03-30'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ SXSW 2025'
        then date '2025-03-08'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Mobile World Congress 2025'
        then date '2025-03-04'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® During NBA All-Star 2025'
        then date '2025-02-15'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® At The Super Bowl 2025'
        then date '2025-02-07'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Davos 2025'
        then date '2025-01-20'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ CES 2025'
        then date '2025-01-07'
        when
            property_lounge_or_series_rsvp_d = 'Equality Lounge® @ AWS Re:Invent 2024'
        then date '2024-12-03'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Las Vegas Grand Prix 2024'
        then date '2024-11-22'
        when property_lounge_or_series_rsvp_d = 'Women in AI Summit 2024'
        then date '2024-11-13'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ COP29 2024'
        then date '2024-11-12'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ ANA Masters of Marketing 2024'
        then date '2024-10-23'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Advertising Week 2024'
        then date '2024-10-07'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Climate Week NYC 2024 (Equality Lounge® @ Climate Week 2024)'
        then date '2024-09-24'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Workday Rising 2024'
        then date '2024-09-18'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ CloudWorld 2024'
        then date '2024-09-10'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Athleta\'s Power of She 2024'
        then date '2024-07-31'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Cannes Lions 2024'
        then date '2024-06-16'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ HIMSS 2024'
        then date '2024-03-14'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ SXSW 2024'
        then date '2024-03-09'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Mobile World Congress 2024'
        then date '2024-02-27'
        when property_lounge_or_series_rsvp_d = 'Power of the Pack 2024'
        then date '2024-01-24'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Davos 2024'
        then date '2024-01-15'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ CES 2024'
        then date '2024-01-09'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ JPM Healthcare Conference 2024'
        then date '2024-01-08'
        when property_lounge_or_series_rsvp_d = 'Algorithm for Equality 2024'
        then date '2024-01-04'
        when property_lounge_or_series_rsvp_d = 'The Money Quotient 2024'
        then date '2024-01-03'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ ANA Masters of Marketing 2023'
        then date '2023-10-25'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Advertising Week 2023'
        then date '2023-10-16'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Cannes Lions 2023'
        then date '2023-06-18'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ SXSW 2023'
        then date '2023-03-11'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Davos 2023'
        then date '2023-01-16'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ CES 2023'
        then date '2023-01-05'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ ANA Masters of Marketing 2022'
        then date '2022-10-26'
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ Advertising Week 2022'
        then date '2022-10-17'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Cannes Lions 2022'
        then date '2022-06-20'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ SXSW 2022'
        then date '2022-03-12'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ Davos 2022'
        then date '2022-01-17'
        when property_lounge_or_series_rsvp_d = 'Equality Lounge® @ CES 2022'
        then null
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ F1 Academy Singapore 2024'
        then null
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® @ RSA Conference 2024'
        then null
        when
            property_lounge_or_series_rsvp_d
            = 'Equality Lounge® During NVIDIA GTC 2025 (Equality Lounge® @ NVIDIA GTC 2025)'
        then null
        when property_lounge_or_series_rsvp_d = 'FQ Lounge™ @ SXSW London 2026'
        then null
        when property_lounge_or_series_rsvp_d = 'International Women\'s Day 2024'
        then null
        else null
    end as lounge_series_rsvpd_date,
    case
        when
            property_reception_or_party_rsvp_d
            = 'Health at the Speed of Insight Real Chemistry Cocktail Hour during Cannes 2026'
        then date '2026-06-25'
        when
            property_reception_or_party_rsvp_d
            = 'Creative Chemistry Adobe Creators Conversation & Cocktails during Cannes 2026'
        then date '2026-06-25'
        when
            property_reception_or_party_rsvp_d
            = 'Future-Forward CMOs Adobe Roundtable during Cannes 2026'
        then date '2026-06-25'
        when
            property_reception_or_party_rsvp_d
            = 'Ladies Night Out @ Cannes Lions 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_rsvp_d
            = 'WNBA Unstoppable Conversation & Cocktails during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_rsvp_d
            = 'Better Together AWS/BCG Cocktail Hour during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_rsvp_d
            = 'Rewriting the Rules of B2B Marketing Adobe Roundtable during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_rsvp_d
            = 'Meeting in the Middle ADWEEK/EY Roundtable during Cannes 2026'
        then date '2026-06-24'
        when
            property_reception_or_party_rsvp_d
            = 'Ten to One Afterhours Party @ Cannes Lions 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_rsvp_d
            = 'Above the Croisette Databricks Cocktail Hour during Cannes 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_rsvp_d
            = 'Unwell Beach Party @ Cannes Lions 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_rsvp_d
            = 'Scaling the AI Opportunity Monks AWS Roundtable @ Cannes Lions 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_rsvp_d
            = 'Connected by Care: A Healthcare Marketing Brunch @ Cannes 2026'
        then date '2026-06-23'
        when
            property_reception_or_party_rsvp_d
            = 'The Power of Experiential Connection Sparks Cocktail Hour @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_reception_or_party_rsvp_d
            = 'AI In Action Networking Reception @ Cannes Lions 2026'
        then date '2026-06-22'
        when
            property_reception_or_party_rsvp_d
            = 'Meta Creators & Friends Meetup during Cannes 2026'
        then date '2026-06-22'
        when
            property_reception_or_party_rsvp_d
            = 'Leading Through the Unknown AWS Roundtable Lunch during Cannes 2026'
        then date '2026-06-22'
        when property_reception_or_party_rsvp_d = 'Cannes Lions Kick-Off Dinner 2026'
        then date '2026-06-21'
        when
            property_reception_or_party_rsvp_d
            = 'Conversation & Cocktails Following AWS Partner Summit NYC 2026'
        then date '2026-06-16'
        when property_reception_or_party_rsvp_d = 'Shamrock Dinner in NYC 2026'
        then date '2026-06-04'
        when
            property_reception_or_party_rsvp_d
            = 'B2B Marketing Leaders Dinner in NYC 2026'
        then date '2026-05-12'
        when
            property_reception_or_party_rsvp_d
            = 'Celebrating The Future Of Women\'s Sports During Milken Global Conference 2026'
        then date '2026-05-05'
        when property_reception_or_party_rsvp_d = 'AWS Brunch during F1 Miami 2026'
        then date '2026-05-02'
        when
            property_reception_or_party_rsvp_d
            = 'B2B Marketing Leaders Dinner @ POSSIBLE 2026'
        then date '2026-04-28'
        when
            property_reception_or_party_rsvp_d = '#Paid Cocktail Hour @ POSSIBLE 2026'
        then date '2026-04-27'
        when
            property_reception_or_party_rsvp_d
            = 'Dinner & Dialogue Cognitiv Dinner in Los Angeles 2026'
        then date '2026-04-22'
        when
            property_reception_or_party_rsvp_d
            = 'Where Commerce Meets Influence Trade Desk Dinner @ Shoptalk 2026'
        then date '2026-03-25'
        when
            property_reception_or_party_rsvp_d
            = 'An Intimate Leadership Salesforce Dinner @ SXSW 2026'
        then date '2026-03-14'
        when
            property_reception_or_party_rsvp_d
            = 'Dinner & Dialogue Cognitiv Dinner in Chicago 2026'
        then date '2026-03-11'
        when
            property_reception_or_party_rsvp_d
            = 'Power Play: From Milan to LA28 Games @ Milan Olympics 2026'
        then date '2026-02-18'
        when
            property_reception_or_party_rsvp_d
            = 'Sensor Tower Cocktail Hour @ CES 2026'
        then date '2026-01-07'
        when
            property_reception_or_party_rsvp_d
            = 'Leading AI-Fueled Marketing Transformation AWS Dinner @ CES 2026'
        then date '2026-01-06'
        when
            property_reception_or_party_rsvp_d = 'Salesforce Cocktail Hour @ CES 2026'
        then date '2026-01-06'
        when
            property_reception_or_party_rsvp_d
            = 'Bridging the Gap MiQ / IPG Healthcare Dinner 2025'
        then date '2025-12-08'
        when
            property_reception_or_party_rsvp_d
            = 'Cheers to What\'s Next Executive Nightcap @ AWS re:Invent 2025'
        then date '2025-12-03'
        when
            property_reception_or_party_rsvp_d
            = 'Cocktails Connections & Conversations Partner Reception @ AWS re:Invent 2025'
        then date '2025-12-03'
        when
            property_reception_or_party_rsvp_d
            = 'Leaders Who Lunch @ AWS re:Invent 2025'
        then date '2025-12-02'
        when
            property_reception_or_party_rsvp_d
            = 'The Ascend Series Nashville Amex & Delta Reception 2025'
        then date '2025-11-19'
        when
            property_reception_or_party_rsvp_d
            = 'The Ascend Series Seattle Amex & Delta Reception 2025'
        then date '2025-11-13'
        when
            property_reception_or_party_rsvp_d
            = 'The Ascend Series New York Amex & Delta Reception 2025'
        then date '2025-11-06'
        when
            property_reception_or_party_rsvp_d
            = 'Celebrating Leaders in Cyber Reception 2025'
        then date '2025-11-03'
        when
            property_reception_or_party_rsvp_d
            = 'The Power Table Breakfast @ Dreamforce 2025'
        then date '2025-10-15'
        when
            property_reception_or_party_rsvp_d
            = 'AI Roundtable Breakfast AWS @ Advertising Week 2025'
        then date '2025-10-08'
        when
            property_reception_or_party_rsvp_d
            = 'The Marketing Edit Rokt Dinner @ Advertising Week 2025'
        then date '2025-10-07'
        when property_reception_or_party_rsvp_d = 'Lead Forward Reception 2025'
        then date '2025-09-30'
        when
            property_reception_or_party_rsvp_d
            = 'Where Innovation Meets Influence Dinner 2025'
        then date '2025-09-29'
        when
            property_reception_or_party_rsvp_d
            = 'Brunch Celebrating Women Shaping Emmys 2025'
        then date '2025-09-12'
        when property_reception_or_party_rsvp_d = 'Women on the Rise Boston 2025'
        then date '2025-09-09'
        when
            property_reception_or_party_rsvp_d
            = 'Celebrating the Power of Multigenerational Workplaces AARP Dinner 2025'
        then date '2025-07-16'
        when
            property_reception_or_party_rsvp_d
            = 'Flow Leadership: The Time is Now Reception 2025'
        then date '2025-07-15'
        when
            property_reception_or_party_rsvp_d
            = 'Women Who Lead the Way Lunch @ Cannes Lions 2025'
        then date '2025-06-17'
        when
            property_reception_or_party_rsvp_d
            = 'Women on the Rise: Power Forward Reception 2025'
        then date '2025-05-19'
        when
            property_reception_or_party_rsvp_d
            = 'Broken Rung San Francisco Reception 2025'
        then date '2025-05-13'
        when property_reception_or_party_rsvp_d = 'Salon Dinner @ POSSIBLE 2025'
        then date '2025-04-28'
        when
            property_reception_or_party_rsvp_d
            = 'Trailblazers in Tech: A Dinner Celebrating Women Leaders 2025'
        then date '2025-03-19'
        when
            property_reception_or_party_rsvp_d
            = 'Hitachi Vantara An Evening of Connection Reception 2025'
        then date '2025-03-18'
        when
            property_reception_or_party_rsvp_d
            = 'The Broken Rung: Book Launch and Reception 2025'
        then date '2025-03-11'
        when
            property_reception_or_party_rsvp_d
            = 'Mobile World Congress Kick-Off Dinner 2025'
        then date '2025-03-03'
        when
            property_reception_or_party_rsvp_d
            = 'Power Play Conversation & Cocktails @ Davos 2025'
        then date '2025-01-22'
        when
            property_reception_or_party_rsvp_d
            = 'A Toast to Women\'s Health Reception @ Davos 2025'
        then date '2025-01-21'
        when
            property_reception_or_party_rsvp_d
            = 'The Visionary Table Dinner @ CES 2025'
        then date '2025-01-07'
        when
            property_reception_or_party_rsvp_d
            = 'Annual Women Walk the Floor Tour @ CES 2025'
        then date '2025-01-07'
        when
            property_reception_or_party_rsvp_d
            = 'Raise a Glass: CES Leaders Kick Off Reception 2025'
        then date '2025-01-06'
        when
            property_reception_or_party_rsvp_d
            = 'Soar Higher: Celebrating Women Entrepreneurs 2024'
        then date '2024-11-19'
        when
            property_reception_or_party_rsvp_d
            = 'Women in AI Summit Kick-off Dinner 2024'
        then date '2024-11-12'
        when
            property_reception_or_party_rsvp_d
            = 'Female Founders\' Table Dinner & Reception 2024'
        then date '2024-10-24'
        when
            property_reception_or_party_rsvp_d
            = 'Money Date: Wine & Goal Setting Amex Reception 2024'
        then date '2024-10-17'
        when
            property_reception_or_party_rsvp_d
            = 'Beyond the Feed: Creators as Entrepreneurs Event 2024'
        then date '2024-10-09'
        when
            property_reception_or_party_rsvp_d
            = 'Elevate Your Network: An Evening of Connection Delta Dinner 2024 ()'
        then date '2024-10-08'
        when property_reception_or_party_rsvp_d = 'Women on The Rise NYC 2024'
        then date '2024-09-30'
        when
            property_reception_or_party_rsvp_d
            = 'Driving Equality: Women Leading the Charge Singapore Brunch 2024'
        then date '2024-09-20'
        when
            property_reception_or_party_rsvp_d
            = 'Breakfast Celebrating Women in Cyber 2024'
        then date '2024-09-17'
        when
            property_reception_or_party_rsvp_d
            = 'Women Leaders Brunch during Veecon 2024 (Women Leaders Brunch during Veecon)'
        then date '2024-08-11'
        when property_reception_or_party_rsvp_d = 'Athleta Power of She Brunch 2024'
        then date '2024-07-28'
        when
            property_reception_or_party_rsvp_d
            = 'Maximizing Your Money AMEX Reception 2024'
        then date '2024-07-17'
        when property_reception_or_party_rsvp_d = 'DVF Documentary Event 2024'
        then date '2024-07-03'
        when property_reception_or_party_rsvp_d = 'Delta 2024 Reception'
        then date '2024-05-21'
        when property_reception_or_party_rsvp_d = 'Women in Cyber 2024 Nightcap'
        then date '2024-05-08'
        when property_reception_or_party_rsvp_d = 'Invisalign 2024 Brunch'
        then date '2024-05-08'
        when property_reception_or_party_rsvp_d = 'Women in Cyber 2024 Dinner'
        then date '2024-05-07'
        when
            property_reception_or_party_rsvp_d = '#Paid Cocktail Hour @ POSSIBLE 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'A Toast to Ten Cocktail Party @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'Celebrating Women\'s Health Reception @ SXSW 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'Dentsu Cocktail Hour @ POSSIBLE 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'F1 The Academy Conversation and Celebration Reception @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'Nightcap on the Rooftop Party @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'RX Celebration XR Cocktail Party @ CES 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'The Future of Creator-Led Brands Reception @ SXSW 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'The Real World Advantage Conversation & Cocktails Reception @ Cannes Lions 2025'
        then null
        when
            property_reception_or_party_rsvp_d
            = 'Women Walk the Floor Tour @ MWC 2025'
        then null
        else null
    end as reception_party_rsvpd_date,
    is_submitted_form,
    form_submitted_at

from {{ source('hubspot', 'contact') }} as cn
left join
    {{ ref("stg_hb_companies") }} as co
    on cn.property_associatedcompanyid = co.company_id
left join {{ref("stg_hb_contact_form_submission")}} as fo on cn.id =fo.contact_id
where property_zoominfo_match_status not in ('INVALID_INPUT', 'SERVICE_ERROR')

--     ),

--     lounge_attended as (
--         select lounge_name, lounge_attend_date as lounge_attended_date

--         from {{ ref("stg_lounge_dates") }}
--     ),

--     lounge_rsvpd as (
--         select lounge_name, lounge_attend_date as lounge_series_rsvpd_date

--         from {{ ref("stg_lounge_dates") }}

--     ),

--     party_attended as (
--         select event_name, party_date as party_attended_date

--         from {{ ref("stg_party_dates") }}
--     ),

--     party_rsvpd as (
--         select event_name, party_date as reception_party_rsvpd_date

--         from {{ ref("stg_party_dates") }}
--     ),

--     speaker_info as (
--         select lounge_name, lounge_attend_date as last_event_spoke_date
--         from {{ ref("stg_lounge_dates") }}

--     )

-- select
--     cn.*,
--     lounge_attended_date,
--     lounge_series_rsvpd_date,
--     party_attended_date,
--     reception_party_rsvpd_date,
--     last_event_spoke_date

-- from contacts as cn
-- left join lounge_attended as la on cn.lounge_or_series_attended = la.lounge_name
-- left join lounge_rsvpd as lr on cn.lounge_or_series_rsvpd = lr.lounge_name
-- left join speaker_info as si on cn.lounge_or_series_name = si.lounge_name
-- left join party_attended as pa on cn.reception_or_party_attended = pa.event_name
-- left join
--     party_rsvpd as pr on cn.reception_or_party_rsvpd = pr.event_name


select
    lounge_name_hubspot as lounge_name, PARSE_DATE('%m/%d/%Y', lounge_create_date) AS lounge_attend_date 

from {{ source('sheets', 'lounge_dates') }}
where lounge_create_date <> 'Date'

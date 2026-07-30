select
    party_lounge as lounge_name,
    lounge_name as event_name,
    parse_date('%m/%d/%Y', party_date) as party_date

from {{ source('sheets', 'party_dates') }}
where party_date <> 'Date/Time'

{{
    config(
        materialized = 'table'
    )
}}

with users as (
    SELECT * from {{ ref('stg_greenery_users') }}
)

, addresses as (
    select * from {{ ref('stg_greenery_addresses') }}
)

SELECT
     u.user_guid
    , u.created_at
    , u.updated_at
    , u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , a.address
    , a.zipcode
    , a.state
    , a.country
from users u
join addresses a ON 
    u.address_guid = a.address_guid
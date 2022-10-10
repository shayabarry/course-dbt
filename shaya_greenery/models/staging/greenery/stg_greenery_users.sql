{{
    config(
        MATERIALIZED = 'VIEW'
        , unique_key = 'user_guid'
    )
}}

with user_source as (
    select * from {{ source ('src_greenery', 'users')}}
)

, renamed_casted as (
    SELECT
    user_id as user_guid
    , first_name
    , last_name
    , email
    , phone_number
    , created_at
    , updated_at
    , address_id as address_guid
    from user_source
)

select * from renamed_casted
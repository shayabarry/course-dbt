{{
    config(
        MATERIALIZED = 'VIEW'
        , unique_key = 'address_guid'
    )
}}

with addresses_source as (
    select * from {{ source ('src_greenery', 'addresses')}}
)

, renamed_casted as (
    SELECT
    address_id as address_guid
    , address 
    , zipcode::varchar as zipcode
    , state
    , country
    from addresses_source
)

select * from renamed_casted
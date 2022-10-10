{{
    config(
        MATERIALIZED = 'VIEW'
        , unique_key = 'promo_guid'
    )
}}

with promo_source as (
    select * from {{ source ('src_greenery', 'promos')}}
)

, renamed_casted as (
    SELECT
    promo_id as promo_guid
    , discount
    , status
    from promo_source
)

select * from renamed_casted
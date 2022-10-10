{{
    config(
        MATERIALIZED = 'VIEW'
        , unique_key = 'product_guid'
    )
}}

with product_source as (
    select * from {{ source ('src_greenery', 'products')}}
)

, renamed_casted as (
    SELECT
    product_id as product_guid
    , name
    , price
    , inventory
    FROM product_source
)

select * from renamed_casted
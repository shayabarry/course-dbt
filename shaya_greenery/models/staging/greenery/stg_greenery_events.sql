{{
    config(
        MATERIALIZED = 'VIEW'
        , unique_key = 'event_guid'
    )
}}

with events_source as (
    select * from {{ source ('src_greenery', 'events')}}
)

, renamed_casted as (
    SELECT
    event_id as event_guid
    , session_id as session_guid
    , user_id as user_guid
    , page_url
    , created_at as created_at_utc
    , event_type
    , order_id as order_guid
    , product_id as product_guid
    from events_source
)

select * from renamed_casted
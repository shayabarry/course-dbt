{{
    config(
        materialized = 'table'
    )
}}

with events as (
    select * from {{ ref('stg_greenery_events') }}
)

, final as (
    SELECT
    user_guid
    , session_id
    , sum(case when event_type = 'add_to_cart' then 1 else 0) as add_to_carts
    , sum(case when event_type = 'checkout' then 1 else 0) as checkouts
    , sum(case when event_type = 'package_shipped' then 1 else 0) as package_shippeds
    , sum(case when event_type = 'page_view' then 1 else 0) as page_views
    FROM events
    group by 1, 2
)

select * from final
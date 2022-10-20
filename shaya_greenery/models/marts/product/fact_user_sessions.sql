{{
    config(
        materialized = 'table'
    )
}}

with session_length as (
    select 
    session_guid
    , min(created_at) as first_event
    , max(created_at) as last_event
from {{ ref('stg_greenery_events')}}
group by 1
)

, session_events_agg as (
    select * from {{ ref('int_session_events_agg') }}
)

, users as (
    select * from {{ ref('stg_greenery_users') }}
)

SELECT

     sa.session_guid
    , sa.user_guid
    , sa.checkouts
    , sa.add_to_carts
    , sa.package_shippeds
    , sa.page_views
    , sl.first_event
    , sl.last_event
    , datediff('minute', session_length.first_event, session_length.last_event) as session_length_minutes
FROM session_events_agg as sa 
left join users as u 
    on sa.user_guid = u.user_guid
left join session_length as sl
    on sl.session_guid = sa.session_guid
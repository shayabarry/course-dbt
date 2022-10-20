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
    select * from int_session_events_agg
)

SELECT

{{
    config(
        materialized = 'table'
    )
}}

with orders as (
    SELECT * from {{ ref('stg_greenery_orders') }}
) 

, promos as (
    select * from {{ ref('stg_greenery_promos') }}
)

, addresses as (
    select * from {{ ref('stg_greenery_addresses') }}
)

, users as (
    select * from {{ ref('stg_greenery_users') }}
)

select 
    o.order_guid
    , o.user_guid
    , o.order_cost
    , o.shipping_cost
    , o.order_total_cost
    , o.order_status
    , o.promo_desc
    , o.created_at_utc
    , o.estimataed_delivery_at_utc
    , o.delivered_at_utc
    , p.discount
    , p.status as promo_status
    , a.zipcode
    , a.state
    , a.country
from orders as o
left join promos as p on 
    o.promo_desc = p.promo_guid
left join users as u on
     u.user_guid = o.user_guid
left join addresses as a on 
    a.address_guid = o.address_guid
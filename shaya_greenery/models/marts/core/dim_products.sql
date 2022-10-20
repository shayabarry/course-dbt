{{
    config(
        materialized = 'table'
    )
}}

with products as (
    SELECT * from {{ ref('stg_greenery_products') }}
)

, order_items as (
    select * from {{ ref('stg_greenery_order_items') }}
)

, orders as (
    select * from {{ ref('stg_greenery_orders') }}
)
, product_orders as (
    SELECT
    product_guid
    , sum(quantity) as total_product_quantity
    , max(delivered_at_utc) as max_product_delivered_at
    , sum(order_total_cost) as total_product_cost 
    from order_items as oi
    join orders as o on 
        o.order_guid = oi.order_guid
    group by 1
)

SELECT
     prod.product_guid
     , prod.name
     , prod.price
     , prod.inventory
     , po.total_product_quantity
     , po.max_product_delivered_at
     , po.total_product_quantity * prod.price as total_product_revenue
     , (po.total_product_quantity * prod.price) - (total_product_cost) as total_product_profit 
FROM products as prod
left join product_orders as po on 
    prod.product_guid = po.product_guid

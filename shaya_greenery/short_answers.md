Question 1:
select count(*) from dev_db.dbt_shayabarry.stg_greenery_users;
130

Question 2:
select avg(a.num_orders_per_hour) from (
select 
    hour(created_at_utc) as hours,
    count(*) as num_orders_per_hour
from dev_db.dbt_shayabarry.stg_greenery_orders
where order_status = 'delivered'
group by 1
order by 1 ) a
;
12.7

Question 3: 
select avg(datediff(day, created_at_utc, delivered_at_utc)) as avg_time from dev_db.dbt_shayabarry.stg_greenery_orders;
3.89 days

Question 4: 
select count(*) from (select user_guid, count(*) from dev_db.dbt_shayabarry.stg_greenery_orders group by 1 having count(*) = 1);
25
select count(*) from (select user_guid, count(*) from dev_db.dbt_shayabarry.stg_greenery_orders group by 1 having count(*) = 2);
28
select count(*) from (select user_guid, count(*) from dev_db.dbt_shayabarry.stg_greenery_orders group by 1 having count(*) > 2);
71

Question 5:
with uniques_sessions as (
    select hours, count(session_guid) as count_sessions from (
select
hour(created_at_utc) as hours
,session_guid
, count(*)
from dev_db.dbt_shayabarry.stg_greenery_events 
group by 1, 2)
group by 1)
select avg(count_sessions) from uniques_sessions;

Answer - 39

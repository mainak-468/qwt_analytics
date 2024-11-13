/*{{ config(materialized = 'incremental', unique_key = ['OrderId', 'LineNo']) }}

select
od.*
from
{{source('qwt_raw', 'orders')}} as o inner join
{{source("qwt_raw", 'orderdetails')}} od
on o.OrderId = od.OrderId

{% if is_incremental() %}

    where o.OrderDate > (select max(OrderDate) from {{ref('stg_orders')}})

{% endif %}*/

-- depends_on: {{ ref('stg_orders') }}

{{ config(materialized = 'incremental', unique_key = ['orderid', 'lineno'], schema = env_var('DBT_STAGESCHEMA', 'STAGING')) }}
 
select
 
od.*,
o.orderdate as orderdate
 
from
 
{{source('qwt_raw', 'orders')}} as o inner join
 
{{source('qwt_raw', 'orderdetails')}} as od
 
on o.orderid = od.orderid
 
{% if is_incremental() %}
 
  -- this filter will only be applied on an incremental run
  where orderdate > (select max(orderdate) from stg_orders)
 
{% endif %}
{{config(materialized = 'view', schema = 'reporting')}}

select 
COMPANYNAME, 
CONTACTNAME,
SUM(o.LINESALESAMOUNT) as Sales, 
SUM(o.QUANTITY) as Total_Orders, 
AVG(o.margin) as Avg_Margin
FROM {{ref("dim_customers")}} c inner join {{ref('fct_orders')}} o
on c.customerid = o.customerid
WHERE c.CITY = {{ var('v_city', "'London'") }}
GROUP BY 1, 2
ORDER BY Sales DESC 

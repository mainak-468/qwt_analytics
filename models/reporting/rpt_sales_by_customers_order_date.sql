{{ config(materialized = 'view', schema = 'reporting') }}

with customers as
(
    select
    customerid, CompanyName, ContactName, City
    from {{ref("dim_customers")}}
),

orders as
(
    select customerid, quantity, linesalesamount, orderdate
    from {{ref("fct_orders")}}
),

customers_orders as
(
    select
    customers.CompanyName as CompanyName, 
    customers.ContactName as ContactName,
    customers.City as City,
    min(orders.orderdate) as first_order_date,
    max(orders.orderdate) as recent_order_date,
    sum(orders.quantity) as total_orders,
    sum(orders.linesalesamount) as total_sales
    from customers inner join orders on customers.customerid = orders.customerid
    group by 1, 2, 3
    order by total_sales desc
)

select * from customers_orders
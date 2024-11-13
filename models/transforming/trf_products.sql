{{ config(materialized = 'table', schema = 'transforming') }}
 
select
p.productid,
p.productname,
s.CompanyName,
s.ContactName,
s.city,
c.categoryname,
p.quantityperunit,
p.unitcost,
p.unitprice,
p.unitsinstock,
p.unitsonorder,
IFF(p.unitsonorder > p.unitsinstock, 'Product Not Available', 'Product is Available') as productavailability,
(p.unitprice - p.unitcost) as profit
 
from
 
{{ref("stg_products")}}  as p inner join {{ref('trf_suppliers')}} as s
on p.SupplierID = s.SupplierID inner join {{ref('lkp_categories')}} as c
on p.categoryid = c.categoryid
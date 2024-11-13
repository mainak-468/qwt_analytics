{{config(materialized='incremental',unique_key='OrderID', schema = env_var('DBT_STAGESCHEMA', 'STAGING'))}}
select
*
From
{{source('qwt_raw','orders')}}
{% if is_incremental() %}
--this filter will only be applied on the incremental run
where orderdate>(select max(orderdate) from {{this}})
{% endif %}
 

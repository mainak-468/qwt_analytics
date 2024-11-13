{% macro grant_select(role) %}
{% set sql %}
    grant usage on warehouse DBT_QUERIES to role {{ role }};
    grant usage on database QWT_ANALYTICS to role {{ role }};
    grant usage on schema QWT_ANALYTICS.staging to role {{ role }};
    grant select on all tables in schema QWT_ANALYTICS.staging to role {{ role }};
    grant select on all views in schema QWT_ANALYTICS.staging to role {{ role }};
{% endset %}
 
{% do run_query(sql) %}
{% do log("Privileges granted", info=True) %}
{% endmacro %}
 
 
{% macro portable_google_sheets(source_name, source_table, include_metadata=True, keep_sort=False) %}

{%- set json_column_query -%}

select 
header.value::text  AS COLUMN_NAME
from
{{ source(source_name, source_table) }},
LATERAL FLATTEN( rowdata ) header
where id = 0
{%- endset -%}

{% set results = run_query(json_column_query) %}

{%- if execute -%}
{# Return the first column #}
{% set results_list = results.columns[0].values() %}
{% else %}
{% set results_list = [] %}
{%- endif -%}

{# we need a work around in case the data has a column called "ID", it cannot conflict with the portable ID column #}
{# Since we don't know if the user will "include meta" and sort, it is easiest two break it up into two CTEs #}
{# Otherwise Snowfalke will sort on the wrong ID column if you do not "include meta" #}
with
include_meta as(
select

{% for column_name in results_list -%}
rowdata[{{ loop.index0 }}]::text as {{ column_name }},

{% endfor %}
       
ID AS _PORTABLE_ID,  -- must rename incase data has a column called ID 
_PORTABLE_EXTRACTED

from
{{ source(source_name, source_table) }}
WHERE _PORTABLE_ID != 0 -- header row
{% if  keep_sort -%}
order by _PORTABLE_ID
{%- endif -%}

),

exclude_meta as (
        select *  exclude (_portable_id, _portable_extracted) from include_meta
)


{% if include_metadata -%}

select * from include_meta

{% else %}

select * from exclude_meta

{%- endif %} 


{% endmacro %}

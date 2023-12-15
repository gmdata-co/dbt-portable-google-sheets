{% macro portable_google_sheets(source_name, source_table) %}

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


select
ID AS _PORTABLE_ID,
{% for column_name in results_list -%}
rowdata[{{ loop.index0 }}]::text as {{ column_name }}{% if not loop.last -%}, {% endif %}
{% endfor %},
        _PORTABLE_EXTRACTED
from
{{ source(source_name, source_table) }}
WHERE _PORTABLE_ID != 0
order by id
{% endmacro %}

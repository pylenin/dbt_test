
{% macro date_transformation(column_name) %}
    TO_CHAR({{column_name}}::date, 'YYYY/MM/DD')
{% endmacro %}



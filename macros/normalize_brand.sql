{% macro normalize_brand(column_name) %}
    LOWER(TRIM(REGEXP_REPLACE({{ column_name }}, '[^a-zA-Z0-9 ]', '')))
{% endmacro %}
